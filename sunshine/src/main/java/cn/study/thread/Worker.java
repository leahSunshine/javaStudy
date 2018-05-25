package cn.study.thread;

import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

/**
 * 
 * @ClassName: Worker 
 * @author leah
 * @date 2018-4-3 上午10:41:17
 */
public class Worker implements Runnable {

    final int id;
    final CyclicBarrier barrier;

    public Worker(int id, CyclicBarrier barrier) {
        this.id = id;
        this.barrier = barrier;
    }

    @Override
    public void run() {
        System.out.println(this.id + " start to run!");
        try {
            this.barrier.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (BrokenBarrierException e) {
            e.printStackTrace();
        }

    }
//    有五个人参与跑步，规定五个人只要都跑到终点了，大家可以喝啤酒。但是，只要有一个人没到终点，就不能喝。 这里没有要求大家要同时起跑
    public static void main(String[] args) {
    	 final int count = 5;
         final CyclicBarrier barrier = new CyclicBarrier(count, new Runnable() {
             
             @Override
             public void run() {
                 System.out.println("drink beer!");
             }
         });
         
         for (int i =0; i<count;i++){
             new Thread(new Worker(i, barrier)).start();
         }
	}
}