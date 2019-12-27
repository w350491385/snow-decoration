package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.AcceptTypeDao;
import top.czttn.modules.tx.entity.AcceptTypeEntity;
import top.czttn.modules.tx.service.AcceptTypeService;


@Service("acceptTypeService")
public class AcceptTypeServiceImpl extends ServiceImpl<AcceptTypeDao, AcceptTypeEntity> implements AcceptTypeService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<AcceptTypeEntity> page = this.selectPage(
                new Query<AcceptTypeEntity>(params).getPage(),
                new EntityWrapper<AcceptTypeEntity>()
                        .eq(cpId != null, "cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
