package kr.or.ddit.attach.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.View;

import kr.or.ddit.attach.model.AttachVo;

public class FileDownloadView implements View{

	@Override
	public String getContentType() {
		return "application/octet-stream";
	}

	@Override
	public void render(Map<String, ?> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AttachVo attachVo = (AttachVo) model.get("attachVo");
		
		// 파일명 한글 인코딩 설정
		String attach_name = new String(attachVo.getAttach_name().getBytes("utf-8"), "iso-8859-1");
		
		File file = new File(attachVo.getAttach_path());
		InputStream is = new FileInputStream(file);
		OutputStream os = response.getOutputStream();
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=" + attach_name);
		response.setHeader("Content-Length", "" + file.length());
		
		byte[] b = new byte[(int) file.length()];
		int leng = 0;
		
		while((leng = is.read(b)) > 0) {
			os.write(b, 0, leng);
		}
		
		is.close();
		os.close();
	}
}
