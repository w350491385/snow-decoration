package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.UserViewEntity;

import java.util.List;
import java.util.Map;

/**
 * 个人视野
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-26 22:09:11
 */
public interface UserViewService extends IService<UserViewEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 查询用户个人视野
     * @param userId
     * @return
     */
    List<Long> findPersonViewIdList(Long userId);

    /**
     * 更新个人视野
     * @param userId
     * @param personViewIdList
     */
    void saveOrUpdate(Long userId, List<Long> personViewIdList);

    /**
     *
     * @param userId
     */
    void deleteByUser(Long userId);
}

