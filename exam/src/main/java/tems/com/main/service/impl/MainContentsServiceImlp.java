package tems.com.main.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.login.service.impl.LoginUserDAO;
import tems.com.main.service.MainContentsService;

@Service("mainContentsService")
public class MainContentsServiceImlp implements MainContentsService {

    @Resource(name = "mainContentsDAO")
    private MainContentsDAO mainContentsDAO;
	
}
