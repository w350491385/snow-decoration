package top.czttn.modules.sys.service.impl;

import top.czttn.modules.sys.entity.CompanyMenuEntity;
import top.czttn.modules.sys.service.CompanyMenuService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.CompanyDao;
import top.czttn.modules.sys.entity.CompanyEntity;
import top.czttn.modules.sys.service.CompanyService;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


@Service("companyService")
public class CompanyServiceImpl extends ServiceImpl<CompanyDao, CompanyEntity> implements CompanyService {

    @Resource
    private CompanyMenuService companyMenuService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<CompanyEntity> page = this.selectPage(
                new Query<CompanyEntity>(params).getPage(),
                new EntityWrapper<CompanyEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * 保存企业
     *
     * @param company
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void save(CompanyEntity company) {
        this.baseMapper.insert(company);
        List<Long> menuIdList = company.getMenuIdList();
        if (menuIdList != null && menuIdList.size() > 0) {
            List<CompanyMenuEntity> list = new ArrayList<>();
            for (Long menuId : menuIdList) {
                CompanyMenuEntity entity = new CompanyMenuEntity();
                entity.setCpId(company.getCpId());
                entity.setMenuId(menuId);
                list.add(entity);
            }
            companyMenuService.insertBatch(list);
        }
    }

    /**
     * 修改企业
     *
     * @param company
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void modify(CompanyEntity company) {
        this.baseMapper.updateById(company);
        companyMenuService.deleteByCpId(company.getCpId());
        List<Long> menuIdList = company.getMenuIdList();
        if (menuIdList != null && menuIdList.size() > 0) {
            List<CompanyMenuEntity> list = new ArrayList<>();
            for (Long menuId : menuIdList) {
                CompanyMenuEntity entity = new CompanyMenuEntity();
                entity.setCpId(company.getCpId());
                entity.setMenuId(menuId);
                list.add(entity);
            }
            companyMenuService.insertBatch(list);
        }
    }

    /**
     * 删除企业
     *
     * @param id
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteComany(Long id) {
        this.baseMapper.deleteById(id);
        companyMenuService.deleteByCpId(id);
    }
}
