package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.ServingTechEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 客户服务术语
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface ServingTechDao extends BaseMapper<ServingTechEntity> {
    /**
     *
     * @return
     */
    List<ServingTechEntity> findCommon();
}
