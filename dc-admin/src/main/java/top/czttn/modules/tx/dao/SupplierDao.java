package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.SupplierEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 供应商管理
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface SupplierDao extends BaseMapper<SupplierEntity> {
	
}
