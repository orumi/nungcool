package tems.com.system.service;

import tems.com.system.model.CodeDetailVO;
import tems.com.system.model.CodeGroupVO;
import tems.com.system.model.OfficeUserListVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-30.
 */


public interface CommonCodeService {

    List getCodeGroupList() throws Exception;

    void saveCodeGroupList(List<CodeGroupVO> list) throws Exception;

    void deleteCodeGroupList(List<CodeGroupVO> list) throws Exception;

    List getCodeGroupList2(String str) throws Exception;

    void saveCodeGroupList2(List<CodeDetailVO> list) throws Exception;

    void deleteCodeGroupList2(List<CodeDetailVO> list) throws Exception;
}
