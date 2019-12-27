package top.czttn.modules.sys.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.CompanyRegistDao;
import top.czttn.modules.sys.entity.CompanyRegistEntity;
import top.czttn.modules.sys.service.CompanyRegistService;


@Service("companyRegistService")
public class CompanyRegistServiceImpl extends ServiceImpl<CompanyRegistDao, CompanyRegistEntity> implements CompanyRegistService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<CompanyRegistEntity> page = this.selectPage(
                new Query<CompanyRegistEntity>(params).getPage(),
                new EntityWrapper<CompanyRegistEntity>()
        );

        return new PageUtils(page);
    }

}
