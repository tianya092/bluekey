package com.bluekey;

import java.sql.Timestamp;
import java.util.Date;

public class User {

	
	private int userId;
	private String email;
	private String remember;
	private Timestamp createTime;
	private Timestamp updateTime;
	private int authorizationRole;
	
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRemember() {
		return remember;
	}
	public void setRemember(String remember) {
		this.remember = remember;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Timestamp getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}
	public int getAuthorizationRole() {
		return authorizationRole;
	}
	public void setAuthorizationRole(int authorizationRole) {
		this.authorizationRole = authorizationRole;
	}
	
	
}
