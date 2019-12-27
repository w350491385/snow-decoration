package top.czttn.modules.sys.service.impl;

import top.czttn.modules.sys.dao.DeptViewDao;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.DeptDao;
import top.czttn.modules.sys.entity.DeptEntity;
import top.czttn.modules.sys.service.DeptService;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


@Service("deptService")
public class DeptServiceImpl extends ServiceImpl<DeptDao, DeptEntity> implements DeptService {

    @Resource
    private DeptViewDao deptViewDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<DeptEntity> page = this.selectPage(
                new Query<DeptEntity>(params).getPage(),
                new EntityWrapper<DeptEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * 查询所有
     *
     * @param params
     * @param cpId
     * @return
     */
    @Override
    public List<DeptEntity> findAll(Map<String, Object> params, Long cpId) {
        return baseMapper.findAll(params, cpId);
    }

    /**
     * 根据部门id查询所有子集id
     *
     * @param deptId
     * @return
     */
    @Override
    public List<Long> findChildren(Long deptId) {
        List<Long> retlist = new ArrayList<>();
        List<DeptEntity> list = this.selectList(null);
        if (null != list && list.size() > 0) {
            retlist.add(deptId);
            this.children(deptId, list, retlist);
        }
        return retlist;
    }

    /**
     * @param id
     * @return
     */
    @Override
    public DeptEntity selectByParentId(Long id) {
        return this.baseMapper.selectByParentId(id);
    }

    /**
     * 删除组织
     *
     * @param id
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteDept(Long id) {
        // 删除部门视野
        this.deptViewDao.deleteByDept(id);
        //删除组织
        this.baseMapper.deleteById(id);

    }

    private void children(Long deptId, List<DeptEntity> sourcelist, List<Long> retlist) {
        for (DeptEntity entity : sourcelist) {
            if (entity.getParentId() != null && entity.getParentId().equals(deptId)) {
                retlist.add(entity.getId());
                this.children(entity.getId(), sourcelist, retlist);
            }
        }
    }
}
