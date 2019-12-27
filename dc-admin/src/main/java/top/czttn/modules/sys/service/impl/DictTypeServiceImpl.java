package top.czttn.modules.sys.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.DictTypeDao;
import top.czttn.modules.sys.entity.DictTypeEntity;
import top.czttn.modules.sys.service.DictTypeService;

import javax.annotation.Resource;


@Service("dictTypeService")
public class DictTypeServiceImpl extends ServiceImpl<DictTypeDao, DictTypeEntity> implements DictTypeService {

    @Resource
    private DictTypeDao dictTypeDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String name = params.get("name") == null ? null : params.get("name").toString();
        Page<DictTypeEntity> page = this.selectPage(
                new Query<DictTypeEntity>(params).getPage(),
                new EntityWrapper<DictTypeEntity>()
                        .like(StringUtils.isNotBlank(name), "name", name)
        );

        return new PageUtils(page);
    }

    /**
     * 查询分类是否已存在
     *
     * @param dictType
     * @return
     */
    @Override
    public DictTypeEntity ifExit(DictTypeEntity dictType) {
        return dictTypeDao.ifExit(dictType);
    }

}
