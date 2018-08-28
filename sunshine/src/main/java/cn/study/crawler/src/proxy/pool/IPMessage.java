package cn.study.crawler.src.proxy.pool;

import java.io.Serializable;

public class IPMessage implements Serializable {
    private static final long serialVersionUID = 1L;
    private String IPAddress;
    private String IPPort;
    private String IPType="HTTPS";
    private String IPSpeed="3秒";
    private int useCount;            // 使用计数器，连续三次这个IP不能使用，就将其从IP代理池中进行清除

    public IPMessage() { this.useCount = 0; }

    public IPMessage(String IPAddress, String IPPort, String IPType, String IPSpeed) {
        this.IPAddress = IPAddress;
        this.IPPort = IPPort;
        this.IPType = IPType;
        this.IPSpeed = IPSpeed;
        this.useCount = 0;
    }

    public String getIPAddress() {
        return IPAddress;
    }

    public void setIPAddress(String IPAddress) {
        this.IPAddress = IPAddress;
    }

    public String getIPPort() {
        return IPPort;
    }

    public void setIPPort(String IPPort) {
        this.IPPort = IPPort;
    }

    public String getIPType() {
        return IPType;
    }

    public void setIPType(String IPType) {
        this.IPType = IPType;
    }

    public String getIPSpeed() {
        return IPSpeed;
    }

    public void setIPSpeed(String IPSpeed) {
        this.IPSpeed = IPSpeed;
    }

    public int getUseCount() {
        return useCount;
    }

    public void setUseCount() {
        this.useCount++;
    }

    public void initCount() {
        this.useCount = 0;
    }

    @Override
    public String toString() {
        return "IPMessage{" +
                "IPAddress='" + IPAddress + '\'' +
                ", IPPort='" + IPPort + '\'' +
                ", IPType='" + IPType + '\'' +
                ", IPSpeed='" + IPSpeed + '\'' +
                ", useCount='" + useCount + '\'' +
                '}';
    }
}

