package top.czttn.modules.sys.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.CompanyMenuDao;
import top.czttn.modules.sys.entity.CompanyMenuEntity;
import top.czttn.modules.sys.service.CompanyMenuService;


@Service("companyMenuService")
public class CompanyMenuServiceImpl extends ServiceImpl<CompanyMenuDao, CompanyMenuEntity> implements CompanyMenuService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<CompanyMenuEntity> page = this.selectPage(
                new Query<CompanyMenuEntity>(params).getPage(),
                new EntityWrapper<CompanyMenuEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * 查询拥有菜单权限信息
     *
     * @param cpId
     * @return
     */
    @Override
    public List<Long> queryMenuIdList(Long cpId) {
        return this.baseMapper.queryMenuIdList(cpId);
    }

    /**
     * 根据企业id删除企业菜单权限
     *
     * @param cpId
     */
    @Override
    public void deleteByCpId(Long cpId) {
        this.baseMapper.deleteByCpId(cpId);
    }


}
