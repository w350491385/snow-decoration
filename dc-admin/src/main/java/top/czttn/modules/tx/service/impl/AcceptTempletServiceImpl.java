package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.dao.AcceptTempletDao;
import top.czttn.modules.tx.entity.AcceptTempletEntity;
import top.czttn.modules.tx.service.AcceptTempletService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("acceptTempletService")
public class AcceptTempletServiceImpl extends ServiceImpl<AcceptTempletDao, AcceptTempletEntity> implements AcceptTempletService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<AcceptTempletEntity> page = new Page<>();
        List<AcceptTempletEntity> list = this.baseMapper.findPageList(page, params, cpId);
        page.setRecords(list);
        return new PageUtils(page);
    }

}
