package top.czttn.modules.sys.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.app.annotation.Login;
import top.czttn.modules.sys.entity.DictEntity;
import top.czttn.modules.sys.service.DictService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 字典
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@RestController
@RequestMapping("sys/dict")
public class DictController extends AbstractController {
    @Resource
    private DictService dictService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:dict:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = dictService.queryPage(params, super.getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 根据类型id查询字典
     */
    @RequestMapping("/listByType")
    @Login
    public R listByType(Long typeId) {
        Wrapper<DictEntity> wrapper = new EntityWrapper<DictEntity>().eq("type_id", typeId);
        wrapper.eq(super.getCpId() != null, "cp_id", super.getCpId());
        List<DictEntity> list = dictService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:dict:info")
    public R info(@PathVariable("id") Long id) {
        DictEntity dict = dictService.selectById(id);
        if (!dict.getCpId().equals(super.getCpId())) {
            return null;
        }

        return R.ok().put("dict", dict);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:dict:save")
    public R save(@RequestBody DictEntity dict) {
        DictEntity one = dictService.ifExit(dict, getCpId());
        if (one != null) {
            if (one.getName().equals(dict.getName())) {
                return R.error("该名称已存在");
            } else {
                return R.error("该编码已存在");
            }
        }
        dict.setCpId(super.getCpId());
        dictService.insert(dict);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:dict:update")
    public R update(@RequestBody DictEntity dict) {
        DictEntity select = dictService.selectById(dict.getId());
        if (select.getCpId().equals(super.getCpId())) {
            dictService.updateById(dict);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:dict:delete")
    public R delete(@RequestBody Long[] ids) {
        List<DictEntity> dictEntities = dictService.selectBatchIds(Arrays.asList(ids));
        for (DictEntity dictEntity : dictEntities) {
            if (!dictEntity.getCpId().equals(super.getCpId())) {
                return null;
            }
        }
        dictService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
