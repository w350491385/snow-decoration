package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;

import top.czttn.modules.tx.dao.TargetDao;
import top.czttn.modules.tx.entity.TargetEntity;
import top.czttn.modules.tx.service.TargetService;


@Service("targetService")
public class TargetServiceImpl extends ServiceImpl<TargetDao, TargetEntity> implements TargetService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<TargetEntity> list = this.baseMapper.findPageList(params,cpId);
        int total = this.baseMapper.findPageTotal(params,cpId);

        return new PageUtils(list,total,params);
    }

}
