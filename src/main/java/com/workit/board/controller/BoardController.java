package com.workit.board.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.service.BoardService;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.common.Pagenation;
import com.workit.member.model.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	private BoardService service;
	
	@Autowired
	public BoardController(BoardService service) {
		this.service = service;
	}
	
	@GetMapping("/noticeList")
	public String noticeList(Model model, 
	                         @RequestParam(value="cPage",defaultValue="1") int cPage,
	                         @RequestParam(value="type", required=false) String searchType,
	                         @RequestParam(value="keyword", required=false) String searchKeyword) {

	    Map<String, Object> params = new HashMap<>();
	    params.put("cPage", cPage);
	    params.put("numPerpage", 10);

	    if(searchType != null && !searchType.isEmpty() && 
	       searchKeyword != null && !searchKeyword.isEmpty()) {
	        params.put("searchType", searchType);
	        params.put("searchKeyword", searchKeyword);
	    }

	    List<Notice> noticeList = service.selectNoticeAll(params);
	    int totalData = service.selectNoticeCount(params);

	    model.addAttribute("noticeList", noticeList);
	    model.addAttribute("pageBar", Pagenation.getPage(cPage,10,totalData,"/board/noticeList"));
	    return "board/noticeList";
	}

	@GetMapping("/noticeView")
	public String noticeView(Model model, @RequestParam int no,HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
	    boolean isViewed = false;

	    if(cookies != null) {
	        for(Cookie cookie : cookies) {
	            if(cookie.getName().equals("noticeView") && cookie.getValue().contains("|" + no + "|")) {
	                isViewed = true;
	                break;
	            }
	        }
	    }

	    if(!isViewed) {
	        service.updateViewCount(no); // 조회수 증가 메서드 추가해주세요

	        Cookie viewCookie = new Cookie("noticeView", "|" + no + "|");
	        viewCookie.setMaxAge(60*60*24); // 24시간 저장
	        response.addCookie(viewCookie);
	    }
		
		model.addAttribute("n", service.selectNoticeByNo(no));
		model.addAttribute("commentList", service.selectCommentList(no));
		model.addAttribute("prevNotice", service.selectNoticeByNo(no-1));
		model.addAttribute("nextNotice", service.selectNoticeByNo(no+1));
		model.addAttribute("fileList", service.selectFileListByNo(no));
		return "board/noticeView";
	}
	
	@PostMapping("/noticeCommentAdd")
	@ResponseBody
	public String addNoticeComment(@RequestParam int noticeNo, @RequestParam String commentContent,
            @RequestParam(required = false) Integer refCommentNo, HttpSession session) {
		 Map<String, Object> map = new HashMap<>();
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		map.put("memberId", memberId);
		map.put("noticeNo", noticeNo);
		map.put("commentContent", commentContent);
		map.put("refCommentNo", refCommentNo);
		//System.out.println(map);
	    service.insertNoticeComment(map);

	    return "success";
	}
	
	@PostMapping("/noticeCommentDelete")
	public void noticeCommentDelete(@RequestParam int commentNo, HttpServletResponse response) throws IOException {
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	        service.deleteNoticeComment(commentNo);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	
	}
	
	@PostMapping("/noticeCommentUpdate")
	public void noticeCommentUpdate(@RequestParam int commentNo, @RequestParam String commentContent,
		 HttpServletResponse response) throws IOException {
		 Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("commentContent", commentContent);
	    
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	    	service.updateNoticeComment(map);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	@PostMapping("/deleteNotice")
	public void deleteNotice(@RequestParam int noticeNo,HttpServletResponse response) throws IOException {
		int result = service.deleteNotice(noticeNo);
		Map<String, String> resultMap = new HashMap<>();
		if(result>0) {
			resultMap.put("status", "success");			
		}else {
			resultMap.put("status", "error");			
		}

	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	@GetMapping("/insertNotice")
	public String insertNotice() {
		return "board/insertNotice";
	}
	@PostMapping("insertNoticeEnd")
	public void insertNoticeEnd(@RequestParam String content, @RequestParam String title,
			@RequestParam(value = "file", required = false) MultipartFile[] files,
			HttpServletResponse response, HttpSession session, HttpServletRequest request) throws IOException {
		System.out.println(files);
	    // 서버의 업로드 폴더 경로 설정
	    String saveDir = request.getServletContext().getRealPath("/resources/upload/notice");
	    
	    // 첨부파일들을 저장할 리스트
	    List<AttachedFile> fileList = new ArrayList<>();

	    // 첨부파일 각각에 대해
	    for (MultipartFile file : files) {
	        // 원본 파일명 추출
	        String oriFileName = file.getOriginalFilename();
	        // 파일 확장자 추출
	        String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
	        
	        // 서버에 저장될 새 파일명 생성 (날짜_랜덤값 형식으로 중복 방지)
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
	        int rndNum = (int)(Math.random()*1000);
	        String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + ext;
	        
	        // 파일을 서버에 저장
	        try {
	            file.transferTo(new File(saveDir + "/" + renamedFileName));
	            AttachedFile attachedFile = new AttachedFile();
	            attachedFile.setOriginalFile(oriFileName);
	            attachedFile.setUploadFile(renamedFileName);
	            attachedFile.setUploadPath(saveDir);
	            fileList.add(attachedFile); // 리스트에 추가
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    // 게시글 정보를 맵에 저장
	    Map<String, Object> map = new HashMap<>();
	    map.put("memberId", ((MemberVO)session.getAttribute("loginMember")).getMemberId());
	    map.put("noticeContent", content);
	    map.put("noticeTitle", title);
	    
	    int result = service.insertNotice(map);

	    if(result > 0 && !fileList.isEmpty()) {
	        for (AttachedFile attachedFile : fileList) {
	            Map<String, Object> fileMap = new HashMap<>();
	            fileMap.put("originalFile", attachedFile.getOriginalFile());
	            fileMap.put("uploadFile", attachedFile.getUploadFile());
	            fileMap.put("uploadPath", attachedFile.getUploadPath());
	            
	            int attachResult = service.insertAttachedFile(fileMap);
	            if(attachResult>0) service.insertNoticeFile();  // 첨부파일과 게시글의 관계 저장
	        }
	    }
	    
	    Map<String, String> resultMap = new HashMap<>();
	    if(result > 0) {
	        resultMap.put("status", "success");
	    } else {
	        resultMap.put("status", "error");
	    }
	    
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	}
	
	@GetMapping("/updateNotice")
	public String updateNotice(@RequestParam int no,Model model) {
		model.addAttribute("notice", service.selectNoticeByNo(no));
		return "board/updateNotice";
	}
	@PostMapping("updateNoticeEnd")
	public void updateNoticeEnd(@RequestParam String content, @RequestParam String title,
			@RequestParam int no,HttpServletResponse response) throws IOException {
			Map<String, Object> map = new HashMap<>();
			map.put("noticeNo", no);
			map.put("noticeContent", content);
			map.put("noticeTitle", title);
		    Map<String, String> resultMap = new HashMap<>();
		    int result=service.updateNotice(map);
		    System.out.println(result);
		    if(result>0) {
		    	resultMap.put("status", "success");		    	
		    }else {
		    	resultMap.put("status", "error");		    	
		    }
		    Gson gson = new Gson();
		    String json = gson.toJson(resultMap);
		    response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	}
	
	@GetMapping("/downloadFile")
	public ResponseEntity<Resource> downloadFile(@RequestParam int fileId) throws MalformedURLException {
		AttachedFile file = service.selectFileById(fileId);
		System.out.println(file);
		// 파일의 전체 경로 생성
		Path filePath = Paths.get(file.getUploadPath() + "/" + file.getUploadFile()).normalize();

	    Resource resource = new UrlResource(filePath.toUri());

	    if (!resource.exists()) {
	        throw new RuntimeException("File not found: " + file.getOriginalFile());
	    }

	    return ResponseEntity.ok()
	            .contentType(MediaType.parseMediaType("application/octet-stream"))
	            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
	            .body(resource);
	}
}
