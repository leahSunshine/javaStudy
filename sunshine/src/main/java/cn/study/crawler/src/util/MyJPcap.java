package cn.study.crawler.src.util;

import java.io.IOException;

import jpcap.JpcapCaptor;
import jpcap.NetworkInterface;
import jpcap.NetworkInterfaceAddress;
import jpcap.PacketReceiver;
import jpcap.packet.ARPPacket;
import jpcap.packet.Packet;
/**
 * Java的代码实现的抓包
 * @author Administrator
 *
 */
public class MyJPcap {
	public static void main(String[] args) {
		/******获取网络接口设备*****/
		System.out.println("/***获取网络接口设备*****/") ;
		NetworkInterface[] devices = JpcapCaptor.getDeviceList() ; //获得所有网卡列表
		String s = devices.toString() ;
		System.out.println(s) ;
		//JpcapCaptor captor=JpcapCaptor.openDevice(devices[0], 65535, false, 20);
		for (int i = 0 ; i < devices.length ; i ++) {
			// 设备号      网卡名      网卡描述 
			System.out.println(i + ":   " + devices[i].name + "    (" +  devices[i].description + ")") ;
			
			// 网卡所处数据链路层的名称与其描述
			System.out.println("datalink:  " + devices[i].datalink_name + "  (" + devices[i].datalink_description + ")") ;
		 
            // 网卡MAC地址
			System.out.println("网卡MAC:  "+devices[i].mac_address);// 
			System.out.print("网卡MAC(16进账): ");
			for (byte b : devices[i].mac_address){
				// 转化为16进账
				//System.out.print("("+b+")");
				System.out.print(Integer.toHexString(b&0xff) + ":"); // byte 有符号 最高位为1时  是负数   故 &0xff
			}
			System.out.println();
			
			System.out.println("Ipv6: "+devices[i].addresses[0].address); //ipv6
			System.out.println("Ipv4: "+devices[i].addresses[1].address);  //ipv4
			//输出网卡ipv6  ipv4  的   IP地址   子网地址   广播地址
			for (NetworkInterfaceAddress a :devices[i].addresses) {
				System.out.println("address: " + a.address + "   " + a.subnet + "   "+a.broadcast);
			}
			
			System.out.println();
		}
		System.out.println();
		System.out.println();
		
		
		/***打开网络接口设备*******/
		System.out.println("/***打开网络接口设备****/");
		//NetworkInterface[] devices1 = JpcapCaptor.getDeviceList();
		/*try {
			int index = 1 ;// 打开的网卡设备号
			//打开一个网络接口设备                                                                                       // 各参数(设备实例   ，   一次捕捉最大字节 ，是否为混乱模式 , 捕捉包的超时时间)
			JpcapCaptor captor = JpcapCaptor.openDevice(devices[index], 65535, false, 20);
			//jpcapCaptor 实例的功能是捕捉包  发送包不是它的责任
			System.out.println(captor);
			System.out.println(captor.getDeviceList());
			System.out.println(JpcapCaptor.getDeviceList());
			                                                                 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	*/	
		System.out.println();
		System.out.println();
		
		
		/***使用实例jpcapCaptor捕捉网络数据包******/
		System.out.println("/****使用实例jpcapCaptor捕捉网络数据包***/");
		try {
			//NetworkInterface[] devices_1 = JpcapCaptor.getDeviceList() ;
			int index = 3 ; // 自己电脑上的打开的网卡设备号
			// 打开一个网络接口设备 得到一个JpcapCaptor 实例
			JpcapCaptor captor = JpcapCaptor.openDevice(devices[index], 65535, false, 20);
			captor.setFilter("arp", true);
			//调用JpcapCaptor类的实例的loopPacket() 开始接受数据包
			
			int a = captor.loopPacket(2 , new Receiver()) ;// 第一个参数  一次接受包的数目
			//int a = captor.processPacket(-1, new Receiver()) ;// 接收超时 或 没有数据接收 立即返回
			System.out.println(captor.getPacket());System.out.println(a+"[]");
			
			// or 
			//captor.processPacket(1 , new Receiver()) ;
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
 
class  Receiver implements PacketReceiver { // 定义一个类   该类需实现receiverPacket()方法
 
	@Override
	public void receivePacket(Packet packet) {
		// TODO Auto-generated method stub
		
		System.out.println("========");
		System.out.println(packet);
		ARPPacket arp = (ARPPacket)packet ;
		System.out.println("硬件类型:     "+Integer.toHexString(arp.hardtype)); // short 转换为16进账字符串
		System.out.println("协议类型:     "+Integer.toHexString(arp.prototype));
		System.out.println("操作类型 :     "+Integer.toHexString(arp.operation));
		System.out.println("发送端MAC地址: "+arp.getSenderHardwareAddress());	
		System.out.println("发送端IP地址:  "+arp.getSenderProtocolAddress());
		System.out.println("目标MAC址:    "+arp.getTargetHardwareAddress());
		System.out.println("目标IP地址:    "+arp.getTargetProtocolAddress());
		//System.out.println("数据    "+arp.data);
		//System.out.println("数据    "+arp.ARP_REPLY);
		System.out.println();
	}
	
}
