package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.modules.tx.entity.SysUserPositionEntity;

import java.util.List;


/**
 * 用户与角色对应关系
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:43:24
 */
public interface SysUserPositionService extends IService<SysUserPositionEntity> {

    /**
     * 保存用户与服务岗位关系
     * @param userId
     * @param positionList
     */
    void saveOrUpdate(Long userId, List<Long> positionList);

    /**
     * 查询用户的所有岗位
     * @param userId
     * @return
     */
    List<Long> queryPositionIdList(Long userId);

    /**
     *
     * @param userId
     */
    void deleteByUser(Long userId);
}
