package top.czttn.modules.sys.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.MapUtils;
import top.czttn.modules.sys.dao.DeptViewDao;
import top.czttn.modules.sys.entity.DeptViewEntity;
import top.czttn.modules.sys.service.DeptViewService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


@Service("deptViewService")
public class DeptViewServiceImpl extends ServiceImpl<DeptViewDao, DeptViewEntity> implements DeptViewService {


    /**
     * 用户的部门视野
     *
     * @param userId
     * @return
     */
    @Override
    public List<Long> findDeptViewIdList(Long userId) {
        return this.baseMapper.findDeptViewIdList(userId);
    }

    /**
     * 更新部门视野
     *
     * @param userId
     * @param deptViewIdList
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void saveOrUpdate(Long userId, List<Long> deptViewIdList) {
        this.baseMapper.deleteByMap(new MapUtils().put("user_id", userId));
        if (deptViewIdList != null && deptViewIdList.size() > 0) {
            List<DeptViewEntity> list = new ArrayList<>();
            for (Long id : deptViewIdList) {
                DeptViewEntity entity = new DeptViewEntity();
                entity.setUserId(userId);
                entity.setViewId(id);
                list.add(entity);
            }
            this.insertBatch(list);
        }
    }

    /**
     * @param userId
     */
    @Override
    public void deleteByUser(Long userId) {
        this.baseMapper.deleteByUser(userId);
    }
}
