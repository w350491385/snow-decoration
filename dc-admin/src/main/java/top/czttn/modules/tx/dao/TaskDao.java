package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.TaskEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 任务
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface TaskDao extends BaseMapper<TaskEntity> {
	
}
