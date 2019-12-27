

package top.czttn.modules.sys.dao;


import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.sys.entity.SysLogEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统日志
 * 
 * @author czj
 * @email 493804781@qq.com
 * @date 2017-03-08 10:40:56
 */
@Mapper
public interface SysLogDao extends BaseMapper<SysLogEntity> {
	
}
