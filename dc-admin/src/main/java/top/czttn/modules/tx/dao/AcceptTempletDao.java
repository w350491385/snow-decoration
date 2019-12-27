package top.czttn.modules.tx.dao;

import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import top.czttn.modules.tx.entity.AcceptTempletEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 验收模板
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface AcceptTempletDao extends BaseMapper<AcceptTempletEntity> {
    /**
     * 分页查询
     * @param page
     * @param params
     * @param cpId
     * @return
     */
    List<AcceptTempletEntity> findPageList(Pagination page, @Param("params") Map<String, Object> params, @Param("cpId") Long cpId);
}
