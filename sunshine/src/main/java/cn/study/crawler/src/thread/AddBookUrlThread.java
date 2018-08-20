package cn.study.crawler.src.thread;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.study.crawler.src.entity.Book;
import cn.study.crawler.src.getContent.GetContent;
import cn.study.crawler.src.getContent.Pool;
import cn.study.crawler.src.write.FileReaderWriter;

/**
 * @author 并发处理分页线程
 *
 */
public class AddBookUrlThread implements Runnable {
	private String url;
	private GetContent content = new GetContent();
	//爬取全部小说的网址，书名
//	private String regex = "class=\"bookname\">.*?href=\"(.+?)\".+?>(.+?)</a>";
	private String regex = "<h2><a href=\"(.+?)\".+?>(.+?)</a></h2>";
	
	public AddBookUrlThread(String url) { 
		this.url = url;
	}
	@Override
	public void run() {
		System.out.println("开启获取分页线程：" + Thread.currentThread().getName());
		String text = null;
		try { 
			text = content.getContent(url);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
//		FileReaderWriter.writeIntoFile(text, "D:/书籍/test.txt", true);
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(text);
		String bookurl = "";
		//下载一个分页中的所有小说
		while(matcher.find()) {
			bookurl = "www.bookbaow.com" + matcher.group(1);
			Book b=new Book(bookurl);
			AdBookChaptersThread adb=new AdBookChaptersThread(b);
			Pool.executorServiceBook.execute(adb);
		}
		//如果为了测试  可以选择下载几本小说，可以5本
		/*for(int i=0;i<5;i++)
		 {      matcher.find();
				book = new Book();
				bookurl = "www.bookbao8.com" + matcher.group(1);
				book.setUrl(bookurl);
				book.setBook_name(matcher.group(2));
				// ReturnBooks.addBook(book);
				//并发处理单个书籍信息读取线程
				Pool.executorServiceBook.execute(new AdBookChaptersThread(book));
			}*/
			
	}
}
