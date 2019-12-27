package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.PresaleDao;
import top.czttn.modules.tx.entity.PresaleEntity;
import top.czttn.modules.tx.service.PresaleService;


@Service("presaleService")
public class PresaleServiceImpl extends ServiceImpl<PresaleDao, PresaleEntity> implements PresaleService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<PresaleEntity> page = this.selectPage(
                new Query<PresaleEntity>(params).getPage(),
                new EntityWrapper<PresaleEntity>()
                .eq("cp_id",cpId
                )
        );

        return new PageUtils(page);
    }

}
