package cn.study.thread;
/**
 * 传统的线程
 * @author Administrator
 *
 */
public class TraditionalThread {

	public static void main(String[] args) {

		new Thread(new Runnable() {
			
			@Override
			public void run() {
				while(true){
					try {
						Thread.sleep(1000);
						System.out.println("Runnable"+Thread.currentThread().getName());
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}){
			@Override
			public void run() {
				while(true){
					try {
						Thread.sleep(1000);
						System.out.println("Thread"+Thread.currentThread().getName());
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}.start();
	}

}
