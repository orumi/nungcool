package tems.com.edu.course.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.common.Criteria;
import tems.com.edu.common.model.AllChangeCodeVO;
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
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("courseListDAO")
public class CourseListDAO extends EgovComAbstractDAO {
	

	
	
	
	
	//접수상태관리
	public void updateEnrollState(EnrollStateVO enrollStateVO) throws Exception {
	
		update("courseListDAO.updateEnrollState", enrollStateVO);
	}
	

	
	
	
	
	

	

	//훈련생별 접수정보
	public CourseEnrollVO selectCourseEnroll(String enrollID) throws Exception {
		
		return (CourseEnrollVO)select("courseListDAO.selectCourseEnroll", enrollID);
	}
	

	//삭제예정
	public EnrollInfoVO selectEnrollInfo(String enrollID) throws Exception {

		return (EnrollInfoVO)select("courseListDAO.selectEnrollInfo", enrollID);
	}
	
	//-- 접수한 훈련생 리스트
	public List<EnrollMemberVO> listEnrollMember(HashMap<String, Object> map) throws Exception {
		
		return (List<EnrollMemberVO>)list("courseListDAO.listEnrollMember", map);
	}

	
	//수업수정
	public void updateCourse(CourseVO courseVO) throws Exception {
		
		update("courseListDAO.updateCourse", courseVO);
	}
	
	//수업읽기
	public CourseVO selectCourse(String cosID) throws Exception {
		
		return (CourseVO)select("courseListDAO.selectCourse", cosID);
	}
	
	//수업카운트 
	public int selectCourseTotCnt(Criteria cri) throws Exception {
		
		return (Integer)select("courseListDAO.selectCourseTotCnt", cri);
	}
	
	//교육훈련리스트 가져오기
	public List<CourseVO> listCourse(Criteria cri) throws Exception {
		
		return (List<CourseVO>) list("courseListDAO.listCourse", cri);
	}
	
	//과목리스트 가져오기
	public List<SubjectVO> listSubject() throws Exception {
		
		return (List<SubjectVO>) list("courseListDAO.listSubject");
	}
	
	//교육훈련(course) 등록하기
	public void insertCourse(CourseVO courseVO) throws Exception {
		System.out.println(courseVO);
		insert("courseListDAO.insertCourse", courseVO);
	}
	
	
	//교육훈련 상태 일괄변경
	public void updateCourseStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception {
		System.out.println(allChangeCodeVO.toString());
		update("courseListDAO.updateCourseStateAll", allChangeCodeVO);
	}
	
	//교육훈련 상태 일괄변경
	public void updateEnrollStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception {
		System.out.println(allChangeCodeVO.toString());
		update("courseListDAO.updateEnrollStateAll", allChangeCodeVO);
	}


	//견적서 있는지 조회
	public List<EstimateVO> listEstimate(String enrollID) throws Exception {
		
		return (List<EstimateVO>) list("courseListDAO.listEstimate", enrollID);	
	}
		
	
	//견적서 발급
	public void insertEstimate(EstimateVO estimateVO) throws Exception {
		
		insert("courseListDAO.insertEstimate", estimateVO);
	}


	//접수증 발급
	public String insertReceipt(ReceiptVO receiptVO) {
		
		return (String) insert("courseListDAO.insertReceipt", receiptVO);
	}

	
	//수료증관련
	public CertificateVO selectCertificate(String enrollID) throws Exception {
			
		return (CertificateVO)select("courseListDAO.selectCertificate", enrollID);
	}
	

	

	
	//********************************************************************************************/
	//접수증 발급
	public ReceiptVO selectReceipt(String enrollID) throws Exception {
				
		return (ReceiptVO)select("courseListDAO.selectReceipt", enrollID);
	}
	
	//접수증 발급갯수 조회
	public int selectReceiptCntByID(String enrollID) throws Exception {
	
		return (Integer) select("courseListDAO.selectReceiptCntByID", enrollID); 
	}
	
	
	
	
	//********************************************************************************************/
	//수료증 발급
	public String insertCertificate(CertificateVO certificateVO) throws Exception {
		
		return (String) insert("courseListDAO.insertCertificate", certificateVO);
	}
	
	//수료증 발급갯수 조회
	public int selectCertificateCntByID(String enrollID) throws Exception {
		
		return (Integer) select("courseListDAO.selectCertificateCntByID", enrollID);
	}
	
	
	

	//********************************************************************************************/
	//평가 등록
	public void insertGrade(GradeVO gradeVO) {
		insert("courseListDAO.insertGrade", gradeVO);
	}

	//평가 수정
	public void updateGrade(GradeVO gradeVO) throws Exception {
		update("courseListDAO.updateGrade", gradeVO);
	}

	//평가 상세보기
	public GradeVO selectGrade(String enrollID) throws Exception {
		
		return (GradeVO)select("courseListDAO.selectGrade", enrollID);
	}
	
	
	
	
	//********************************************************************************************/
	
	
	
	
	
	

	public void deleteCourse(String cosID) {
		
		delete("courseListDAO.deleteCourse", cosID);	
	}
	
	
}