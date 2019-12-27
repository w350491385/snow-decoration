package top.czttn.modules.tx.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.SupplierDao;
import top.czttn.modules.tx.entity.SupplierEntity;
import top.czttn.modules.tx.service.SupplierService;


@Service("supplierService")
public class SupplierServiceImpl extends ServiceImpl<SupplierDao, SupplierEntity> implements SupplierService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String name = params.get("name") == null ? "" : params.get("name").toString();
        Page<SupplierEntity> page = this.selectPage(
                new Query<SupplierEntity>(params).getPage(),
                new EntityWrapper<SupplierEntity>().like(StringUtils.isNotBlank(name), "name", "%" + name + "%")
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
