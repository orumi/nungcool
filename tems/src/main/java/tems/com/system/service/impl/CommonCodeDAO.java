package tems.com.system.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.CodeDetailVO;
import tems.com.system.model.CodeGroupVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-30.
 */
@Repository("CommonCodeDAO")
public class CommonCodeDAO extends EgovComAbstractDAO {

    public List<?> selectCodeGroupList() {
        return list("CommonCodeDAO.selectCodeGroupList");
    }

    public List<?> selectCodeGroupList2(String str) {
        return list("CommonCodeDAO.selectCodeGroupList2", str);
    }

    public void updateCodeGroupList(CodeGroupVO codeGroupVO) {
        update("CommonCodeDAO.updateCodeGroupList", codeGroupVO);
    }

    public void updateCodeGroupList2(CodeDetailVO codeDetailVO) {
        update("CommonCodeDAO.updateCodeGroupList2", codeDetailVO);
    }

    public void deleteCodeGroupList(CodeGroupVO codeGroupVO) {
        delete("CommonCodeDAO.deleteCodeGroupList", codeGroupVO);
    }

    public void deleteCodeGroupList2(CodeDetailVO codeDetailVO) {
        delete("CommonCodeDAO.deleteCodeGroupList2", codeDetailVO);
    }

    public void insertCodeGroupList(CodeGroupVO codeGroupVO) {
        insert("CommonCodeDAO.insertCodeGroupList", codeGroupVO);
    }

    public void insertCodeGroupList2(CodeDetailVO codeDetailVO) {
        insert("CommonCodeDAO.insertCodeGroupList2", codeDetailVO);
    }

}
