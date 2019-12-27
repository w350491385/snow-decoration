package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.PredictRoomEntity;
import top.czttn.modules.tx.service.PredictMaterialService;
import top.czttn.modules.tx.service.PredictProjectService;
import top.czttn.modules.tx.service.PredictRoomService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * 模板空间
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@RestController
@RequestMapping("tx/predictroom")
public class PredictRoomController extends AbstractController {
    @Resource
    private PredictRoomService predictRoomService;
    @Resource
    private PredictMaterialService predictMaterialService;
    @Resource
    private PredictProjectService predictProjectService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:predicttemplate:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = predictRoomService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 根据模板id查询所有空间集合
     * @param templateId
     * @return
     */
    @RequestMapping("/all/{templateId}")
    @RequiresPermissions("tx:predicttemplate:list")
    public R all(@PathVariable("templateId") Long templateId) {
        EntityWrapper<PredictRoomEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("cp_id", getCpId());
        wrapper.eq("template_id", templateId);
        List<PredictRoomEntity> list = predictRoomService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:predicttemplate:info")
    public R info(@PathVariable("id") Long id) {
        PredictRoomEntity predictRoom = predictRoomService.selectById(id);
        if (!predictRoom.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("predictroom", predictRoom);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:predicttemplate:save")
    public R save(@RequestBody PredictRoomEntity predictRoom) {
        predictRoom.setCpId(getCpId());
        predictRoomService.insert(predictRoom);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:predicttemplate:update")
    public R update(@RequestBody PredictRoomEntity predictRoom) {
        PredictRoomEntity select = predictRoomService.selectById(predictRoom.getId());
        if (select.getCpId().equals(getCpId())) {
            predictRoomService.updateById(predictRoom);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:predicttemplate:delete")
    public R delete(@RequestBody Long id) {
        PredictRoomEntity one = predictRoomService.selectById(id);
        if (one!=null && !one.getCpId().equals(getCpId())) {
            return null;
        }
        predictRoomService.deleteOne(id);

        return R.ok();
    }

}
