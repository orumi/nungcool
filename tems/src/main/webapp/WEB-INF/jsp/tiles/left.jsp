<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.* " %>
<%@ page import="tems.com.login.model.UserMenuVO" %>

<%
	if(session.getAttribute("UserMenuList") != null){
		ArrayList UserMenuList = (ArrayList) session.getAttribute("UserMenuList");

%>
				<ul>
			          <li id="Home" tval="Home">
						<a href="<c:url value='/setMain.do?req_menuNo=main' />" title="Dashboard">
						<i class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">Main</span></a>
					</li>
<%
	int beforelvl = 0;
	int mcnt = 0;
	for(int j=0; j < UserMenuList.size();j++){
		UserMenuVO  menu = (UserMenuVO)UserMenuList.get(j);


		int lvl = Integer.parseInt(menu.getLvl());
		mcnt = Integer.parseInt(menu.getMcnt());


		if(beforelvl > lvl && beforelvl > 0){
			for(int z=0;z<beforelvl -lvl;z++){
				%>
				</ul></li>
				<%
			}
		}

		if(lvl == 1 && mcnt == 0){
%>
					<li class="" id="<%=menu.getMenuno()%>" tval="<%=menu.getMenutitle()%>">
						<a href="<c:url value='<%=menu.getUrl()%>'/>?req_menuNo=<%=menu.getMenuno()%>">
							<span class="menu-item-parent" > <%=menu.getMenunm()%> </span>
						</a>

					</li>
<%		} else if(lvl == 1  && mcnt > 0){ %>
					<li class="" id="<%=menu.getMenuno()%>" tval="<%=menu.getMenutitle()%>">
						<a href="<c:url value='<%=menu.getUrl()%>'/>" class="dropdown-toggle">
							<span class="menu-item-parent" > <%=menu.getMenunm()%> </span>
						</a>


						<ul class="submenu">
<%		} else if(lvl > 1 && mcnt == 0){  %>
							<li class="" id="<%=menu.getMenuno()%>" tval="<%=menu.getMenutitle()%>">
								<a href="<c:url value='<%=menu.getUrl()%>'/>?req_menuNo=<%=menu.getMenuno()%>">
									<span class="menu-item-parent" > <%=menu.getMenunm()%> </span>
								</a>

							</li>
<%		} else if(lvl > 1 && mcnt > 0){  %>
							<li class="" id="<%=menu.getMenuno()%>" tval="<%=menu.getMenutitle()%>">
								<a href="<c:url value='<%=menu.getUrl()%>'/>" class="dropdown-toggle">
									<span class="menu-item-parent" > <%=menu.getMenunm()%> </span>
								</a>


								<ul class="submenu">
<%		}
		beforelvl = lvl;

		if(j == UserMenuList.size()-1){
			for(int z=0;z<lvl-1;z++){
				%>
				</ul></li>
				<%
			}
		}
	}
%>
				</ul>

<%}%>

