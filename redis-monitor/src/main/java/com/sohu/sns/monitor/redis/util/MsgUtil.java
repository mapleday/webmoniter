package com.sohu.sns.monitor.redis.util;

import com.sohu.snscommon.utils.LOGGER;
import com.sohu.snscommon.utils.constant.ModuleEnum;
import com.sohu.snscommon.utils.http.HttpClientUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yzh on 2016/11/7.
 */
public class MsgUtil {
    /**
     * 发送微信通知
     *
     * @param url
     * @param phones
     * @param message
     * @return
     */
    public static boolean sendWeixin(String url, String phones, String message) {
        Map<String, String> map = new HashMap();
        map.put("phoneNo", phones);
        map.put("msg", message);
        try {
            HttpClientUtil.getStringByPost(url,map,null);
        } catch (IOException e) {
            LOGGER.errorLog(ModuleEnum.UTIL, "MsgUtil.sendWeiXin", message, "false", e);
            return false;
        }
        return true;
    }
}
