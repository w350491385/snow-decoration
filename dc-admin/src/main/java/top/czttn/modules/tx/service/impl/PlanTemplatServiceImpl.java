package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;

import top.czttn.modules.tx.dao.PlanTemplatDao;
import top.czttn.modules.tx.entity.PlanTemplatEntity;
import top.czttn.modules.tx.service.PlanTemplatService;


@Service("planTemplatService")
public class PlanTemplatServiceImpl extends ServiceImpl<PlanTemplatDao, PlanTemplatEntity> implements PlanTemplatService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {

        Page<PlanTemplatEntity> page = new Page<>();
        List<PlanTemplatEntity> list = this.baseMapper.findPageList(page, params,cpId);
        page.setRecords(list);
        return new PageUtils(page);
    }

}
