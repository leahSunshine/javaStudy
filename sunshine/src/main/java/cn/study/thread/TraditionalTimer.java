package cn.study.thread;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

/**
 * 使用timer实现每隔2秒和每隔4秒交替干一件事情
 * @author Administrator
 *
 */
public class TraditionalTimer {
	private static int i=0;
	public static void main(String[] args) {
		class MyTimerTask extends TimerTask{
			@Override
			public void run() {
				i=(i+1)%2;
				System.out.println("dosome");
				new Timer().schedule(new MyTimerTask(), 2000+2000*i);
			}
		}
		new Timer().schedule(new MyTimerTask(), 2000);
		//打印时间方便观看
		while(true){
			System.out.println(new Date().getSeconds());
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	}
}
