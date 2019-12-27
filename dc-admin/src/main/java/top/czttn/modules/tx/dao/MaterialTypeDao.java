package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.MaterialTypeEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 材料分类
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface MaterialTypeDao extends BaseMapper<MaterialTypeEntity> {
    /**
     * 查询所有
     * @return
     * @param cpId
     */
    List<MaterialTypeEntity> findAll(@Param("cpId") Long cpId);
}
