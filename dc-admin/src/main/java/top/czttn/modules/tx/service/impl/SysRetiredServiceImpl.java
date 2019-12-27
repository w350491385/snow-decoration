package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.SysRetiredDao;
import top.czttn.modules.tx.entity.SysRetiredEntity;
import top.czttn.modules.tx.service.SysRetiredService;


@Service("sysRetiredService")
public class SysRetiredServiceImpl extends ServiceImpl<SysRetiredDao, SysRetiredEntity> implements SysRetiredService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<SysRetiredEntity> page = this.selectPage(
                new Query<SysRetiredEntity>(params).getPage(),
                new EntityWrapper<SysRetiredEntity>()
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
