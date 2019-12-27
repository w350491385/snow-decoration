package top.czttn.modules.sys.dao;

import top.czttn.modules.sys.entity.DeptEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 部门
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@Mapper
public interface DeptDao extends BaseMapper<DeptEntity> {
    /**
     * 查询所有
     * @param params
     * @param cpId
     * @return
     */
    List<DeptEntity> findAll(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     *
     * @param id
     * @return
     */
    DeptEntity selectByParentId(@Param("id") Long id);
}
