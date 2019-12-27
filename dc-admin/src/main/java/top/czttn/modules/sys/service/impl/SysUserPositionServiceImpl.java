package top.czttn.modules.sys.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.MapUtils;
import top.czttn.modules.sys.dao.SysUserPositionDao;
import top.czttn.modules.sys.service.SysUserPositionService;
import top.czttn.modules.tx.entity.SysUserPositionEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


/**
 * 用户与角色对应关系
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:45:48
 */
@Service("sysUserPositionService")
public class SysUserPositionServiceImpl extends ServiceImpl<SysUserPositionDao, SysUserPositionEntity> implements SysUserPositionService {
    /**
     * 保存用户与服务岗位关系
     *
     * @param userId
     * @param positionList
     */
    @Transactional
    @Override
    public void saveOrUpdate(Long userId, List<Long> positionList) {
        // 删除用户与服务岗位关系
        this.deleteByMap(new MapUtils().put("user_id", userId));
        if (positionList == null || positionList.size() == 0) {
            return;
        }
        //保存用户与岗位关系
        List<SysUserPositionEntity> list = new ArrayList<>();
        for (Long aLong : positionList) {
            SysUserPositionEntity entity = new SysUserPositionEntity();
            entity.setPositionId(aLong);
            entity.setUserId(userId);
            list.add(entity);
        }
        this.insertBatch(list);
    }

    /**
     * 查询用户的所有岗位
     *
     * @param userId
     * @return
     */
    @Override
    public List<Long> queryPositionIdList(Long userId) {
        return baseMapper.queryPositionIdList(userId);
    }

    /**
     * @param userId
     */
    @Override
    public void deleteByUser(Long userId) {
        this.baseMapper.deleteByUser(userId);
    }
}
