package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.tx.dao.SysPositionDao;
import top.czttn.modules.tx.entity.SysPositionEntity;
import top.czttn.modules.tx.service.SysPositionService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("sysPositionService")
public class SysPositionServiceImpl extends ServiceImpl<SysPositionDao, SysPositionEntity> implements SysPositionService {
    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<SysPositionEntity> page;
        // 用户信息中无企业id默认为超管
        if (cpId == null) {
            page = this.selectPage(
                    new Query<SysPositionEntity>(params).getPage(),
                    new EntityWrapper<SysPositionEntity>()
                            .isNull("cp_id"));
        } else {
            page = this.selectPage(
                    new Query<SysPositionEntity>(params).getPage(),
                    new EntityWrapper<SysPositionEntity>()
                            .eq("cp_id", cpId)
            );
        }
        return new PageUtils(page);
    }

    @Override
    public List<SysPositionEntity> findCommonList() {
        return this.baseMapper.findCommonList();
    }

    @Override
    public List<String> findNameByUser(Long userId) {
        return this.baseMapper.findNameByUser(userId);
    }
}
