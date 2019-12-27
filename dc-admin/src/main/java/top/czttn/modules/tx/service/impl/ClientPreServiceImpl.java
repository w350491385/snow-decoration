package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.dao.ClientPreDao;
import top.czttn.modules.tx.entity.ClientPreEntity;
import top.czttn.modules.tx.service.ClientPreService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("clientPreService")
public class ClientPreServiceImpl extends ServiceImpl<ClientPreDao, ClientPreEntity> implements ClientPreService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId) {
        PageUtils.gennerParam(params);
        List<ClientPreEntity> list = this.baseMapper.findPageList(params,cpId,userId);
        int total = this.baseMapper.findPageTotal(params,cpId,userId);

        return new PageUtils(list, total, params);
    }


}
