package com.bluekey;

public class test {
	public static void main(String[] args) {
        //���� GET ����
        String s=HttpRequest.sendGet("https://m.sogou.com/", "prs=8&rfh=1");
        System.out.println(s);
        
        //���� POST ����
//        String sr=HttpRequest.sendPost("m.sogou.com", "key=123&v=456");
//        System.out.println(sr);
    }
}
