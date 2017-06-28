package bluemail.test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bluemail.service.BlueMailService;

/**
 * Servlet implementation class SimpleServlet
 */
@WebServlet("/SimpleServlet")
public class SimpleServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;
    
    private BlueMailService bms = null;
    
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	System.out.println("start doGet");
    	
    	if (bms == null) {
    		bms = new BlueMailService();
    	}
    	
    	String responseCode="{\"sendMail\" : {\"status\" : \"" + bms.getStatus("") + "\"}}";
    	   	
        response.setContentType("application/json");
        response.getWriter().print(responseCode);
        
        System.out.println("end doGet: " + responseCode);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String responseCode;
    	
       	if (bms == null) {
    		bms = new BlueMailService();
    		// responseCode="{\"sendMail\" : {\"service\" : \"ready\"}}";
    		responseCode = "{\"sendMail\" : {\"status\" : \"" + bms.getStatus("") + "\"}}";
    	} else {
	    	if (request.getParameterValues("from")[0].isEmpty()) {
	    		responseCode = "{\"sendMail\" : {\"error\" : \"required field from is empty\"}}";
	    	} else {
		    	responseCode = bms.sendTestEmail(request.getParameterValues("to")[0],
		    									request.getParameterValues("cc")[0], 
		    									request.getParameterValues("bcc")[0],
		    									request.getParameterValues("from")[0],
		    									request.getParameterValues("subject")[0],
		    									request.getParameterValues("message")[0],
		    									request.getParameterValues("resend")[0]);
	    	}
    	}
    	
    	response.setContentType("application/json");
    	response.getWriter().print(responseCode);
    	System.out.println("end doPost: " + responseCode);
    }
}