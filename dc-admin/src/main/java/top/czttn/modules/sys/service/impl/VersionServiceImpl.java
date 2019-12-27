package top.czttn.modules.sys.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.sys.dao.VersionDao;
import top.czttn.modules.sys.entity.VersionEntity;
import top.czttn.modules.sys.service.VersionService;


@Service("versionService")
public class VersionServiceImpl extends ServiceImpl<VersionDao, VersionEntity> implements VersionService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<VersionEntity> page = this.selectPage(
                new Query<VersionEntity>(params).getPage(),
                new EntityWrapper<VersionEntity>().orderBy("update_time", false)
        );

        return new PageUtils(page);
    }

}
