package top.czttn.modules.sys.service.impl;

import com.baomidou.mybatisplus.mapper.Wrapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.DictDao;
import top.czttn.modules.sys.entity.DictEntity;
import top.czttn.modules.sys.service.DictService;

import javax.annotation.Resource;


@Service("dictService")
public class DictServiceImpl extends ServiceImpl<DictDao, DictEntity> implements DictService {

    @Resource
    private DictDao dictDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String name = params.get("name") == null ? null : params.get("name").toString();
        String typeId = params.get("typeId") == null ? null : params.get("typeId").toString();
        Page<DictEntity> page = this.selectPage(
                new Query<DictEntity>(params).getPage(),
                new EntityWrapper<DictEntity>()
                        .eq(StringUtils.isNotBlank(typeId), "type_id", typeId)
                        .like(StringUtils.isNotBlank(name), "name", name)
                        .eq(cpId != null, "cp_id", cpId)
        );

        return new PageUtils(page);
    }

    /**
     * 名称和编码查询是否存在
     *
     * @param dict
     * @param cpId
     * @return
     */
    @Override
    public DictEntity ifExit(DictEntity dict, Long cpId) {
        return dictDao.ifExit(dict,cpId);
    }

    /**
     * 根据字典类型查询map
     *
     * @param typeId
     * @return
     */
    @Override
    public Map<Long, String> findMapByType(long typeId) {
        Wrapper<DictEntity> wrapper = new EntityWrapper<DictEntity>().eq("type_id", typeId);
        List<DictEntity> list = dictDao.selectList(wrapper);
        Map<Long, String> retmap = null;
        if (!list.isEmpty()) {
            retmap = new HashMap<>();
            for (DictEntity entity : list) {
                retmap.put(entity.getId(), entity.getName());
            }
        }
        return retmap;
    }
}
