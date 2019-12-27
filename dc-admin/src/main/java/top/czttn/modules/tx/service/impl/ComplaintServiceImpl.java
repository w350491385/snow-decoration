package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.service.DictService;
import top.czttn.modules.tx.dao.ComplaintDao;
import top.czttn.modules.tx.entity.ComplaintEntity;
import top.czttn.modules.tx.service.ComplaintService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("complaintService")
public class ComplaintServiceImpl extends ServiceImpl<ComplaintDao, ComplaintEntity> implements ComplaintService {
    @Resource
    private DictService dictService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<ComplaintEntity> list = this.baseMapper.findPageList(params,cpId);
        if (list != null && list.size() > 0) {
            Map<Long, String> mapByType = dictService.findMapByType(1007);
            for (ComplaintEntity entity : list) {
                entity.setComplaintTypeName(mapByType.get(entity.getComplaintType()));
            }
        }
        int total = this.baseMapper.findPageTotal(params,cpId);
        return new PageUtils(list, total, params);
    }

}
