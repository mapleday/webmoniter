package com.sohu.sns.monitor.common.services;

import com.sohu.sns.monitor.common.dao.errorLogStat.ErrorLogStatDao;
import com.sohu.sns.monitor.common.module.AppInfo;
import com.sohu.sns.monitor.common.module.ErrorLogStat;
import org.apache.commons.lang.time.DateFormatUtils;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by yw on 2017/3/23.
 */
@Service
public class ErrorLogStatService {
    @Autowired
    private ErrorLogStatDao errorLogStatDao;

    public void updatErrorLogStat(ErrorLogStat errorLogStat){
        errorLogStatDao.updateErrorLogStat(errorLogStat);
    }

    public String getISOTime() {
        String currentISOTime,startISOTime,today;
        Calendar todayStartTime = Calendar.getInstance();
        Date now = todayStartTime.getTime();
        todayStartTime.set(Calendar.HOUR_OF_DAY, 0);
        todayStartTime.set(Calendar.MINUTE, 0);
        todayStartTime.set(Calendar.SECOND, 0);
        todayStartTime.set(Calendar.MILLISECOND, 0);
        Date start = todayStartTime.getTime();
        String IOSTimepattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
        String dayPattern = "yyyy.MM.dd";
        currentISOTime = DateFormatUtils.format(now.getTime() - 60 * 60 * 1000 * 8, IOSTimepattern);
        startISOTime = DateFormatUtils.format(start.getTime() - 60 * 60 * 1000 * 8, IOSTimepattern);
        today = DateFormatUtils.format(now, dayPattern);
        return currentISOTime+"_"+startISOTime+"_"+today;
    }

    public void handleAppIdsBucketIt(List<ErrorLogStat> errStatList, Iterator<Terms.Bucket> appIdsBucketIt,AppInfoService appInfoService) {
        while (appIdsBucketIt.hasNext()) {
            ErrorLogStat errorLogStat = new ErrorLogStat();
            Terms.Bucket appIdBucket = appIdsBucketIt.next();
            String appInfo = appIdBucket.getKeyAsString();
            String appIdInstanceInfo[] = appInfo.replace("\"", "").split("_");
            if (appIdInstanceInfo.length > 1) {
                errorLogStat.setInstanceId(appIdInstanceInfo[1]);
            }
            errorLogStat.setAppId(appIdInstanceInfo[0]);
            errorLogStat.setErrorCount((int) appIdBucket.getDocCount());
            List<AppInfo> appInfoList = appInfoService.getAppInfo(appIdInstanceInfo[0]);
            if (!appInfoList.isEmpty()) {
                errorLogStat.setAppName(appInfoList.get(0).getAppName());
                errorLogStat.setAppDeveloper(appInfoList.get(0).getAppDeveloper());
            }
            errStatList.add(errorLogStat);
            //写入数据库
            List<ErrorLogStat> result=null;
            String instanceId=errorLogStat.getInstanceId();
            //处理appId为0的情况
            if (instanceId==null)
            {
                result=errorLogStatDao.existNullAppId(errorLogStat);
            }
            else {
                result=errorLogStatDao.getErrorLogStatById(errorLogStat);
            }
            //执行数据库操作
            if (!result.isEmpty())
            {
                errorLogStatDao.updateErrorLogStat(errorLogStat);
            }else {
                errorLogStatDao.insertErrorLogStat(errorLogStat);
            }
        }
    }
}
