package cn.study.crawler.src.thread;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.codehaus.plexus.util.FileUtils;
import org.codehaus.plexus.util.io.URLInputStreamFacade;

import cn.study.crawler.src.entity.Book;
import cn.study.crawler.src.getContent.GetContent;
import cn.study.crawler.src.util.UnRar;
import cn.study.crawler.src.write.FileReaderWriter;

/**
 * @author 下載一本书
 *
 */
public class AdBookChaptersThread implements Runnable {
	private volatile Book book;
	private static String downloadUrl="/tmp/test";//D:/书籍/，linux上面的书的存放位置。
	private GetContent content = new GetContent();

	public AdBookChaptersThread(Book book) {
		this.book = book;
	}

	/**
	 * 爬取该书本信息
	 * 
	 * @param book
	 * @return
	 */
	public boolean getBookInformation(Book book) {
		// FileReaderWriter.writeIntoFile("zz1", "D:/知乎-编辑推荐.txt", false);
		String xx;
		try {
			//获取https://www.bookbaow.com/TXT/down_74650.html这个页面内容。
			xx = content.getContent(book.getUrl());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("获取书本信息失败");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		//获取小说书名，作者，类型，连载状态，更新时间，书本简介，书本下载地址。
		String regexUrl="<title>《(.+?)》.*?</title>";
		Pattern pattern = Pattern.compile(regexUrl);
		Matcher matcher = pattern.matcher(xx);
		boolean is = matcher.find();
		if (!is) {
			return false;
		}
		book.setBook_name(matcher.group(1));
		downloadBook(book.getBook_name());
		try {
			UnRar.unrar(downloadUrl+book.getBook_name()+".rar",  downloadUrl);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	public static void downloadBook(String book_name) {
		String	urlName=null;
		try {
			urlName=URLEncoder.encode(book_name, "gbk");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String url="http://204.12.225.163/"+urlName+".rar";
//		String url="http://204.12.225.163/%E6%B8%85%E7%A9%BF%E4%B9%8B%E6%97%BA%E5%A4%AB%E8%80%81%E7%A5%96.rar";
		URL u=null;
		 BufferedInputStream in=null;
		    BufferedOutputStream out=null;
		try {
			 u=new URL(url);
			 URLConnection con=u.openConnection();
			 InputStream input = con.getInputStream();
			
			    in=new BufferedInputStream(input);
			    out=new BufferedOutputStream(new FileOutputStream(downloadUrl+book_name+".rar"));
			    int len=-1;
			    byte[] b=new byte[1024];
			    while((len=in.read(b))!=-1){
			        out.write(b,0,len);
			    }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			 try {
				in.close();
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			    
		}
	}
	/**
	 * 下载该书籍简介等信息
	 * 
	 * @param bookName
	 * @return
	 */
	public boolean getInformation() {
		if (getBookInformation(book)) {
			FileReaderWriter.writeIntoFile(book.toString(), "D:/书籍/" + book.getBook_name() + ".txt", true);
			System.out.println(book.getBook_name() + "信息爬取成功");
			return true;
		}
		return false;
	}

	/**
	 * @return 获取章节页面链接
	 */
	public String getChapterUrl(String ulString) {

		String url = book.getUrl();
		int index = url.indexOf("/");
		// 截取首页www.bookbao8.com
		StringBuilder dir = new StringBuilder(url.substring(0, index));
		dir.append(ulString);
		return dir.toString();
	}

	/**
	 * @return 爬起小说的章节列表区域源代码
	 */
	public String getTextAll() {
		String text = "";
		String url = book.getUrl();
		try {
			text = content.getContent(url);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		// 获取章节的列表内容，而不是其他如热门排行榜
		String regex = "class=\"wp b2 info_chapterlist\">.*</ul>";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(text);
		boolean is = matcher.find();
		if (is) {
			String ulString = matcher.group();
			return ulString;
		}
		return null;
	}

	/**
	 * 爬取指定章节链接的内容
	 * 
	 * @param url
	 *            章节链接
	 * @return 返回的文章内容
	 */
	public String getText(String url) {
		// http://www.bookbao8.com/views/201708/29/id_XNTg3MTc5_7.html
		String text = "";
		try {
			text = content.getContent(url);
		} catch (URISyntaxException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String regex = "id=\"contents\".*?>(.+?)</dd>";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(text);
		boolean is = matcher.find();
		if (is) {
			String One = matcher.group(1);
			One = One.replace("<br />", "\r\n");
			return One;
		}
		return null;
	}

	@Override
	public void run() {
		System.out.println("开启获取书籍线程：" + Thread.currentThread().getName());
		if (getBookInformation(book)) {
			System.out.println("爬取" + book.getBook_name() + "信息成功");
		}
		/*// 获取该小说的章节源内容
		String ulString = getTextAll();
		// 获取标题内容 和链接
		String regex = "href=\"(.+?)\".+?>(.+?)</a>";
		String chapter = "";
		String contentText = "";
		StringBuilder All = new StringBuilder();

		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(ulString);
		while (matcher.find()) {
			// 获取章节链接	
			chapter = getChapterUrl(matcher.group(1));
			// 爬取文章内容
			contentText = getText(chapter);
			// 下载标题
			All.append(matcher.group(2));
			All.append("\r\n\r\n");
			//下载章节内容
			All.append(contentText);
			All.append("\r\n\r\n\r\n");
			FileReaderWriter.writeIntoFile(All.toString(), "D:/书籍/" + bookName + ".txt", true);
			System.out.println(book.getBook_name() + "章节爬取成功！");
		}
		System.out.println(bookName + "全部爬取成功！");*/
	}
}
