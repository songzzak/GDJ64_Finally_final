package com.workit.chat.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Attachment {
	private String fileId;
	private String originalFile;
	private String renameFile;
	private String uploadPath;
	private Date uploadDate;
	private String fileStatus;
}
