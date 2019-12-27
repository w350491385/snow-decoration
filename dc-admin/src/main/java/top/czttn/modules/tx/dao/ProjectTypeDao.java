package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.ProjectTypeEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 工程分类
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface ProjectTypeDao extends BaseMapper<ProjectTypeEntity> {
    /**
     *
     * @param params
     * @param cpId
     * @return
     */
    List<ProjectTypeEntity> findChooseList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);
}
