package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.CompanyRegistEntity;

import java.util.Map;

/**
 * 
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-04-08 16:12:46
 */
public interface CompanyRegistService extends IService<CompanyRegistEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

