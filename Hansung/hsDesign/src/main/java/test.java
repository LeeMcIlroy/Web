import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

public class test {
	public static void main(String[] args) {
/*
		System.out.println(URLDecoder.decode("%ec%8b%a4%eb%82%b4%eb%94%94%ec%9e%90%ec%9d%b8-2017%eb%85%84-1%ed%95%99%ea%b8%b0-%ea%b0%9c%ea%b0%95%ed%8c%8c%ed%8b%b0"));
		System.out.println(URLDecoder.decode("%ec%8b%a4%eb%82%b4%eb%94%94%ec%9e%90%ec%9d%b8-2017-%ec%8b%a0%ec%9e%85%ec%83%9d-%ec%98%a4%eb%a6%ac%ec%97%94%ed%85%8c%ec%9d%b4%ec%85%98"));
		System.out.println(URLDecoder.decode("%ec%8b%a4%eb%82%b4%eb%94%94%ec%9e%90%ec%9d%b8-%eb%8c%80%ed%95%99%ec%9b%90-%ec%9d%b8%ed%84%b0%eb%b7%b0-%ea%b9%80%ec%9c%a4%ed%9d%ac-%ed%95%99%ec%83%9d"));
		System.out.println(URLDecoder.decode("%eb%aa%a8%ec%a7%91%ec%9a%94%ea%b0%952"));
*/
/*		
		String str = "<p><img alt=\"\" src=\"http://202.167.218.23:8080/cmmn/ckeditor/downloadCkeditorFile.do?fileName=20170727030947141_20160819094803394.jpg\" style=\"border:1px solid #000;vertical-align:middle; position:absolute;; top:7px; left:23px; margin-right:10px;position:absolute;top:50%;left:0;margin-top:-18px;text-align:center;margin-right:7px;height:3105px; width:3080px; max-height: 100px; min-width:100px;\" /></p>";
		System.out.println("111111111111111 = \n"+str);
*/
/*		
		// width와 height 만 변경
		str = str.replaceAll("width:\\s?\\w*\\;?", "width: 100%;").replaceAll("height:\\s?\\w*\\;?", "height: auto;");
		System.out.println("222222222222222 = \n"+str);
		
		str = str.replaceAll("style=\"(\\s?\\w*\\-?\\w*\\s?\\:\\s?\\-?\\w*\\%?\\s?\\;*\\s?){0,}\"", "");
		System.out.println("333333333333333 = \n"+str);
		
		// style 전부 삭제
		str = str.replaceAll("style=\"([\uAC00-\uD7A3xfe0-9a-zA-Z\\s\\S]*){0,}\"", "");
		System.out.println("444444444444444 = \n"+str);
*/		
/*
		if(str.indexOf("max-width") > 0) str = str.replaceAll("max-width\\s?:\\s?\\w*\\;?", "");
		if(str.indexOf("min-width") > 0) str = str.replaceAll("min-width\\s?:\\s?\\w*\\;?", "");
		if(str.indexOf("max-height") > 0) str = str.replaceAll("max-height\\s?:\\s?\\w*\\;?", "");
		if(str.indexOf("min-height") > 0) str = str.replaceAll("min-height\\s?:\\s?\\w*\\;?", "");
		
		str = str.replaceAll("width", "max-width").replaceAll("height", "max-height");
		System.out.println("555555555555555 = \n"+str);
		
		String fileName = "2017_졸업생 명단(변경,추가).xlsx";
		System.out.println(EgovStringUtil.removeCommaChar(fileName));
*/
		
		//String str = "D:/WAS/2017/hsDesign/upload/attachedFile/BRODATA/20171228042809732.jpg";
		String str1 = "D:/WAS/2017/hsDesign/upload/attachedFile/POPUP/20180119031227712.jpg";
		File originFile = new File(str1);
		BufferedImage bi = null;
		/*
		Path path = Paths.get(str);
		
		try {
			System.out.println(Files.probeContentType(path));
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		*/
		/*
		Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("JPEG");
		while(readers.hasNext()){
			System.out.println("reader: "+ readers.next());
		}
		*/
		/*
		Image img = null;
		try {
			//bi = ImageIO.read(originFile);
			
			ImageInputStream iis = new FileImageInputStream(originFile);
			Iterator<ImageReader> i = ImageIO.getImageReaders(iis);
			while(i.hasNext()){
				ImageReader r = i.next();
				r.setInput(iis);
				img = r.read(0);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				JpegReader jpegReader = new JpegReader();
				bi = jpegReader.readImage(originFile);
			} catch (IOException e1) {
				e1.printStackTrace();
			} catch (ImageReadException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
*/
		
		
		//원본파일의 가로, 세로
		int origin_width = bi.getWidth();
		System.out.println(origin_width);
		int origin_height = bi.getHeight();
		System.out.println(origin_height);
		
		
		/*
		JpegReader jpegReader = new JpegReader(); //위에서 만든 Class
        
        BufferedImage bufferedImage = null;
         
        try {
                 
            bufferedImage = jpegReader.readImage(new File(str1));
             
            File outputfile = new File(str1);
            ImageIO.write(bufferedImage, "jpg", outputfile);//동일한 명으로 이미지를 변경한다. 복사본을 남기려면 outputfile의 파일명을 변경
             
        } catch (ImageReadException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        */
        
		
		
	}
	
	
}
