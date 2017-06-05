package BlueKey;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class connDb {
	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static ResultSet result = null;
	
	static Map<String,String> AccessMap =  new HashMap<String,String>();
	
	//杩炴帴鏁版嵁搴撴柟娉�
	public static void startConn(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			//杩炴帴鏁版嵁搴撲腑闂翠欢
			try{
//				con = DriverManager.getConnection("jdbc:MySQL://localhost:3306/bluekey","root","root");
				con = DriverManager.getConnection("jdbc:MySQL://169.53.241.185:3307/daf6b126a7b214534919dff69332245c7","urCFrPNw6AdWO","pnrXRBTaHH7cE");
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
	//resultList
	public static  ArrayList result(String user_id) throws SQLException{
		ArrayList<Map<String,String>> list = new ArrayList();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select access_id,short_title from detail");
	    while(rs.next()){
	    	AccessMap.put(rs.getString("access_id"),rs.getString("short_title"));
	    }
	    rs = stmt.executeQuery("select * from role where role_id = (select role_id from user where user_id= '"+user_id+"' )");
	    while(rs.next()){
	    	String[] generalArr = rs.getString("general_access").split(",");
	    	Map<String,String> generalMap = new HashMap<String,String>();
	    	for(int i=0;i<generalArr.length; i++){
		    	generalMap.put(generalArr[i], AccessMap.get(generalArr[i]));
	    	}
	    	
	    	String[] functionArr = rs.getString("function_access").split(",");
	    	Map<String,String> functionMap = new HashMap<String,String>();
	    	for(int i=0;i<functionArr.length; i++){
	    		functionMap.put(functionArr[i], AccessMap.get(functionArr[i]));
	    	}
	    	
	    	String[] othersArr = rs.getString("others_access").split(",");
	    	Map<String,String> othersMap = new HashMap<String,String>();
	    	for(int i=0;i<othersArr.length; i++){
	    		othersMap.put(othersArr[i], AccessMap.get(othersArr[i]));
	    	}
	    	
	    	list.add(generalMap);
	    	list.add(functionMap);
	    	list.add(othersMap);
	    }
	    endConn();
		return list;
	}
	
	//resultList
	public static  Map detail(String access_id) throws SQLException{
		Map<String,String> detailMap = new HashMap<>();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from detail where access_id ="+access_id+" and deleted = 0");
	    while(rs.next()){
	    	detailMap.put("access_id",rs.getString("access_id"));
	    	detailMap.put("title",rs.getString("title"));
	    	detailMap.put("short_title",rs.getString("short_title"));
	    	detailMap.put("function",rs.getString("function"));
	    	detailMap.put("data_base",rs.getString("data_base"));
	    	detailMap.put("apply_step",rs.getString("apply_step"));
	    	detailMap.put("url",rs.getString("url"));
	    	detailMap.put("apply_email",rs.getString("apply_email"));
	    	detailMap.put("LT",rs.getString("LT"));
	    	detailMap.put("parent_part",rs.getString("parent_part"));
	    }
	    
	    endConn();
		return detailMap;
	}
	
	//update user 
	public static  boolean updataUser(String email) throws SQLException{
		boolean status = false;
		Date dNow = new Date( );
	    SimpleDateFormat ft = 
	    new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
	    startConn();
	    stmt = con.createStatement();
	    result = stmt.executeQuery("select * from user where Email ='"+email+"' and deleted = 0");
	    if(result.next()==false){
	    	String sql = "insert into user(Email,w3_no,actived,create_time)values(?,?,?,?)";
	    	PreparedStatement ps = con.prepareStatement(sql);
	    	ps.setString(1, email);
	    	ps.setString(2, email);
	    	ps.setInt(3, 0);
	    	ps.setString(4, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
	    	
	    }
	    endConn();
		return status;
	}
	
	//check user's is actived or not
	public static  Map checkUserActived(String email) throws SQLException{
		Map<String,String> userMap = new HashMap<>();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select user_id,actived,role_id from user where email ='"+email+"' and deleted = 0");
	    while(rs.next()){
	    	userMap.put("user_id",rs.getString("user_id"));
	    	userMap.put("actived",rs.getString("actived"));
	    	userMap.put("role_id",rs.getString("role_id"));
	    }
	    
	    endConn();
		return userMap;
	}
	
	//check user_id is right or not
	public static boolean checkUserRight(String email,String user_id) throws SQLException{
		boolean userRight = false;
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select user_id,actived,role_id from user where email ='"+email+"'and user_id = '"+user_id+"' and deleted = 0");
	    if(rs.next()){
	    	userRight = true;
	    }
	    
	    endConn();
		return userRight;
	}
	
	//check user's access list
	public static boolean checkUserAccess(String user_id,String access_id) throws SQLException{
		boolean accessRight = false;
		String[] generalArr = null ;
		String[] functionArr = null;
		String[] othersArr = null;
		
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from role where role_id = (select role_id from user where user_id= '"+user_id+"' )");
	    if(rs.next()){
	    	generalArr = rs.getString("general_access").split(",");
	    	functionArr = rs.getString("function_access").split(",");
	    	othersArr = rs.getString("others_access").split(",");
	    }
	    
	    String[] accessArr = concat(generalArr,functionArr);
	    accessArr = concat(accessArr,othersArr);
	    Arrays.sort(accessArr);
	    
	    if(Arrays.binarySearch(accessArr, access_id)>=0){
	    	accessRight = true;
	    }
	    endConn();
		return accessRight;
	}
	
	//two array to be one 
	static String[] concat(String[] a, String[] b) {  
	   String[] c= new String[a.length+b.length];  
	   System.arraycopy(a, 0, c, 0, a.length);  
	   System.arraycopy(b, 0, c, a.length, b.length);  
	   return c;  
	}  
	
}
