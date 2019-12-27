package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.modules.sys.entity.DeptViewEntity;

import java.util.List;

/**
 * 部门视野
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-26 22:09:11
 */
public interface DeptViewService extends IService<DeptViewEntity> {

    /**
     * 用户的部门视野
     * @param userId
     * @return
     */
    List<Long> findDeptViewIdList(Long userId);

    /**
     * 更新部门视野
     * @param userId
     * @param deptViewIdList
     */
    void saveOrUpdate(Long userId, List<Long> deptViewIdList);

    /**
     *
     * @param userId
     */
    void deleteByUser(Long userId);
}

