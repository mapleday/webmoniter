package com.sohu.sns.monitor.common.dao.httpResource;

import com.sohu.sns.monitor.common.module.HttpResource;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * author:jy
 * time:16-10-14上午11:41
 * 资源配置类
 */
@Repository
public interface HttpResourceDAO {
    public List<HttpResource> getResources();
    public void updateResource(HttpResource hr);
    public void deleteResource(int id);
    public void createResource(HttpResource hr);

}
