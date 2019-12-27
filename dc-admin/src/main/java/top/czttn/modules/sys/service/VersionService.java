package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.VersionEntity;

import java.util.Map;

/**
 * 
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-07-08 10:53:36
 */
public interface VersionService extends IService<VersionEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

