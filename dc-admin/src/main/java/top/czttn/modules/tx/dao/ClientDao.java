package top.czttn.modules.tx.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.tx.entity.ClientEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 我的客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface ClientDao extends BaseMapper<ClientEntity> {
    /**
     * 更新逃单字段
     *
     * @param clientEntity
     */
    void updateEscape(@Param("clientEntity") ClientEntity clientEntity);

    /**
     * 领取
     *
     * @param ids
     * @param userId
     */
    void receive(@Param("ids") String ids, @Param("userId") Long userId);

    /**
     * 转入公海
     *
     * @param ids
     */
    void sea(@Param("ids") String ids);

    /**
     * @param userId
     */
    void moveToPubByUserId(@Param("userId") Long userId);

    /**
     *
     * @param id
     * @return
     */
    List<ClientEntity> findByUser(@Param("id") Long id);

    /**
     *
     * @param ids
     * @param targetUser
     */
    void exchange(@Param("ids") String ids, @Param("targetUser") Long targetUser);
}
