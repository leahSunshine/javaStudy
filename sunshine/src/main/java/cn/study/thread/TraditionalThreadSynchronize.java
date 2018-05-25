package cn.study.thread;

import org.junit.Test;

/**
 * 
 * @author Administrator
 *
 */
public class TraditionalThreadSynchronize {
	static class OutPut{
		public void output(String some) {
			int len=some.length();
			//同步代码块，需要有一个同步锁，并且所有调用此方法的必须使用同一个锁，才能达到同步互斥
			synchronized (this) {
				for(int i=0;i<len;i++){
					System.out.print(some.charAt(i));
				}
				System.out.println();
			}
		}
		//同步方法，他的同步锁是this
		public synchronized void output2(String some) {
			int len=some.length();
				for(int i=0;i<len;i++){
					System.out.print(some.charAt(i));
				}
				System.out.println();
		}
		//静态同步方法的同步锁是class
		public static synchronized void output3(String some) {
			int len=some.length();
			for(int i=0;i<len;i++){
				System.out.print(some.charAt(i));
			}
			System.out.println();
		}
	}
	private void init() {
		final OutPut output=new OutPut();
		new Thread(new Runnable() {
			@Override
			public void run() {
				while(true){
					output.output2("aaaaa");
				}
			}
		}).start();
		new Thread(new Runnable() {
			@Override
			public void run() {
				while(true){
					output.output3("bbbbb");
				}
			}
		}).start();
	}
	@Test
	public void test(){
		new TraditionalThreadSynchronize().init();
	}
}
