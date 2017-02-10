package com.sohu.sns.monitor.common.dao.notifyPerson;

import com.sohu.sns.monitor.common.module.NotifyPerson;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * author:jy
 * time:16-12-28下午3:20
 */
@Repository
public interface NotifyPersonDao {
    /**
     * 查询所有人
     */
    public List<NotifyPerson> getAllPerson();
    public void updatePerson(NotifyPerson np);
    public void deletePerson(NotifyPerson np);
    public void createPerson(NotifyPerson np);
}
