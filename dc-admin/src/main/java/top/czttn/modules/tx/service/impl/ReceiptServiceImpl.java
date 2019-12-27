package top.czttn.modules.tx.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.ReceiptDao;
import top.czttn.modules.tx.entity.ReceiptEntity;
import top.czttn.modules.tx.service.ReceiptService;


@Service("receiptService")
public class ReceiptServiceImpl extends ServiceImpl<ReceiptDao, ReceiptEntity> implements ReceiptService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<ReceiptEntity> page = this.selectPage(
                new Query<ReceiptEntity>(params).getPage(),
                new EntityWrapper<ReceiptEntity>()
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

}
