

package top.czttn.modules.sys.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.Constant;
import top.czttn.common.utils.MapUtils;
import top.czttn.modules.sys.dao.SysMenuDao;
import top.czttn.modules.sys.entity.SysMenuEntity;
import top.czttn.modules.sys.service.SysMenuService;
import top.czttn.modules.sys.service.SysRoleMenuService;
import top.czttn.modules.sys.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service("sysMenuService")
public class SysMenuServiceImpl extends ServiceImpl<SysMenuDao, SysMenuEntity> implements SysMenuService {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysRoleMenuService sysRoleMenuService;
	
	@Override
	public List<SysMenuEntity> queryListParentId(Long parentId, List<Long> menuIdList,Boolean ifAdmin) {
		List<SysMenuEntity> menuList = queryListParentId(parentId,ifAdmin);
		if(menuIdList == null){
			return menuList;
		}
		
		List<SysMenuEntity> userMenuList = new ArrayList<>();
		for(SysMenuEntity menu : menuList){
			if(menuIdList.contains(menu.getMenuId())){
				userMenuList.add(menu);
			}
		}
		return userMenuList;
	}

	@Override
	public List<SysMenuEntity> queryListParentId(Long parentId,Boolean ifAdmin) {
		List<SysMenuEntity> list = baseMapper.queryListParentId(parentId, ifAdmin);
		if (null != list && list.size() > 0) {
			for (SysMenuEntity entity : list) {
				entity.setIfUserAdmin(ifAdmin);
			}
		}
		return list;
	}

	@Override
	public List<SysMenuEntity> queryNotButtonList() {
		return baseMapper.queryNotButtonList();
	}

	@Override
	public List<SysMenuEntity> getUserMenuList(Long userId) {
		//系统管理员，拥有最高权限
		if(userId == Constant.SUPER_ADMIN){
			return getAllMenuList(null,true);
		}
		
		//用户菜单列表
		List<Long> menuIdList = sysUserService.queryAllMenuId(userId);
		return getAllMenuList(menuIdList, false);
	}

	@Override
	public void delete(Long menuId){
		//删除菜单
		this.deleteById(menuId);
		//删除菜单与角色关联
		sysRoleMenuService.deleteByMap(new MapUtils().put("menu_id", menuId));
	}

	/**
	 * 查询企业有的菜单权限
	 *
	 * @param cpId
	 * @return
	 */
	@Override
	public List<SysMenuEntity> findListByCpId(Long cpId) {
		return this.baseMapper.findListByCpId(cpId);
	}

	/**
	 * 查询所有菜单
	 *
	 * @return
	 */
	@Override
	public List<SysMenuEntity> findAllList() {
		return this.baseMapper.findAllList();
	}

	/**
	 * 获取所有菜单列表,过滤非超管菜单
	 */
	private List<SysMenuEntity> getAllMenuList(List<Long> menuIdList, boolean ifAdmin){
		//查询根菜单列表
		List<SysMenuEntity> menuList = queryListParentId(0L, menuIdList,ifAdmin);
		//递归获取子菜单
		getMenuTreeList(menuList, menuIdList,ifAdmin);
		
		return menuList;
	}

	/**
	 * 递归
	 */
	private List<SysMenuEntity> getMenuTreeList(List<SysMenuEntity> menuList, List<Long> menuIdList,Boolean ifAdmin){
		List<SysMenuEntity> subMenuList = new ArrayList<SysMenuEntity>();
		
		for(SysMenuEntity entity : menuList){
			//目录
			if(entity.getType() == Constant.MenuType.CATALOG.getValue()){
				entity.setList(getMenuTreeList(queryListParentId(entity.getMenuId(), menuIdList,ifAdmin), menuIdList,ifAdmin));
			}
			subMenuList.add(entity);
		}
		
		return subMenuList;
	}
}
