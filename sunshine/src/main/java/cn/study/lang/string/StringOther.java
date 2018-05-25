package cn.study.lang.string;

import org.junit.Test;

public class StringOther {
	@Test
	public  void stringOther() {
		//String 底层是字符数组，所以长度不变。
		String str="abc";
		//上面这样创建一个string，jvm会去字符串常量池（这是常量池的一部分）去查找是否有abc这个字符串，
		//有的话，就直接将地址给str，
		//没有的话，则开辟内存在常量池中创建新的字符常量，然后将地址给str；
		String stra=new String("abc");
		System.out.println(str==stra);//false
		//这样创建的stra，是在堆内存中，省去了查找的过程，直接就创建一个hello的对象，并且返回引用。
		 stra=stra.intern();//可以调用这个方法将堆中的abc压入常量池中
		System.out.println(str==stra);//true
		
		
		String str1="cccc";
		String str2="ccccc";
		String str3="cccc"+"c";
		String str4=str1+"c";
		//这样是创建了多个String对象而且底层也创建了多个字符数组
		System.out.println(str3==str2);//true
		System.out.println(str4==str2);//flase
		
		
		
		StringBuffer s=new StringBuffer().append(true).append('a').append("asc");
		//虽然创建一个stringbuffer对象，但是，底层字符数组value是使用arrays.copyOf（
		// appendstring的时候是调用的native方法），每一次append都会创件一个char[]字符数组；
		//唯一的好处应该是append方法都加了synchronize，是同步的，在多线程的环境下是安全的！
		
		//extends java.lang.AbstractStringBuilder implements java.io.Serializable, java.lang.CharSequence
		StringBuilder sb=new StringBuilder().append("sac");
		//Stringbuffer和stringbuffer一样，只是方法没有同步，适合在单线的环境下使用；
		
		
		
	}
	@Test
	public void someTest(){
        String a = "hello2"; 
        final String b = "hello";
        String d = "hello";
        String c = b + 2; 
        String e = d + 2;
        System.out.println((a == c));
        System.out.println((a == e));
        
        String str1 = "str"; 
        String str2 = "ing"; 
        String str3 = "str" + "ing"; 
        String str4 = str1 + str2; 
        System.out.println(str3 == str4);//false 
        String str5 = "string"; 
        System.out.println(str3 == str5);//true

    }
}
