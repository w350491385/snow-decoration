package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.tx.dao.MaterialTypeDao;
import top.czttn.modules.tx.entity.MaterialTypeEntity;
import top.czttn.modules.tx.service.MaterialTypeService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("materialTypeService")
public class MaterialTypeServiceImpl extends ServiceImpl<MaterialTypeDao, MaterialTypeEntity> implements MaterialTypeService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<MaterialTypeEntity> page = this.selectPage(
                new Query<MaterialTypeEntity>(params).getPage(),
                new EntityWrapper<MaterialTypeEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * 查询所有列表
     *
     * @param cpId
     * @return
     */
    @Override
    public List<MaterialTypeEntity> findAll(Long cpId) {
        return this.baseMapper.findAll(cpId);
    }

    /**
     * 查询所有分类
     *
     * @return
     */
    @Override
    public Map<String, String> findMapAll(Long cpId) {
        List<MaterialTypeEntity> all = this.baseMapper.findAll(cpId);
        Map<String, String> map = null;
        if (!all.isEmpty()) {
            map = new HashMap<>();
            for (MaterialTypeEntity entity : all) {
                map.put(entity.getId().toString(), entity.getTypeName());
            }
        }
        return map;
    }
}
