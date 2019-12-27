package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.BrandEntity;
import top.czttn.modules.tx.service.BrandService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 品牌维护
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/brand")
public class BrandController extends AbstractController {
    @Resource
    private BrandService brandService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:brand:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = brandService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 根据类型材料类型查询所有列表
     *
     * @param typeId
     * @return
     */
    @RequestMapping("/listByType")
    @RequiresPermissions("tx:brand:list")
    public R listByType(@RequestParam Long typeId) {
        Wrapper<BrandEntity> wrapper = new EntityWrapper<BrandEntity>().eq("type_id", typeId);
        wrapper.eq("cp_id", getCpId());
        List<BrandEntity> list = brandService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:brand:info")
    public R info(@PathVariable("id") Long id) {
        BrandEntity brand = brandService.selectById(id);
        if (!brand.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("brand", brand);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:brand:save")
    public R save(@RequestBody BrandEntity brand) {
        brand.setCpId(getCpId());
        brandService.insert(brand);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:brand:update")
    public R update(@RequestBody BrandEntity brand) {
        BrandEntity select = brandService.selectById(brand.getId());
        if (select.getCpId().equals(getCpId())) {
            brandService.updateById(brand);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:brand:delete")
    public R delete(@RequestBody Long[] ids) {
        List<BrandEntity> list = brandService.selectBatchIds(Arrays.asList(ids));
        for (BrandEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        brandService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
