package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.dao.ComplaintInfoDao;
import top.czttn.modules.tx.entity.ComplaintInfoEntity;
import top.czttn.modules.tx.service.ComplaintInfoService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("complaintInfoService")
public class ComplaintInfoServiceImpl extends ServiceImpl<ComplaintInfoDao, ComplaintInfoEntity> implements ComplaintInfoService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<ComplaintInfoEntity> list = this.baseMapper.findPageList(params,cpId);
        int total = this.baseMapper.findPageTotal(params,cpId);
        return new PageUtils(list, total, params);
    }

}
