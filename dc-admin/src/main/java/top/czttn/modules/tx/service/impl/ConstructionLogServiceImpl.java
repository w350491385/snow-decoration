package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;

import top.czttn.modules.tx.dao.ConstructionLogDao;
import top.czttn.modules.tx.entity.ConstructionLogEntity;
import top.czttn.modules.tx.service.ConstructionLogService;


@Service("constructionLogService")
public class ConstructionLogServiceImpl extends ServiceImpl<ConstructionLogDao, ConstructionLogEntity> implements ConstructionLogService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<ConstructionLogEntity> list = this.baseMapper.findPageList(params,cpId);
        int total = this.baseMapper.findPageTotal(params,cpId);

        return new PageUtils(list, total, params);
    }

}
