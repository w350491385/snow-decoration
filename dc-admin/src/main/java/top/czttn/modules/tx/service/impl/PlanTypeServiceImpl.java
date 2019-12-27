package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.tx.dao.PlanTypeDao;
import top.czttn.modules.tx.entity.PlanTypeEntity;
import top.czttn.modules.tx.service.PlanTypeService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("planTypeService")
public class PlanTypeServiceImpl extends ServiceImpl<PlanTypeDao, PlanTypeEntity> implements PlanTypeService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String name = params.get("name") == null ? "" : params.get("name").toString();
        Page<PlanTypeEntity> page = this.selectPage(
                new Query<PlanTypeEntity>(params).getPage(),
                new EntityWrapper<PlanTypeEntity>()
                        .like(StringUtils.isNotBlank(name), "name", "%" + name + "%")
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
