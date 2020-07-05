package main.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;

public class InquiryDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String inquiry_num = request.getParameter("inquiry_num");
		
		String message = "문의삭제 도중 오류가 발생했습니다.";
		InterIndexDAO dao = new IndexDAO();
		List<String> delFileName = dao.DelImgFind(inquiry_num);
		
		
		int result = dao.inquiryDel(inquiry_num);
		if(result != 0) { //상품문의가 정상적으로 삭제되었을 경우
			message = "문의가 삭제되었습니다.";
			ServletContext context = request.getSession().getServletContext();
			
			// 삭제된 문의에 사용된 실제 이미지 파일들을 삭제
			String realPath = context.getRealPath("Upload")+"/";
			for(int i=0; i<delFileName.size(); i++) {
				realPath+=delFileName.get(i);
				File file = new File(realPath);
				if(file.exists()){
					file.delete();
				}
				else {
					System.out.println("이미 삭제된 파일");
				}
			}
		}
		JSONObject obj = new JSONObject();
		obj.put("message", message);
		String json = obj.toString();
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
