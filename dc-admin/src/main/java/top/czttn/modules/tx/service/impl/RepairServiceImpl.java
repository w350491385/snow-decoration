package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.RepairDao;
import top.czttn.modules.tx.entity.RepairEntity;
import top.czttn.modules.tx.service.RepairService;


@Service("repairService")
public class RepairServiceImpl extends ServiceImpl<RepairDao, RepairEntity> implements RepairService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<RepairEntity> page = this.selectPage(
                new Query<RepairEntity>(params).getPage(),
                new EntityWrapper<RepairEntity>()
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
