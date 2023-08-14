package com.workit.chatroom.service;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dao.ChatDao;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.dao.ChatroomDao;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatroomFile;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ChatroomServiceImpl implements ChatroomService {

	private ChatroomDao chatroomDao;
	
	public ChatroomServiceImpl(ChatDao chatDao, ChatroomDao chatroomDao) {
		this.chatroomDao = chatroomDao;
	}
	
	@Override
	public int insertChat(ChatMsg chat) {
		return chatroomDao.insertChat(chat);
	}
	
	
	// root 경로
	private final String path = System.getProperty("user.dir");
	
	// 루트 경로에 있는 file directory
	private final String fileDir = path + "/src/main/webapp/resources/upload/chat/";
	
	@Override
    public AttachedFile saveFile(MultipartFile files, String chatroomId) throws IOException {
        if (files.isEmpty()) {
            return null;
        }

        // 원래 파일 이름 추출
        String origName = files.getOriginalFilename();
        log.info("oriName");
        log.info("{}", origName);
        
        // 파일 이름으로 쓸 uuid 생성
        //String uploadName = UUID.randomUUID().toString();
        
        // 확장자 추출(ex : .png)
        String extension = origName.substring(origName.lastIndexOf("."));
		Date today = new Date(System.currentTimeMillis());
		SimpleDateFormat redate = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int round = (int)(Math.random()*10000)+1;
		
		// 날짜와 확장자 결합
		String uploadName = redate.format(today) + "_" + round + extension;
		log.info("uploadName");
		log.info(uploadName);


        // 파일을 불러올 때 사용할 파일 경로
        //String uploadPath = fileDir + uploadName;
        String uploadPath = fileDir;
        
        
        // DB에 저장하기 위해 Map생성 
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("originalFile", origName);
        param.put("uploadFile", uploadName);
        param.put("uploadPath", uploadPath);
        
        
        // 데이터베이스에 파일 정보 저장 
        int result = chatroomDao.saveFile(param);
        log.info("{}", param.get("fileId"));
        
        if(result>0) {
        	param.put("chatroomId", chatroomId);
        	int uploadResult = chatroomDao.uploadFile(param);
        	log.info("chatroomFileNo");
        	log.info("{}", param.get("chatroomFileNo"));
        	if(uploadResult>0) {
        		String fileId = (String)param.get("fileId");
        		AttachedFile uploadFile = chatroomDao.selectFileById(fileId);
        		log.info("저장하고 가져온 파일");
        		log.info("{}", uploadFile);
        		
        		try {
					files.transferTo(new File(uploadPath + uploadName));
				}catch(IOException e) {
					e.printStackTrace();
				}
        		return uploadFile;
        	}
        	
        }
        return new AttachedFile();
    }

	@Override
	public List<ChatroomFile> selectFileByChatroomId(String chatroomId) {
		return chatroomDao.selectFileByChatroomId(chatroomId);
	}

	
	
}
