package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.dao.ClientInfoDao;
import top.czttn.modules.tx.entity.ClientInfoEntity;
import top.czttn.modules.tx.service.ClientInfoService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("clientInfoService")
public class ClientInfoServiceImpl extends ServiceImpl<ClientInfoDao, ClientInfoEntity> implements ClientInfoService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId) {
        PageUtils.gennerParam(params);
        List<ClientInfoEntity> list = this.baseMapper.findPageList(params,cpId,userId);
        int total = this.baseMapper.findPageTotal(params,cpId,userId);

        return new PageUtils(list, total, params);
    }

}
