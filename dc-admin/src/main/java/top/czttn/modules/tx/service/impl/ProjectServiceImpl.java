package top.czttn.modules.tx.service.impl;

import top.czttn.modules.sys.service.DictService;
import top.czttn.modules.tx.dao.PredictProjectDao;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.ProjectDao;
import top.czttn.modules.tx.entity.ProjectEntity;
import top.czttn.modules.tx.service.ProjectService;

import javax.annotation.Resource;


@Service("projectService")
public class ProjectServiceImpl extends ServiceImpl<ProjectDao, ProjectEntity> implements ProjectService {

    @Resource
    private DictService dictService;
    @Resource
    private PredictProjectDao predictProjectDao;
    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<ProjectEntity> page = this.selectPage(
                new Query<ProjectEntity>(params).getPage(),
                new EntityWrapper<ProjectEntity>()
                        .eq("type_id", params.get("typeId"))
                        .eq("cp_id", cpId)
        );
        if (null != page.getRecords() && page.getRecords().size() > 0) {
            Map<Long, String> dictMap = dictService.findMapByType(1026);
            for (ProjectEntity entity : page.getRecords()) {
                entity.setWorkTypeName(dictMap.get(entity.getWorkType()));
            }
        }
        return new PageUtils(page);
    }

    @Override
    public PageUtils fiterByPredictRoom(Map<String, Object> params, Long cpId) {
        List<Long> proIds = predictProjectDao.findIdByRoom(Long.valueOf(params.get("roomId").toString()),cpId);
        Page<ProjectEntity> page = this.selectPage(
                new Query<ProjectEntity>(params).getPage(),
                new EntityWrapper<ProjectEntity>()
                        .eq("type_id", params.get("typeId"))
                .notIn("id",proIds)
        );
        if (null != page.getRecords() && page.getRecords().size() > 0) {
            Map<Long, String> dictMap = dictService.findMapByType(1026);
            for (ProjectEntity entity : page.getRecords()) {
                entity.setWorkTypeName(dictMap.get(entity.getWorkType()));
            }
        }
        return new PageUtils(page);
    }

}
