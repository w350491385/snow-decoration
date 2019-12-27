package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.CompanyEntity;

import java.util.Map;

/**
 * 
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-26 23:07:39
 */
public interface CompanyService extends IService<CompanyEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 保存企业
     * @param company
     */
    void save(CompanyEntity company);

    /**
     * 修改企业
     * @param company
     */
    void modify(CompanyEntity company);

    /**
     * 删除企业
     * @param id
     */
    void deleteComany(Long id);
}

