package cn.study.crawler.src.proxy.pool;

import java.util.ArrayList;
import java.util.List;

public abstract class UrlPaseHandle {
	public static List<IPMessage> ipMessages=new ArrayList<>() ;
	abstract void parseInitPage(String url);
}
