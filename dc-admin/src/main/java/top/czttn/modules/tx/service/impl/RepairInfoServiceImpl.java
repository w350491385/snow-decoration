package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.RepairInfoDao;
import top.czttn.modules.tx.entity.RepairInfoEntity;
import top.czttn.modules.tx.service.RepairInfoService;


@Service("repairInfoService")
public class RepairInfoServiceImpl extends ServiceImpl<RepairInfoDao, RepairInfoEntity> implements RepairInfoService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<RepairInfoEntity> page = this.selectPage(
                new Query<RepairInfoEntity>(params).getPage(),
                new EntityWrapper<RepairInfoEntity>()
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
