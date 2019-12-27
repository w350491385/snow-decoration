

package top.czttn.modules.app.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.app.entity.UserEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户
 * 
 * @author czj
 * @email 493804781@qq.com
 * @date 2017-03-23 15:22:06
 */
@Mapper
public interface UserDao extends BaseMapper<UserEntity> {

}
