package com.workit.chatroom.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FileVo {
	private String originalFile;
	private String uploadFile;
	private String uploadPath;
}
