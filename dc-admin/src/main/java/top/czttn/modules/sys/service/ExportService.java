package top.czttn.modules.sys.service;

import top.czttn.modules.tx.entity.PredictTemplateEntity;

/**
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-27 23:19:01
 */
public interface ExportService {
    /**
     * 导出报价表
     * @param data
     * @return
     */
    String exportPredict(PredictTemplateEntity data);
}

