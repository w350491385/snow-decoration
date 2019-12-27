package top.czttn.modules.tx.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.CommunityDao;
import top.czttn.modules.tx.entity.CommunityEntity;
import top.czttn.modules.tx.service.CommunityService;


/**
 * @author czj
 */
@Service("communityService")
public class CommunityServiceImpl extends ServiceImpl<CommunityDao, CommunityEntity> implements CommunityService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String name = params.get("name") == null ? null : params.get("name").toString();
        Page<CommunityEntity> page = this.selectPage(
                new Query<CommunityEntity>(params).getPage(),
                new EntityWrapper<CommunityEntity>()
                        .like(StringUtils.isNotBlank(name), "name", name)
                        .eq(cpId != null, "cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
