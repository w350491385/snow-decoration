package top.czttn.modules.tx.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.BrandDao;
import top.czttn.modules.tx.entity.BrandEntity;
import top.czttn.modules.tx.service.BrandService;


@Service("brandService")
public class BrandServiceImpl extends ServiceImpl<BrandDao, BrandEntity> implements BrandService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String classId = params.get("typeId") == null ? "" : params.get("typeId").toString();
        String name = params.get("name") == null ? "" : params.get("name").toString();
        Page<BrandEntity> page = this.selectPage(
                new Query<BrandEntity>(params).getPage(),
                new EntityWrapper<BrandEntity>()
                        .eq("type_id", classId)
                        .like(StringUtils.isNotBlank(name), "name", name)
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
