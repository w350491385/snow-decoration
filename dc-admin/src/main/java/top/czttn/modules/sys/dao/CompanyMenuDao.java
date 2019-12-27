package top.czttn.modules.sys.dao;

import top.czttn.modules.sys.entity.CompanyMenuEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 企业菜单权限
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-27 23:19:01
 */
@Mapper
public interface CompanyMenuDao extends BaseMapper<CompanyMenuEntity> {
    /**
     * 查询拥有菜单权限信息
     * @param cpId
     * @return
     */
    List<Long> queryMenuIdList(@Param("cpId") Long cpId);

    /**
     * 根据企业id删除企业菜单权限
     * @param cpId
     */
    void deleteByCpId(@Param("cpId") Long cpId);
}
