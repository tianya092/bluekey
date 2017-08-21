
package com.bluekey;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import org.json.JSONObject;

/**   
*    
* 项目名称：BlueKey   
* 类名称：connDb   
* 类描述：   
* 创建人：tony-wu   
* 创建时间：2017年8月7日 上午10:52:37   
* @version        
*/
public class connDb {
	private static String username;
	private static String password;
	
	private static String host;
	private static int port;
	private static String database;
	
	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static ResultSet result = null;
	
	
	//杩炴帴鏁版嵁搴撴柟娉�
	public static void startConn(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			//杩炴帴鏁版嵁搴撲腑闂翠欢
			try{
				if (System.getenv("VCAP_SERVICES") != null) {
					JSONObject blueMailJson = new JSONObject(System.getenv("VCAP_SERVICES"));
					JSONObject blueMailCredentials = blueMailJson.getJSONArray("mysql")
							.getJSONObject(0).getJSONObject("credentials");
					
					username = blueMailCredentials.getString("username");
					password = blueMailCredentials.getString("password");
					host = blueMailCredentials.getString("host");
					port = blueMailCredentials.getInt("port");
					database = blueMailCredentials.getString("name");
					con = DriverManager.getConnection("jdbc:MySQL://"+host+":"+port+"/"+database,username,password);
				} else {
					// not running on Bluemix Dedicated (e.g. running in Eclipse) - use hard coded credentials
					con = DriverManager.getConnection("jdbc:MySQL://localhost:3306/bluekey","root","root");
				}	
			}catch(SQLException e){
				e.printStackTrace();
			}
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
	}
	
	
	//鍏抽棴杩炴帴鏁版嵁搴撴柟娉�
	public static void endConn() throws SQLException{
		if(con != null){
			con.close();
			con = null;
		}
		if(rs != null){
			rs.close();
			rs = null;
		}
		if(stmt != null){
			stmt.close();
			stmt = null;
		}
	}
/***************************************Access*********************************************/
	
	/**
	 * @param role_id
	 * @return resultList
	 * @throws SQLException
	 */
		public static  ArrayList result(String role_id) throws SQLException{
			ArrayList<Map<String,String>> list = new ArrayList();
			Map<String,String> GeneralAccessMap =  new HashMap<String,String>();
			Map<String,String> FunctionAccessMap =  new HashMap<String,String>();
			Map<String,String> generalMap = new HashMap<String,String>();
	    	Map<String,String> functionMap = new HashMap<String,String>();
			String sql;
		    startConn();
		    stmt = con.createStatement();
		    rs = stmt.executeQuery("select access_id,short_title,parent_part from access where deleted = 0 ");
		    while(rs.next()){
		    	if(rs.getInt("parent_part")==1){
		    		GeneralAccessMap.put(rs.getString("access_id"),rs.getString("short_title"));
		    	}else if(rs.getInt("parent_part")==2){
		    		FunctionAccessMap.put(rs.getString("access_id"),rs.getString("short_title"));
		    	}
		    }
		   
		    sql = "select * from role where deleted = '0' and role_id = "+role_id;
		    rs = stmt.executeQuery(sql);
		    while(rs.next()){
		    	String[] accessArr = rs.getString("access_list").split(",");
		    	
		    	for(int i=0;i<accessArr.length; i++){
		    		if(GeneralAccessMap.containsKey (accessArr[i])){
		    			generalMap.put(accessArr[i], GeneralAccessMap.get(accessArr[i]));
		    		}else if(FunctionAccessMap.containsKey (accessArr[i])){
		    			functionMap.put(accessArr[i], FunctionAccessMap.get(accessArr[i]));
		    		}
		    	}
		    	
		    	list.add(generalMap);
		    	list.add(functionMap);
		    }
		    endConn();
			return list;
		}
	
		
	/**
	 * query access detail info
	 * @param access_id
	 * @return Access
	 * @throws SQLException
	 */
	public static  Access getAccessByID(String access_id) throws SQLException{
		Map<String,Access> detailMap = new HashMap<>();
		Access access = new Access();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from access where access_id ="+access_id+" and deleted = 0");
	    while(rs.next()){
	    	access.setAccessId(rs.getInt("access_id"));
	    	access.setTitle(rs.getString("title"));
	    	access.setShortTitle(rs.getString("short_title"));
	    	access.setFunction(rs.getString("function"));
	    	access.setPlatform(rs.getString("platform"));
	    	access.setApplyEmail(rs.getString("apply_email"));
	    	access.setUrl(rs.getString("url"));
	    	access.setOtherUrl(rs.getString("other_url"));
	    	access.setApplyStep(rs.getString("apply_step"));
	    	access.setLeadTime(rs.getInt("lead_time"));
	    	access.setParentPart(rs.getInt("parent_part"));
	    }
	    
	    endConn();
		return access;
	}
	
	//update access detail info
	public static  Boolean updateAccessDetail(Access access,String email) throws SQLException{
		boolean flag = false;
		int access_id = access.getAccessId();
		String sql ;
		PreparedStatement ps;
		try{
			
			Date dNow = new Date( );
		    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		    ft.setTimeZone(TimeZone.getTimeZone("GMT+8"));
		    startConn();
		    if(access_id!=0){
		    	//update access
		    	sql = "update access set title=?,short_title=?,function=?,platform=?,url=?,apply_email=?,lead_time=?,apply_step=?,update_time=?,update_operator=?,parent_part=?,other_url=? where access_id="+access_id;
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, access.getTitle());
		    	ps.setString(2, access.getShortTitle());
		    	ps.setString(3, access.getFunction());
		    	ps.setString(4, access.getPlatform());
		    	ps.setString(5, access.getUrl());
		    	ps.setString(6, access.getApplyEmail());
		    	ps.setInt(7, access.getLeadTime());
		    	ps.setString(8, access.getApplyStep());
		    	ps.setString(9, ft.format(dNow));
		    	ps.setString(10, email);
		    	ps.setInt(11, access.getParentPart());
		    	ps.setString(12, access.getOtherUrl());
		    }else{
		    	sql = "insert into access(title,short_title,function,platform,url,apply_email,lead_time,apply_step,create_time,create_operator,parent_part,update_time,update_operator,other_url)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, access.getTitle());
		    	ps.setString(2, access.getShortTitle());
		    	ps.setString(3, access.getFunction());
		    	ps.setString(4, access.getPlatform());
		    	ps.setString(5, access.getUrl());
		    	ps.setString(6, access.getApplyEmail());
		    	ps.setInt(7, access.getLeadTime());
		    	ps.setString(8, access.getApplyStep());
		    	ps.setString(9, ft.format(dNow));
		    	ps.setString(10, email);
		    	ps.setInt(11, access.getParentPart());
		    	ps.setString(12, ft.format(dNow));
		    	ps.setString(13, email);
		    	ps.setString(14, access.getOtherUrl());
		    }
		    
			ps.executeUpdate();
	    	ps.close();
		    flag = true;
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	//delete accesss 
	public static  boolean deleteAccess(Access access) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		int access_id = access.getAccessId();
		Date dNow = new Date( );
		SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		try{
			startConn();
		    String sql = "update access set deleted =?,update_time=? where access_id = "+access_id;
	    	ps = con.prepareStatement(sql);
	    	ps.setInt(1, 1);
	    	ps.setString(2, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	
	/**
	 * query accesss list
	 * @return ArrayList
	 * @throws SQLException
	 */
	
	public static  ArrayList getAccessList() throws SQLException{
		ArrayList<Access> accesslist = new ArrayList();
		startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from access where deleted = 0 order by parent_part ASC");
	    while(rs.next()){
	    	Access access = new Access();
	    	access.setAccessId(rs.getInt("access_id"));
	    	access.setTitle(rs.getString("title"));
	    	access.setShortTitle(rs.getString("short_title"));
	    	access.setFunction(rs.getString("function"));
	    	access.setPlatform(rs.getString("platform"));
	    	access.setApplyEmail(rs.getString("apply_email"));
	    	access.setUrl(rs.getString("url"));
	    	access.setApplyStep(rs.getString("apply_step"));
	    	access.setLeadTime(rs.getInt("lead_time"));
	    	access.setParentPart(rs.getInt("parent_part"));
	    	access.setUpdateTime(rs.getTimestamp("update_time"));
	    	access.setUpdateOperator(rs.getString("update_operator"));
	    	accesslist.add(access);
	    }

	    endConn();
		return accesslist;
	}
	
	/**
	 * query accesss list  for setting
	 * @return Map
	 * @throws SQLException
	 */
	public static  Map getAccessList1() throws SQLException{
		Map<String,ArrayList<String[]>> accessMap = new HashMap();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from access where deleted = 0 and parent_part= 1 ");
	    ArrayList<String[]> generalList = new ArrayList();
	    while(rs.next()){
	    	String[] temp={rs.getString("access_id"),rs.getString("title"),rs.getString("short_title")};
	    	generalList.add(temp);
	    }
	    
	    rs = stmt.executeQuery("select * from access where deleted = 0 and parent_part= 2 ");
	    ArrayList<String[]> functionList = new ArrayList();
	    while(rs.next()){
	    	String[] temp={rs.getString("access_id"),rs.getString("title"),rs.getString("short_title")};
	    	functionList.add(temp);
	    }
	    
	    rs = stmt.executeQuery("select * from access where deleted = 0 and parent_part= 3 ");
	    ArrayList<String[]> otherList = new ArrayList();
	    
    	accessMap.put("generalList",generalList);
    	accessMap.put("functionList",functionList);
    	
	    endConn();
		return accessMap;
	}
	
		
/***************************************User*********************************************/		
	
	/**
	 * update user
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public static  boolean updataUser(String email) throws SQLException{
		boolean flag = false;
		Date dNow = new Date( );
		Calendar calendar = Calendar.getInstance();
	    calendar.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
	    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
	    startConn();
	    stmt = con.createStatement();
	    result = stmt.executeQuery("select * from user where Email ='"+email+"' and deleted = 0");
	    if(result.next()==false){
	    	String sql = "insert into user(Email,actived,create_time)values(?,?,?)";
	    	PreparedStatement ps = con.prepareStatement(sql);
	    	ps.setString(1, email);
	    	ps.setInt(2, 1);
	    	ps.setString(3, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
	    	
	    }
	    endConn();
		return flag;
	}
	
	/**
	 * update user right
	 * @param user  email
	 * @return boolean
	 * @throws SQLException
	 */
	public static  boolean updateUserRight(User user,String email) throws SQLException{
		boolean flag = false;
		Date dNow = new Date( );
		Calendar calendar = Calendar.getInstance();
	    calendar.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
	    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
	    String userEmail = user.getEmail();
	    startConn();
	    stmt = con.createStatement();
	    result = stmt.executeQuery("select * from user where Email ='"+userEmail+"' and deleted = 0");
	    
    	try{
    		if(result.next()==false){
	    		String sql = "insert into user(Email,function,team,actived,create_time,update_time,update_operator)values(?,?,?,?,?,?,?)";
		    	PreparedStatement ps = con.prepareStatement(sql);
		    	ps.setString(1, userEmail);
		    	ps.setInt(2, user.getFunction());
		    	ps.setInt(3, user.getTeam());
		    	ps.setInt(4, 1);
		    	ps.setString(5, ft.format(dNow));
		    	ps.setString(6, ft.format(dNow));
		    	ps.setString(7, email);
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
    		}else{
    			String sql = "update user set function=?,team=?,update_time=?,update_operator=? where Email='"+userEmail+"'";
		    	PreparedStatement ps = con.prepareStatement(sql);
		    	ps.setInt(1, user.getFunction());
		    	ps.setInt(2, user.getTeam());
		    	ps.setString(3, ft.format(dNow));
		    	ps.setString(4, email);
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
    		}
    	 }catch(SQLException e) {   
             e.printStackTrace();   
 	    }finally {
 		    endConn();
 		}
	    
		return flag;
	}
	
	/**
	 * delete user right
	 * @param user  operatorEmail
	 * @return boolean
	 * @throws SQLException
	 */
	public static  boolean deleteUserRightByID(String user_id,String operatorEmail) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		Date dNow = new Date( );
		SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		try{
			startConn();
		    String sql = "update user set deleted =?,update_time=?,update_operator=? where user_id = "+user_id;
	    	ps = con.prepareStatement(sql);
	    	ps.setInt(1, 1);
	    	ps.setString(2, ft.format(dNow));
	    	ps.setString(3, operatorEmail);
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	//query user information
	public static User getUser(String email) throws SQLException{
		User user = new User();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from user where Email ='"+email+"' and deleted = 0  order by Email");
	    if(rs.next()){
	    	user.setUserId(rs.getInt("user_id"));
	    	user.setEmail(rs.getString("Email"));
	    	user.setAuthorizationRole(rs.getInt("authorization_role"));
	    	user.setRemember(rs.getString("remember"));
	    	user.setFunction(rs.getInt("function"));
	    	user.setTeam(rs.getInt("team"));
	    	user.setCreateTime(rs.getTimestamp("create_time"));
	    	user.setUpdateTime(rs.getTimestamp("update_time"));
	    	user.setUpdateOperator(rs.getString("update_operator"));
	    }
	    
	    endConn();
		return user;
	}
	
	
	/**
	 * query user information by user_id
	 * @param user_id
	 * @return
	 * @throws SQLException
	 */
	public static User getUserByID(String user_id) throws SQLException{
		User user = new User();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from user where user_id ='"+user_id+"' and deleted = 0  order by Email");
	    if(rs.next()){
	    	user.setEmail(rs.getString("Email"));
	    	user.setAuthorizationRole(rs.getInt("authorization_role"));
	    	user.setRemember(rs.getString("remember"));
	    	user.setFunction(rs.getInt("function"));
	    	user.setTeam(rs.getInt("team"));
	    	user.setCreateTime(rs.getTimestamp("create_time"));
	    	user.setUpdateTime(rs.getTimestamp("update_time"));
	    	user.setUpdateOperator(rs.getString("update_operator"));
	    }
	    
	    endConn();
		return user;
	}
	
	//query user list
	public static  ArrayList getUserList() throws SQLException{
		ArrayList<User> userlist = new ArrayList();
		startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from user where deleted = 0 and (function >0 or team >0) ");
	    while(rs.next()){
	    	User user = new User();
	    	user.setUserId(rs.getInt("user_id"));
	    	user.setEmail(rs.getString("Email"));
	    	user.setFunction(rs.getInt("function"));
	    	user.setTeam(rs.getInt("team"));
	    	user.setAuthorizationRole(rs.getInt("authorization_role"));
	    	user.setRemember(rs.getString("remember"));
	    	user.setCreateTime(rs.getTimestamp("create_time"));
	    	user.setUpdateTime(rs.getTimestamp("update_time"));
	    	user.setUpdateOperator(rs.getString("update_operator"));
	    	userlist.add(user);
	    }

	    endConn();
		return userlist;
	}
	
	
/***************************************Role*********************************************/
		
	/**
	 * query role detail info
	 * @param role_id
	 * @return Role
	 * @throws SQLException
	 */
	public static  Role getRole(String role_id) throws SQLException{
		Role role = new Role();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from role where deleted=0 and  role_id = "+role_id);
	    while(rs.next()){
	    	role.setAccessList(rs.getString("access_list"));
	    	role.setFunction(rs.getInt("function"));
	    	role.setTeam(rs.getInt("team"));
	    	role.setJobRole(rs.getInt("job_role"));
	    	role.setCommodity(rs.getInt("commodity"));
	    }
	    endConn();
		return role;
	}
	
	
	/**
	 *  query role_id by condition
	 * @param role
	 * @return
	 * @throws SQLException
	 */
	public static  int queryRole(Role role) throws SQLException{
		int role_id = 0 ;
	    int function = role.getFunction();
	    int team = role.getTeam();
	    int job_role =role.getJobRole();
	    int commodity = role.getCommodity();
	    String sql = "";
	    try{
	    	startConn();
		    stmt = con.createStatement();
		    if(commodity==0){
		    	sql = "select * from role where deleted = 0 and  function = "+function+" and team ="+team+" and job_role ="+job_role ;
		    }else{
		    	sql = "select * from role where deleted = 0 and  function = "+function+" and team ="+team+" and job_role ="+job_role +" and commodity =" +commodity;
		    }
		    
		    rs = stmt.executeQuery(sql);
		    while(rs.next()){
		    	role_id = rs.getInt("role_id");
		    	
		    }
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
	    
		return role_id;
	}
	
	
	
	
	//delete role 
	public static  boolean deleteRole(String role_id) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		Date dNow = new Date( );
		SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		try{
			startConn();
		    String sql = "update role set deleted =?,update_time=? where role_id = "+role_id;
	    	ps = con.prepareStatement(sql);
	    	ps.setInt(1, 1);
	    	ps.setString(2, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
		
	
	
	//get accesss list
	public static  ArrayList<Role> getRoleList(String funciton,String team,String job_role,String commodity) throws SQLException{
		ArrayList<Role> Rolelist = new ArrayList<Role>();
		startConn();
	    stmt = con.createStatement();
	    String sql = "select * from role where deleted = 0  ";
	    if((funciton !=null && funciton.length() != 0)){
	    
	    	sql+=" and function= "+funciton;
	    }
	    
    	if((team !=null && team.length() != 0)){
	    	sql+=" and team= "+team;
	    }
    	
    	if((job_role !=null && job_role.length() != 0)){
	    	sql+=" and job_role= "+job_role;
	    }
	    
    	if((commodity !=null && commodity.length() != 0)){
	    	sql+=" and commodity= "+commodity;
	    }
	    rs = stmt.executeQuery(sql+" order by function,team,job_role,commodity ASC");
	    while(rs.next()){
	    	Role role = new Role();
	    	role.setRoleId(rs.getInt("role_id"));
	    	role.setFunction(rs.getInt("function"));
	    	role.setTeam(rs.getInt("team"));
	    	role.setJobRole(rs.getInt("job_role"));
	    	role.setCommodity(rs.getInt("commodity"));
	    	role.setUpdateTime(rs.getString("update_time"));
	    	role.setUpdateOperator(rs.getString("update_operator"));
	    	role.setCommodity(rs.getInt("commodity"));
	    	Rolelist.add(role);
	    }

	    endConn();
		return Rolelist;
	}
	
	/**
	 * update role detail info
	 * @param role
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public static  boolean updateRole(Role role,String email) throws SQLException{
		boolean flag = false;
		int role_id = role.getRoleId();
		
		String sql ;
		PreparedStatement ps;
		try{
			Date dNow = new Date( );
			SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		    ft.setTimeZone(TimeZone.getTimeZone("GMT+8"));
		    startConn();
		    if(role_id!=0){
		    	//update access
		    	sql = "update role set access_list=?,update_time=?,update_operator=? where role_id="+role_id;
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, role.getAccessList());
		    	ps.setString(2, ft.format(dNow));
		    	ps.setString(3, email);
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
		    }else{
		    	
		    	sql = "insert into role(access_list,function,team,job_role,commodity,create_time,create_operator,update_time,update_operator)values(?,?,?,?,?,?,?,?,?)";
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, role.getAccessList());
		    	ps.setInt(2, role.getFunction());
		    	ps.setInt(3, role.getTeam());
		    	ps.setInt(4, role.getJobRole());
		    	ps.setInt(5, role.getCommodity());
		    	ps.setString(6, ft.format(dNow));
		    	ps.setString(7, email);
		    	ps.setString(8, ft.format(dNow));
		    	ps.setString(9, email);
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
			    
		    }
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	
	
/***************************************email template*********************************************/	
	//query mail_template data
	public static  Mail getMailTemplate(String access_id) throws SQLException{
		Mail mail= new Mail();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select temp_id, subject_title,content from mail_template where access_id ='"+access_id+"' and deleted = 0");
	    while(rs.next()){
	    	mail.setTempId(rs.getInt("temp_id"));
	    	mail.setSubjectTitle(rs.getString("subject_title"));
	    	mail.setContent(rs.getString("content"));
	    }
	    
	    endConn();
		return mail;
	}
	
	
	/**
	*  更新邮件模板
	* @return boolean
	* @param  mail, username
	*/
	public static boolean updateMailTemplate(Mail mail,String username) throws SQLException{
		boolean flag = false;
		int temp_id = mail.getTempId();
		String sql ;
		
		PreparedStatement ps;
		try{
			Date dNow = new Date( );
			SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		    startConn();
		    
		    if(temp_id!=0){
		    	//update mail template
		    	sql = "update mail_template set subject_title =?,content=?,update_time=?,update_operator=? where temp_id = "+temp_id;
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, mail.getSubjectTitle());
		    	ps.setString(2, mail.getContent());
		    	ps.setString(3, ft.format(dNow));
		    	ps.setString(4, username);
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
		    }else{
		    	
		    	sql = "insert into mail_template(subject_title,content,create_time,create_operator,access_id)values(?,?,?,?,?)";
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, mail.getSubjectTitle());
		    	ps.setString(2, mail.getContent());
		    	ps.setString(3, ft.format(dNow));
		    	ps.setString(4, username);
		    	ps.setInt(5, mail.getAccessId());
		    	
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
			    
		    }
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	/**
	*  发送邮件记录
	* @return boolean
	* @param   user_id, email,  receive_email,  title, content,  access_id
	*/
	public static boolean sendRecord(int user_id,String email, String receive_email, String title,String content, int access_id) throws SQLException{
		boolean flag = false;
		
		PreparedStatement ps;
		try{
			Date dNow = new Date( );
			SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		    startConn();
		    String sql = "insert into send_record(user_id,email,receive_email,email_subject,content,create_time,access_id)values(?,?,?,?,?,?,?)";
	    	ps = con.prepareStatement(sql);
	    	ps.setInt(1, user_id);
	    	ps.setString(2, email);
	    	ps.setString(3, receive_email);
	    	ps.setString(4, title);
	    	ps.setString(5, content);
	    	ps.setString(6, ft.format(dNow));
	    	ps.setInt(7, access_id);
	    	ps.executeUpdate();
	    	ps.close();
	    	flag = true;
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	/**
	*  查询邮件记录
	* @return Record
	* @param   user_id, email,  receive_email,  title, content,  access_id
	*/
	public static ArrayList getSendRecordList(int user_id) throws SQLException{
		ArrayList<SendRecord> recordList= new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from send_record where user_id ='"+user_id+"' and deleted = 0");
	    while(rs.next()){
	    	SendRecord record = new SendRecord();
	    	record.setRecordId(rs.getInt("record_id"));
	    	record.setUserId(rs.getInt("user_id"));
	    	record.setEmail(rs.getString("email"));
	    	record.setReceiveEmail(rs.getString("receive_email"));
	    	record.setEmailSubject(rs.getString("email_subject"));
	    	record.setContent(rs.getString("content"));
	    	record.setCreatTime(rs.getTimestamp("create_time"));
	    	record.setAccessId(rs.getInt("record_id"));
	    	recordList.add(record);
	    }
	    
	    endConn();
		return recordList;
	}
/***************************************remember*********************************************/	
	/**
	*  记住提交的job role
	* @return boolean
	* @param  mail, username
	*/
	public static  boolean remember(User user) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		try{
			startConn();
		    String sql = "update user set remember =? where user_id = "+user.getUserId();
	    	ps = con.prepareStatement(sql);
	    	ps.setString(1, user.getRemember());
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}

/***************************************remember*********************************************/	
	/**
	*  查询功能
	* @return ArrayList
	* @param  mail, username
	*/
	public static  ArrayList<Access> search(String search) throws SQLException{
		
		ArrayList<Access> AccessList= new ArrayList();
		startConn();
	    stmt = con.createStatement();
	   
	    rs = stmt.executeQuery("select * from access where  deleted = 0 and (title like '%"+search+"%' or apply_step like '%"+search+"%' or function like '%"+search+"%')");
	    
	    while(rs.next()){
	    	Access access = new Access();
	    	access.setAccessId(rs.getInt("access_id"));
	    	access.setTitle(rs.getString("title"));
	    	access.setShortTitle(rs.getString("short_title"));
	    	access.setFunction(rs.getString("function"));
	    	access.setPlatform(rs.getString("platform"));
	    	access.setApplyEmail(rs.getString("apply_email"));
	    	access.setUrl(rs.getString("url"));
	    	access.setApplyStep(rs.getString("apply_step"));
	    	access.setLeadTime(rs.getInt("lead_time"));
	    	access.setParentPart(rs.getInt("parent_part"));
	    	
	    	AccessList.add(access);
	    }
	    
	    return AccessList;
	}
	
/***************************************other*********************************************/
	//two array to be one 
	public static String[] concat(String[] a, String[] b) {  
	   String[] c= new String[a.length+b.length];  
	   System.arraycopy(a, 0, c, 0, a.length);  
	   System.arraycopy(b, 0, c, a.length, b.length);  
	   return c;  
	}  
	
}
