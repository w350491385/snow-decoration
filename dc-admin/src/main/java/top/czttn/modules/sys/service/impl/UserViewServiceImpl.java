package top.czttn.modules.sys.service.impl;

import top.czttn.common.utils.MapUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.UserViewDao;
import top.czttn.modules.sys.entity.UserViewEntity;
import top.czttn.modules.sys.service.UserViewService;
import org.springframework.transaction.annotation.Transactional;


@Service("userViewService")
public class UserViewServiceImpl extends ServiceImpl<UserViewDao, UserViewEntity> implements UserViewService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<UserViewEntity> page = this.selectPage(
                new Query<UserViewEntity>(params).getPage(),
                new EntityWrapper<UserViewEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * 查询用户个人视野
     *
     * @param userId
     * @return
     */
    @Override
    public List<Long> findPersonViewIdList(Long userId) {
        return this.baseMapper.findPersonViewIdList(userId);
    }

    /**
     * 更新个人视野
     *
     * @param userId
     * @param personViewIdList
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void saveOrUpdate(Long userId, List<Long> personViewIdList) {
        this.deleteByMap(new MapUtils().put("user_id", userId));
        if (personViewIdList != null && personViewIdList.size() > 0) {
            List<UserViewEntity> list = new ArrayList<>();
            for (Long id : personViewIdList) {
                UserViewEntity entity = new UserViewEntity();
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
