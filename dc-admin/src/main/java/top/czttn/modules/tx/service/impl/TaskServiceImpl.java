package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.tx.dao.TaskDao;
import top.czttn.modules.tx.entity.TaskEntity;
import top.czttn.modules.tx.service.TaskService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("taskService")
public class TaskServiceImpl extends ServiceImpl<TaskDao, TaskEntity> implements TaskService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        String launchMan = params.get("launchMan") == null ? "" : params.get("launchMan").toString();
        Page<TaskEntity> page = this.selectPage(
                new Query<TaskEntity>(params).getPage(),
                new EntityWrapper<TaskEntity>()
                        .like(StringUtils.isNotBlank(launchMan), "launch_man", launchMan)
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
