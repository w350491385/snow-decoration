package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.DeptEntity;

import java.util.List;
import java.util.Map;

/**
 * 部门
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
public interface DeptService extends IService<DeptEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 查询所有
     * @param params
     * @param cpId
     * @return
     */
    List<DeptEntity> findAll(Map<String, Object> params, Long cpId);

    /**
     * 根据部门id查询所有子集id
     * @param deptId
     * @return
     */
    List<Long> findChildren(Long deptId);

    /**
     *
     * @param id
     * @return
     */
    DeptEntity selectByParentId(Long id);

    /**
     * 删除组织
     * @param id
     */
    void deleteDept(Long id);
}

