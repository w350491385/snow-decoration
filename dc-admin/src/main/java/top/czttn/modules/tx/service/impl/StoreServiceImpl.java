package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.tx.dao.StoreDao;
import top.czttn.modules.tx.entity.StoreEntity;
import top.czttn.modules.tx.service.StoreService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("storeService")
public class StoreServiceImpl extends ServiceImpl<StoreDao, StoreEntity> implements StoreService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String name = params.get("name") == null ? "" : params.get("name").toString();
        Page<StoreEntity> page = this.selectPage(
                new Query<StoreEntity>(params).getPage(),
                new EntityWrapper<StoreEntity>()
                        .like(StringUtils.isNotBlank(name), "name", "%" + name + "%")
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
