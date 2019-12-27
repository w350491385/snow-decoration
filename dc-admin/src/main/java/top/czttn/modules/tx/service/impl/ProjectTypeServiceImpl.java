package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.ProjectTypeDao;
import top.czttn.modules.tx.entity.ProjectTypeEntity;
import top.czttn.modules.tx.service.ProjectTypeService;


@Service("projectTypeService")
public class ProjectTypeServiceImpl extends ServiceImpl<ProjectTypeDao, ProjectTypeEntity> implements ProjectTypeService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ProjectTypeEntity> page = this.selectPage(
                new Query<ProjectTypeEntity>(params).getPage(),
                new EntityWrapper<ProjectTypeEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * @param params
     * @param cpId
     * @return
     */
    @Override
    public List<ProjectTypeEntity> findChooseList(Map<String, Object> params, Long cpId) {
        return this.baseMapper.findChooseList(params,cpId);
    }

}
