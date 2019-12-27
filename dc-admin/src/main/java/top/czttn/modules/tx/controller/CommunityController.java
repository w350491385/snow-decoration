package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.CommunityEntity;
import top.czttn.modules.tx.service.CommunityService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 小区维护
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/community")
public class CommunityController extends AbstractController {
    @Resource
    private CommunityService communityService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:community:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = communityService.queryPage(params,getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 列表
     */
    @RequestMapping("/all")
    public R all() {
        EntityWrapper<CommunityEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("cp_id", getCpId());
        List<CommunityEntity> list = communityService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:community:info")
    public R info(@PathVariable("id") Long id) {
        CommunityEntity community = communityService.selectById(id);
        if (!community.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("community", community);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:community:save")
    public R save(@RequestBody CommunityEntity community) {
        community.setCpId(getCpId());
        communityService.insert(community);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:community:update")
    public R update(@RequestBody CommunityEntity community) {
        CommunityEntity select = communityService.selectById(community.getId());
        if (select.getCpId().equals(getCpId())) {
            communityService.updateById(community);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:community:delete")
    public R delete(@RequestBody Long[] ids) {
        List<CommunityEntity> list = communityService.selectBatchIds(Arrays.asList(ids));
        for (CommunityEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        communityService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
