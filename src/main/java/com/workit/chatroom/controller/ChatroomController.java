package com.workit.chatroom.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.service.ChatroomService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chatroom")
public class ChatroomController {
	
	private ChatroomService chatroomService;
	
	public ChatroomController(ChatroomService chatroomService) {
		this.chatroomService = chatroomService;
	}
	
	@PostMapping("/upload")
    public List<AttachedFile> uploadFile(@ModelAttribute("uploadFile") List<MultipartFile> files, @RequestParam(value="chatroomId") String chatroomId) throws IOException {
		log.info("{}", chatroomId);
		log.info("{}", files);
		List<AttachedFile> list = new ArrayList<AttachedFile>();
		if(files!=null && files.size()>0) {
			for (MultipartFile multipartFile : files) {
				log.info("{}", multipartFile.getOriginalFilename());
				AttachedFile uploadFile = chatroomService.saveFile(multipartFile, chatroomId);
				log.info("controller file");
				log.info("{}", uploadFile);
				if(uploadFile!=null) {
					list.add(uploadFile);
				}
			}
			log.info("{}", list);
			return list;
		}
        return list;
    }
	
	@RequestMapping("/filedownload")
	public void fileDown(String oriname, String rename, OutputStream out,
			@RequestHeader(value="user-agent") String header,
			HttpSession session,
			HttpServletResponse res) {
		
		String path=session.getServletContext().getRealPath("/resources/upload/chat/");
		File downloadFile=new File(path+rename);
		try(FileInputStream fis=new FileInputStream(downloadFile);
				BufferedInputStream bis=new BufferedInputStream(fis);
				BufferedOutputStream bos=new BufferedOutputStream(out)) {
			
			boolean isMS=header.contains("Trident")||header.contains("MSIE");
			String ecodeRename="";
			if(isMS) {
				ecodeRename=URLEncoder.encode(oriname,"UTF-8");
				ecodeRename=ecodeRename.replaceAll("\\+","%20");
			}else {
				ecodeRename=new String(oriname.getBytes("UTF-8"),"ISO-8859-1");
			}
			res.setContentType("application/octet-stream;charset=utf-8");
			res.setHeader("Content-Disposition","attachment;filename=\""+ecodeRename+"\"");
			
			int read=-1;
			while((read=bis.read())!=-1) {
				bos.write(read);
			}
			
		}catch(IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
