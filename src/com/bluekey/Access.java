package com.bluekey;

import java.sql.Timestamp;
import java.util.Date;

public class Access {
	private int  accessId;
	private String  title;
	private String  shortTitle;
	private String  function;
	private String  platform;
	private String  url;
	private String  applyEmail;
	private int  leadTime;
	private String  applyStep;
	private int 	parentPart;
	private String  creatTime;
	private Timestamp  	updateTime;
	private String  createOperator;
	private String 	updateOperator;
	
	private String  Email_subject_title;
	private String 	Email_content;
	
	
	public int getAccessId() {
		return accessId;
	}
	public String getCreateOperator() {
		return createOperator;
	}
	public void setCreateOperator(String createOperator) {
		this.createOperator = createOperator;
	}
	public String getUpdateOperator() {
		return updateOperator;
	}
	public void setUpdateOperator(String updateOperator) {
		this.updateOperator = updateOperator;
	}
	public void setAccessId(int accessId) {
		this.accessId = accessId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getShortTitle() {
		return shortTitle;
	}
	public void setShortTitle(String shortTitle) {
		this.shortTitle = shortTitle;
	}
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getApplyEmail() {
		return applyEmail;
	}
	public void setApplyEmail(String applyEmail) {
		this.applyEmail = applyEmail;
	}
	public int getLeadTime() {
		return leadTime;
	}
	public void setLeadTime(int i) {
		this.leadTime = i;
	}
	public String getApplyStep() {
		return applyStep;
	}
	public void setApplyStep(String applyStep) {
		this.applyStep = applyStep;
	}
	public int getParentPart() {
		return parentPart;
	}
	public void setParentPart(int parentPart) {
		this.parentPart = parentPart;
	}
	public String getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}
	public String getEmail_subject_title() {
		return Email_subject_title;
	}
	public void setEmail_subject_title(String email_subject_title) {
		Email_subject_title = email_subject_title;
	}
	public String getEmail_content() {
		return Email_content;
	}
	public void setEmail_content(String email_content) {
		Email_content = email_content;
	}
	
	
}
