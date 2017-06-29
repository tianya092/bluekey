package BlueKey;

public class test {
	public static void main(String[] args) {
        //发送 GET 请求
        String s=HttpRequest.sendGet("https://m.sogou.com/", "prs=8&rfh=1");
        System.out.println(s);
        
        //发送 POST 请求
//        String sr=HttpRequest.sendPost("m.sogou.com", "key=123&v=456");
//        System.out.println(sr);
    }
}
