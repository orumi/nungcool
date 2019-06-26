package tems.com.system.service.impl;

import org.springframework.stereotype.Service;
import tems.com.system.model.CodeDetailVO;
import tems.com.system.model.CodeGroupVO;
import tems.com.system.service.CommonCodeService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by owner1120 on 2015-12-30.
 */
@Service("CommonCodeService")
public class CommonCodeServiceImpl implements CommonCodeService {

    @Resource(name = "CommonCodeDAO")
    CommonCodeDAO commonCodeDAO;

    @Override
    public List getCodeGroupList() throws Exception {
        List list = commonCodeDAO.selectCodeGroupList();
        return list;
    }

    @Override
    public void saveCodeGroupList(List<CodeGroupVO> list) throws Exception {

        for (CodeGroupVO vo : list) {

            if (vo.getState().equals("updated")) {
                commonCodeDAO.updateCodeGroupList(vo);
            } else if (vo.getState().equals("created")) {
                commonCodeDAO.insertCodeGroupList(vo);
            }
        }
    }

    @Override
    public void deleteCodeGroupList(List<CodeGroupVO> list) throws Exception {

        for (CodeGroupVO vo : list) {
            commonCodeDAO.deleteCodeGroupList(vo);
        }

    }

    @Override
    public List getCodeGroupList2(String str) throws Exception {

        List list = commonCodeDAO.selectCodeGroupList2(str);

        return list;
    }

    @Override
    public void saveCodeGroupList2(List<CodeDetailVO> list) throws Exception {

        for (CodeDetailVO vo : list) {

            if (vo.getState().equals("updated")) {
                commonCodeDAO.updateCodeGroupList2(vo);
            } else if (vo.getState().equals("created")) {
                commonCodeDAO.insertCodeGroupList2(vo);
            }
        }
    }

    @Override
    public void deleteCodeGroupList2(List<CodeDetailVO> list) throws Exception {

        for (CodeDetailVO vo : list) {
            commonCodeDAO.deleteCodeGroupList2(vo);
        }

    }
}
