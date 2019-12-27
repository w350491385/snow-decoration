package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.AttendanceDao;
import top.czttn.modules.tx.entity.AttendanceEntity;
import top.czttn.modules.tx.service.AttendanceService;


@Service("attendanceService")
public class AttendanceServiceImpl extends ServiceImpl<AttendanceDao, AttendanceEntity> implements AttendanceService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<AttendanceEntity> page = this.selectPage(
                new Query<AttendanceEntity>(params).getPage(),
                new EntityWrapper<AttendanceEntity>()
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
