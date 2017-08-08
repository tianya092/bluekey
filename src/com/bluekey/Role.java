package com.bluekey;

public class Role {
	private int  roleId;
	private int  function;
	private int  team;
	private int  jobRole;
	private int  commodity;
	private String  generalAccess;
	private String  functionAccess;
	private String  accessList;
	private String  othersAccess;
	private String  creatTime;
	private String  updateOperator;
	private String  create_operator;
	
	public String getUpdateOperator() {
		return updateOperator;
	}
	public void setUpdateOperator(String updateOperator) {
		this.updateOperator = updateOperator;
	}
	public String getCreate_operator() {
		return create_operator;
	}
	public void setCreate_operator(String create_operator) {
		this.create_operator = create_operator;
	}
	private String 	updateTime;
	private int  deleted;
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getFunction() {
		return function;
	}
	public void setFunction(int function) {
		this.function = function;
	}
	public int getTeam() {
		return team;
	}
	public void setTeam(int team) {
		this.team = team;
	}
	public int getJobRole() {
		return jobRole;
	}
	public void setJobRole(int jobRole) {
		this.jobRole = jobRole;
	}
	public int getCommodity() {
		return commodity;
	}
	public void setCommodity(int comodity) {
		this.commodity = comodity;
	}
	public String getGeneralAccess() {
		return generalAccess;
	}
	public void setGeneralAccess(String generalAccess) {
		this.generalAccess = generalAccess;
	}
	public String getFunctionAccess() {
		return functionAccess;
	}
	public void setFunctionAccess(String functionAccess) {
		this.functionAccess = functionAccess;
	}
	public String getOthersAccess() {
		return othersAccess;
	}
	public void setOthersAccess(String othersAccess) {
		this.othersAccess = othersAccess;
	}
	public String getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	public String getAccessList() {
		return accessList;
	}
	public void setAccessList(String accessList) {
		this.accessList = accessList;
	}
	
	
	
	
	
	
}
