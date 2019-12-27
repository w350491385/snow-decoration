package top.czttn.modules.tx.controller;

import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.sys.entity.DictEntity;
import top.czttn.modules.sys.service.DictService;
import top.czttn.modules.tx.entity.PredictProjectEntity;
import top.czttn.modules.tx.entity.PredictRoomEntity;
import top.czttn.modules.tx.entity.ProjectEntity;
import top.czttn.modules.tx.service.PredictProjectService;
import top.czttn.modules.tx.service.PredictRoomService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 空间工程预算
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@RestController
@RequestMapping("tx/predictproject")
public class PredictProjectController extends AbstractController {
    @Resource
    private PredictProjectService predictProjectService;
    @Resource
    private PredictRoomService predictRoomService;
    @Resource
    private DictService dictService;

    /**
     * 列表(条件查询所有)
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:predicttemplate:list")
    public R list(@RequestParam Map<String, Object> params) {
        List<PredictProjectEntity> list = predictProjectService.findList(params,getCpId());
        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:predicttemplate:info")
    public R info(@PathVariable("id") Long id) {
        PredictProjectEntity predictProject = predictProjectService.selectById(id);
        if (!predictProject.getCpId().equals(getCpId())) {
            return null;
        }
        PredictRoomEntity roomEntity = predictRoomService.selectById(predictProject.getRoomId());
        predictProject.setRoomName(roomEntity.getName());
        DictEntity dictEntity = dictService.selectById(predictProject.getWorkType());
        predictProject.setWorkTypeName(dictEntity.getName());
        return R.ok().put("predictproject", predictProject);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:predicttemplate:save")
    public R save(@RequestBody PredictProjectEntity predictProject) {
        predictProject.setCpId(getCpId());
        predictProjectService.insert(predictProject);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:predicttemplate:update")
    public R update(@RequestBody PredictProjectEntity predictProject) {
        PredictProjectEntity select = predictProjectService.selectById(predictProject.getId());
        if (select.getCpId().equals(getCpId())) {
            predictProjectService.updateById(predictProject);
        }

        return R.ok();
    }

    /**
     * 选择新增/修改
     */
    @RequestMapping("/choose")
    @RequiresPermissions("tx:predicttemplate:save")
    public R choose(@RequestBody PredictProjectEntity predictProject) {
        List<ProjectEntity> list = predictProject.getProjectList();
        Long roomId = predictProject.getRoomId();
        if (list != null && list.size() > 0) {
            List<PredictProjectEntity> saveList = new ArrayList<>();
            for (ProjectEntity entity : list) {
                PredictProjectEntity saveEntity = new PredictProjectEntity();
                saveEntity.setRoomId(roomId);
                saveEntity.setProjectId(entity.getId());
                saveEntity.setName(entity.getName());
                saveEntity.setWorkType(entity.getWorkType());
                saveEntity.setUnit(entity.getUnit());
                saveEntity.setAmount(BigDecimal.valueOf(0));
                saveEntity.setCpId(getCpId());
                saveList.add(saveEntity);
            }
            predictProjectService.insertBatch(saveList);
        }
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:predicttemplate:delete")
    public R delete(@RequestBody Long[] ids) {
        List<PredictProjectEntity> list = predictProjectService.selectBatchIds(Arrays.asList(ids));
        for (PredictProjectEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        predictProjectService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
