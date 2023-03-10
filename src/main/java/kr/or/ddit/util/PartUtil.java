package kr.or.ddit.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PartUtil {

	private static final String UPLOAD_PATH = "c:\\LastProject\\";

	/**
	 * Method : getExt
	 * 작성자 : PC05
	 * 변경이력 :
	 * @param fileName
	 * @return
	 * Method 설명 : 파일명으로부터 파일 확장자를 반환
	 */
	public static String getExt(String fileName) {
		String ext = "";
		
		if(fileName.contains(".")){
			ext = fileName.substring(fileName.lastIndexOf("."));
		}
		
		return ext;
	}
	
	/**
	 * Method : checkUploadFolder
	 * 작성자 : PC05
	 * 변경이력 :
	 * @param year
	 * @param month
	 * Method 설명 : 연, 월 업로드 폴더가 존재하는지 체크, 없을 경우 폴더 생성
	 */
	public static void checkUploadFolder(String year, String month){
		File yearFolder = new File(UPLOAD_PATH + year);	
		
		// 신규 연도로 넘어갔을 때 해당 연도의 폴더를 생성한다
		if(!yearFolder.exists()){
			yearFolder.mkdir();
		}
		
		// 월에 해당하는 폴더가 있는지 확인
		File monthFolder = new File(UPLOAD_PATH + year + File.separator + month);
		
		// 폴더가 없으면 생성
		if(!monthFolder.exists()){
			monthFolder.mkdir();
		}
	}
	
	/**
	 * Method : getUploadPath
	 * 작성자 : PC05
	 * 변경이력 :
	 * @param year
	 * @param month
	 * @return
	 * Method 설명 : 업로드 경로를 반환
	 */
	public static String getUploadPath(){
		// 연도에 해당하는 폴더가 있는지, 연도안에 월에 해당하는 폴더가 있는 지 확인
		Date dt = new Date();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMM");
		
		String ym = sdf2.format(dt);
		String year = ym.substring(0, 4);
		String month = ym.substring(4);
		
		PartUtil.checkUploadFolder(year, month);
		return UPLOAD_PATH + year + File.separator + month;
	}
}
