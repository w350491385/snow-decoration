package top.czttn.modules.sys.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.sys.entity.SysMenuEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 菜单管理
 * 
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:33:01
 */
@Mapper
public interface SysMenuDao extends BaseMapper<SysMenuEntity> {
	
	/**
	 * 根据父菜单，查询子菜单
	 * @param parentId 父菜单ID
	 * @param ifAdmin
	 */
	List<SysMenuEntity> queryListParentId(@Param("parentId") Long parentId, @Param("ifAdmin") Boolean ifAdmin);
	
	/**
	 * 获取不包含按钮的菜单列表
	 */
	List<SysMenuEntity> queryNotButtonList();

	/**
	 * 查询企业有的菜单权限
	 * @param cpId
	 * @return
	 */
    List<SysMenuEntity> findListByCpId(@Param("cpId") Long cpId);

	/**
	 * 查询所有菜单
	 * @return
	 */
	List<SysMenuEntity> findAllList();

}
