package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.CompanyMenuEntity;

import java.util.List;
import java.util.Map;

/**
 * 企业菜单权限
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-27 23:19:01
 */
public interface CompanyMenuService extends IService<CompanyMenuEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 查询拥有菜单权限信息
     * @param cpId
     * @return
     */
    List<Long> queryMenuIdList(Long cpId);

    /**
     * 根据企业id删除企业菜单权限
     * @param cpId
     */
    void deleteByCpId(Long cpId);
}

