package tems.com.edu.course.service;

import java.util.List;

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

public interface CourseListService {

	
	//교육훈련 리스트
	public List<SubjectVO> listSubject() throws Exception ;
	

	
	//평가관리
	public void updateGrade(GradeVO gradeVO) throws Exception ;
	

	//접수상태관리
	public void updateEnrollState(EnrollStateVO enrollStateVO) throws Exception ;
	 
	//수료증관련
	public CertificateVO selectCertificate(String enrollID) throws Exception ;
	
	//평가관련
	public GradeVO selectGrade(String enrollID) throws Exception ;
	
	//접수증관련
	public ReceiptVO selectReceipt(String enrollID) throws Exception ;
	
	
	
	//훈련생별 접수정보
	public CourseEnrollVO selectCourseEnroll(String enrollID) throws Exception ;
	
	//삭제예정
	public EnrollInfoVO selectEnrollInfo(String enrollID) throws Exception ;
	
	//
	public List<EnrollMemberVO> listEnrollMember(String cosID, Criteria cri) throws Exception ;
	
	//
	public void updateCourse(CourseVO courseVO) throws Exception ;
	
	//
	public CourseVO selectCourse(String cosID) throws Exception ;
	
	//
	public int selectCourseTotCnt(Criteria cri) throws Exception ;
	
	//
	public List<CourseVO> listCourse(Criteria cri) throws Exception ;
	
	

	//
	public void insertCourse(CourseVO courseVO) throws Exception ;
	
	//교육훈련 상태 일괄변경
	public void updateCourseStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception;
	
	//접수상태 일괄변경
	public void updateEnrollStateAll(AllChangeCodeVO allChangeCodeVO) throws Exception;
	
	//견적서 있는지 조회
	public List<EstimateVO> listEstimate(String enrollID) throws Exception;	
	
	//견적서 발급
	public void insertEstimate(EstimateVO estimateVO) throws Exception;

	//교육훈련 삭제
	public void deleteCourse(String cosID);

	
	
	
	
}

