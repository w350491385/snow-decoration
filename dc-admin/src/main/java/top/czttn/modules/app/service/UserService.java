package top.czttn.modules.app.service;


import com.baomidou.mybatisplus.service.IService;
import top.czttn.modules.app.entity.UserEntity;
import top.czttn.modules.app.form.LoginForm;

/**
 * 用户
 * 
 * @author czj
 * @email 493804781@qq.com
 * @date 2017-03-23 15:22:06
 */
public interface UserService extends IService<UserEntity> {

	UserEntity queryByMobile(String mobile);

	/**
	 * 用户登录
	 * @param form    登录表单
	 * @return        返回用户ID
	 */
	long login(LoginForm form);
}
