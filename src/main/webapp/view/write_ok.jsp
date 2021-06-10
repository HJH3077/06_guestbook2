<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.ict.db.DAO"%>
<%@page import="com.ict.db.VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 실제 저장위치
	String path = request.getServletContext().getRealPath("/upload");
	
	MultipartRequest mr = new MultipartRequest(
			request, 
			path, 
			100*1024*1024, 
			"utf-8", 
			new DefaultFileRenamePolicy());
	
	VO vo = new VO();
	vo.setName(mr.getParameter("name"));
	vo.setTitle(mr.getParameter("title"));
	vo.setContent(mr.getParameter("content"));
	vo.setEmail(mr.getParameter("email"));
	vo.setPw(mr.getParameter("pw"));
			
	// 첨부파일이 있을 때와 첨부파일이 없을 때를 구분하자 (이걸 안해주면 나중에 오류남)
	if(mr.getFile("f_name")!=null){
		vo.setF_name(mr.getFilesystemName("f_name")); // 파일 있을 때
		// filesystemname = 저장 이름
	}else{
		vo.setF_name(""); // 파일 없을 떄
	}
	
	int result = DAO.getInstance().getInsert(vo);
	if(result > 0){
		response.sendRedirect("list.jsp");
	}
%>