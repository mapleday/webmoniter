package com.sohu.sns.monitor.httpmonitor;

import com.sohu.sns.monitor.httpmonitor.model.HttpResource;
import com.sohu.sns.monitor.httpmonitor.service.HttpResourceService;
import com.sohu.sns.monitor.httpmonitor.util.MysqlClusterServiceUtils;
import com.sohu.snscommon.utils.exception.SnsConfigException;
import com.sohu.snscommon.utils.zk.SnsDiamonds;
import com.sohu.snscommon.utils.zk.ZkUtils;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * Created by yzh on 2016/11/15.
 */
public class HttpMonitorServer {

    public static void main(String[] args) {
        ClassPathXmlApplicationContext context = null;
        try {
            ZkUtils.setZkConfigFilePath(args[0]);
            ZkUtils.initZkConfig(args[0]);
            SnsDiamonds.setDiamondsEnvBySystem();

            context = new ClassPathXmlApplicationContext("/httpMonitorContext.xml");
            System.in.read();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (context != null) {
                context.close();
            }
        }
    }
}
