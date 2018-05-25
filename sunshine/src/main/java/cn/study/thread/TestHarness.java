package cn.study.thread;

import java.util.concurrent.CountDownLatch;

/**
 * 5.11 在计时测试中使用CountDownLatch来启动和停止线程（闭锁）
 * 
 * @ClassName: TestHarness
 * TODO
 * @author leah
 * @date 2018-4-3 下午2:56:29
 */
public class TestHarness {
    
    int nThreads ;
    Runnable task;
    public TestHarness(int nThreads,Runnable task){
        this.nThreads = nThreads;
        this.task = task;
    } 
     public long timeTask(){
         
        //起始门
        final CountDownLatch startGate = new CountDownLatch(1);
        //结束门
        final CountDownLatch endGate = new CountDownLatch(nThreads);
         for(int i = 0;i<nThreads;i++){
             Thread thread = new Thread(){
                 public void run(){
                     //每个线程在启动门上等待，确保所有线程都就绪后才开始
                     try {
                        startGate.await();//等待计数器达到0 
                        try{
                            task.run();//线程执行代码
                        }finally{
                            //每个线程结束后，调用countDown递减计数器，表示一个事件发生
                            endGate.countDown();
                        }
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                     
                 }
             };
             thread.start();
         }
         long start = System.nanoTime();
         //启动门发生
         startGate.countDown();
         try {
             //等待结束门的线程都结束
            endGate.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        long end = System.nanoTime();
        return end - start;
     }
     public static void main(String[] args) {
    	 Runnable task = new Runnable() {
             
             @Override
             public void run() {
                 System.out.println("执行任务，我是线程："+Thread.currentThread().getName());                
             }
         };
         int count = 10;
         TestHarness testHarness = new TestHarness(count, task );
         long time = testHarness.timeTask();
         System.out.println("闭锁  测试结果  执行"+count+"个线程"+" 一共用时："+time);
	}
}