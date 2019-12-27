package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.tx.dao.ServingTechDao;
import top.czttn.modules.tx.entity.ServingTechEntity;
import top.czttn.modules.tx.service.ServingTechService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("servingTechService")
public class ServingTechServiceImpl extends ServiceImpl<ServingTechDao, ServingTechEntity> implements ServingTechService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<ServingTechEntity> page;
        if (cpId == null) {
            page = this.selectPage(
                    new Query<ServingTechEntity>(params).getPage(),
                    new EntityWrapper<ServingTechEntity>()
                            .isNull("cp_id")
            );
        } else {
            page = this.selectPage(
                    new Query<ServingTechEntity>(params).getPage(),
                    new EntityWrapper<ServingTechEntity>()
                            .eq("cp_id", cpId)
            );
        }

        return new PageUtils(page);
    }

    /**
     * @return
     */
    @Override
    public List<ServingTechEntity> findCommon() {
        return this.baseMapper.findCommon();
    }
}
