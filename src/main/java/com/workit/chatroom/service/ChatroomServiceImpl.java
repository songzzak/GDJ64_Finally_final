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
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chatroom.dao.ChatroomDao;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatNotification;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ChatroomServiceImpl implements ChatroomService {

	private ChatroomDao chatroomDao;
	
	public ChatroomServiceImpl(ChatroomDao chatroomDao) {
		this.chatroomDao = chatroomDao;
	}
	
	
	@Override
	public int insertChat(ChatMsg chat) {
		return chatroomDao.insertChat(chat);
	}
	
	// root 경로
	private final String path = System.getProperty("user.dir");
	

	// 루트 경로에 있는 file directory
	private final String fileDir = path + "/GDJ64_Finally_final/src/main/webapp/resources/upload/chat/";
	
	@Override
    public AttachedFile saveFile(MultipartFile files, String chatroomId, String chatId) throws IOException {
        if (files.isEmpty()) {
            return null;
        }

        // 원래 파일 이름 추출
        String origName = files.getOriginalFilename();
        log.info("oriName");
        log.info("{}", origName);
        
        
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
        	param.put("chatId", chatId);
        	int uploadResult = chatroomDao.insertFile(param);
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

	@Override
	public List<Member> selectChatMemberById(String chatroomId) {
		return chatroomDao.selectChatMemberById(chatroomId);
	}

	@Override
	public int insertChatNotify(Map<String, Object> param) {
		MyChatroom m = (MyChatroom)param.get("member");
		String chatId = (String)param.get("chatId");
		log.info("chatroomNo : " + m.getMyChatroomNo());
		log.info("chatId : " + chatId);
		log.info("memberId : " + m.getMember().getMemberId());
		ChatNotification c = ChatNotification.builder().myChatroomNo(m.getMyChatroomNo()).memberId(m.getMember().getMemberId()).build();
		return chatroomDao.insertChatNotify(c);
	}

	@Override
	public int chatNotificationCount(String loginMember) {
		return chatroomDao.chatNotificationCount(loginMember);
	}

	@Override
	public int deleteNotify(int myChatroomNo) {
		return chatroomDao.deleteNotify(myChatroomNo);
	}

	@Override
	public MemberVO selectMemberByChoice(String memberId) {
		return chatroomDao.selectMemberByChoice(memberId);
	}

	@Override
	public List<Chatroom> selectChatroomByroomId(String chatroomId) {
		return chatroomDao.selectChatroomByroomId(chatroomId);
	}


	@Override
	public List<MyChatroom> selectChatroomById(String chatroomId) {
		return chatroomDao.selectChatroomById(chatroomId);
	}
	
	
	
	
	
	
	
}
