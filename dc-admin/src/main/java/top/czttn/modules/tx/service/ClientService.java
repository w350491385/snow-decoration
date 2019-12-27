package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ClientEntity;

import java.util.List;
import java.util.Map;

/**
 * 客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ClientService extends IService<ClientEntity> {
    /**
     * @param params
     * @param cpId
     * @param userId
     * @return
     */
    PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId);

    /**
     * 转为逃单客户
     *
     * @param list
     */
    void escape(List<ClientEntity> list);

    /**
     * 领取
     *
     * @param ids
     * @param userId
     */
    void receive(Long[] ids, Long userId);

    /**
     * 转入公海
     *
     * @param ids
     */
    void sea(Long[] ids);

    /**
     * 旗下客户转到公海池
     *
     * @param userId
     */
    void moveToPubByUserId(Long userId);

    /**
     * @param id
     * @return
     */
    List<ClientEntity> findByUser(Long id);

    /**
     * 转客户
     * @param clientIdList
     * @param targetUser
     */
    void exchange(List<Long> clientIdList, Long targetUser);
}

