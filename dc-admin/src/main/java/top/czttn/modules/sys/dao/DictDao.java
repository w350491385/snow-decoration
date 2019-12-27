package top.czttn.modules.sys.dao;

import top.czttn.modules.sys.entity.DictEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 字典
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@Mapper
public interface DictDao extends BaseMapper<DictEntity> {

    DictEntity ifExit(@Param("dict") DictEntity dict, @Param("cpId") Long cpId);
}
