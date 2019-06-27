package tems.com.edu.course.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tems.com.common.Criteria;
import tems.com.edu.common.model.AllChangeCodeVO;
import tems.com.edu.common.service.impl.CommonDAO;
import tems.com.edu.course.model.CertificateVO;
import tems.com.edu.course.model.CourseEnrollVO;
import tems.com.edu.course.model.CourseVO;
import tems.com.edu.course.model.EnrollInfoVO;
import tems.com.edu.course.model.EnrollMemberVO;
import tems.com.edu.course.model.EnrollStateVO;
import tems.com.edu.course.model.EstimateVO;
import tems.com.edu.course.model.GradeVO;
import tems.com.edu.course.model.ReceiptVO;
import tems.com.edu.course.model.SubjectVO;
import tems.com.edu.course.service.CourseListService;
import tems.com.edu.pay.model.PayVO;
import tems.com.edu.pay.service.impl.PayListDAO;

@Service("courseListService")
public class CourseListServiceImpl implements CourseListService {

	@Resource(name = "courseListDAO")
	private CourseListDAO courseListDAO;

	@Resource(name = "payListDAO")
	private PayListDAO payListDAO;

	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;

	
	//교육훈련삭제
	public void deleteCourse(String cosID) {

		courseListDAO.deleteCourse(cosID);
	}
	



	//평가관리
	@Override
	public void updateGrade(GradeVO gradeVO) throws Exception {
		System.out.println(gradeVO.toString());
		String gradeID = gradeVO.getGradeID();
		
		if(gradeID.equals("")){// 최초등록
			courseListDAO.insertGrade(gradeVO);
		}
		else{//업데이트
			courseListDAO.updateGrade(gradeVO);
		}
		 
	}

	//접수증관리

	
	//접수상태 일괄변경
	@Override
	public void updateEnrollStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception {
		String enrollState = allChangeCodeVO.getCodeID();
		String[] enrollIDList = allChangeCodeVO.getChkedList();
		String adminID = allChangeCodeVO.getAdminID();
		
		//접수상태 변경(공통작업)
		courseListDAO.updateEnrollStateAll(allChangeCodeVO);
		
		//접수상태가 접수완료(2)인경우  
		//견적서 발급, 결제상태 결제대기중(2)으로 변경
		if(enrollState.equals("2")){

			for (int i = 0; i < enrollIDList.length; i++) {
				//견적서 발급
				int cntEstimate = courseListDAO.listEstimate(enrollIDList[i]).size(); //발급된 견적서 확인
				if( cntEstimate==0 ){ //발급된견적서 없으면 발급
					EstimateVO estimateVO = new EstimateVO();
					estimateVO.setEnrollID(enrollIDList[i]);
					estimateVO.setIssueID(adminID);
					courseListDAO.insertEstimate(estimateVO);
				}
				
				//결제상태 결제확인중(2)으로 변경
				PayVO payVO = new PayVO();
				payVO.setEnrollID(enrollIDList[i]);
				payVO.setPayState("2");
				payListDAO.updatePayState(payVO);			
			} //.for	
		}//.if
		
	}
	
	
	//접수상태 1개 변경
	@Transactional
	@Override
	public void updateEnrollState(EnrollStateVO enrollStateVO) throws Exception {
		String enrollID = enrollStateVO.getEnrollID();
		String enrollState = enrollStateVO.getEnrollState();
		String adminID = enrollStateVO.getAdminID();
		
		//접수상태 변경(공통작업)
		courseListDAO.updateEnrollState(enrollStateVO);

		//접수상태 2일때
		if(enrollState.equals("2")){
			//견적서 발급
			int cntEstimate = courseListDAO.listEstimate(enrollID).size(); //발급된 견적서 확인
			if( cntEstimate==0 ){ //발급된견적서 없으면 발급
				EstimateVO estimateVO = new EstimateVO();
				estimateVO.setEnrollID(enrollID);
				estimateVO.setIssueID(adminID);
				courseListDAO.insertEstimate(estimateVO);
			}
			
			//결제상태를 결제확인중(2) 으로 변경해줌
			PayVO payVO = new PayVO();
			payVO.setEnrollID(enrollID);
			payVO.setPayState("2");
			payListDAO.updatePayState(payVO);
		}//.if
	
	}

	
	//수료증관련
	@Override
	public CertificateVO selectCertificate(String enrollID) throws Exception {

		return courseListDAO.selectCertificate(enrollID);
	}

	//평가관련
	@Override
	public GradeVO selectGrade(String enrollID) throws Exception {

		return courseListDAO.selectGrade(enrollID);
	}

	//접수증관련
	@Override
	public ReceiptVO selectReceipt(String enrollID) throws Exception {

		return courseListDAO.selectReceipt(enrollID);
	}

	//훈련생별 접수정보
	@Override
	public CourseEnrollVO selectCourseEnroll(String enrollID) throws Exception {

		return courseListDAO.selectCourseEnroll(enrollID);
	}

	@Override
	public EnrollInfoVO selectEnrollInfo(String enrollID) throws Exception {

		return courseListDAO.selectEnrollInfo(enrollID);
	}

	@Override
	public List<EnrollMemberVO> listEnrollMember(String cosID, Criteria cri) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cosID", cosID);
		map.put("cri", cri);

		return courseListDAO.listEnrollMember(map);
	}

	@Override
	public void updateCourse(CourseVO courseVO) throws Exception {

		courseListDAO.updateCourse(courseVO);
	}

	@Override
	public CourseVO selectCourse(String cosID) throws Exception {

		return courseListDAO.selectCourse(cosID);
	}

	@Override
	public int selectCourseTotCnt(Criteria cri) throws Exception {

		return courseListDAO.selectCourseTotCnt(cri);
	}

	@Override
	public List<CourseVO> listCourse(Criteria cri) throws Exception {

		return courseListDAO.listCourse(cri);
	}

	@Override
	public List<SubjectVO> listSubject() throws Exception {

		return courseListDAO.listSubject();
	}

	@Override
	public void insertCourse(CourseVO courseVO) throws Exception {

		courseListDAO.insertCourse(courseVO);
	}

	//교육훈련 상태 일괄변경
	@Override
	public void updateCourseStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception {
		courseListDAO.updateCourseStateAll(allChangeCodeVO);
	}


	
	
	//견적서 있는지 조회
	@Override
	public List<EstimateVO> listEstimate(String enrollID) throws Exception {
		
		return courseListDAO.listEstimate(enrollID);
	}
	
	
	//견적서 발급
	@Override
	public void insertEstimate(EstimateVO estimateVO) throws Exception {
		
		courseListDAO.insertEstimate(estimateVO);
	}
		
}
