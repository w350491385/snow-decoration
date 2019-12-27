package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.ComplaintEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 投诉管理
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface ComplaintDao extends BaseMapper<ComplaintEntity> {
    /**
     * 分页
     * @param params
     * @param cpId
     * @return
     */
    List<ComplaintEntity> findPageList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     * 分页
     * @param params
     * @param cpId
     * @return
     */
    int findPageTotal(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);
}
