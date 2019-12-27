package top.czttn.modules.sys.service.impl;

import top.czttn.modules.sys.service.ExportService;
import top.czttn.modules.tx.entity.PredictMaterialEntity;
import top.czttn.modules.tx.entity.PredictProjectEntity;
import top.czttn.modules.tx.entity.PredictRoomEntity;
import top.czttn.modules.tx.entity.PredictTemplateEntity;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.springframework.stereotype.Service;
import top.czttn.common.utils.DownLoadUtil;

import java.io.*;
import java.util.List;


@Service("exportService")
public class ExportServiceImpl implements ExportService {
    private HSSFWorkbook wb;
    /** 主标题 */
    private HSSFCellStyle cellStyle1;
    /** 副标题 */
    private HSSFCellStyle cellStyle2;
    /** 副标题 */
    private HSSFCellStyle cellStyleInfo;
    /** 内容 */
    private HSSFCellStyle cellStyleContent;
    /** 表头 */
    private HSSFCellStyle cellStyleHead;
    /** 合计*/
    private HSSFCellStyle cellStyleSub;

    /**
     * 导出报价表
     *
     * @param data
     * @return
     */
    @Override
    public String exportPredict(PredictTemplateEntity data) {
        this.init();
        HSSFSheet sheet = wb.createSheet("sheet1");
        sheet.setColumnWidth(0, 512 * 4);
        sheet.setColumnWidth(1, 512 * 15);
        sheet.setColumnWidth(2, 512 * 25);
        sheet.setColumnWidth(3, 512 * 6);
        sheet.setColumnWidth(4, 512 * 6);
        sheet.setColumnWidth(5, 512 * 6);
        sheet.setColumnWidth(6, 512 * 6);
        // 设置公司
        HSSFRow row0 = sheet.createRow(0);
        HSSFCell cell = row0.createCell(0);
        row0.setHeight((short) (25 * 20));
        cell.setCellValue(data.getCpName());
        cell.setCellStyle(cellStyle1);
        CellRangeAddress cellRangeAddress1 = new CellRangeAddress(0, 0, 0, 6);
        sheet.addMergedRegion(cellRangeAddress1);
        RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress1, sheet, wb);
        RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress1, sheet, wb);
        RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress1, sheet, wb);
        RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress1, sheet, wb);

        // 设置副标题
        HSSFRow row1 = sheet.createRow(1);
        row1.setHeight((short) (25 * 15));
        HSSFCell cell1 = row1.createCell(0);
        cell1.setCellValue("家庭居室装饰装修工程预算书");
        cell1.setCellStyle(cellStyle2);
        CellRangeAddress cellRangeAddress2 = new CellRangeAddress(1, 1, 0, 6);
        sheet.addMergedRegion(cellRangeAddress2);
        RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress2, sheet, wb);
        RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress2, sheet, wb);
        RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress2, sheet, wb);
        RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress2, sheet, wb);

        // 第3行
        HSSFRow row2 = sheet.createRow(2);
        HSSFCell cell2 = row2.createCell(0);
        cell2.setCellValue("工程名称：" + (data.getName() == null ? "" : data.getName()) + "        工程地点：" + (data.getProAddress() == null ? "" : data.getProAddress()));
        cell2.setCellStyle(cellStyleInfo);
        CellRangeAddress cellRangeAddress3 = new CellRangeAddress(2, 2, 0, 6);
        sheet.addMergedRegion(cellRangeAddress3);
        RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress3, sheet, wb);
        RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress3, sheet, wb);
        RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress3, sheet, wb);
        RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress3, sheet, wb);
        // 第4行
        HSSFRow row3 = sheet.createRow(3);
        HSSFCell cell3 = row3.createCell(0);
        cell3.setCellValue("公司地址：" + (data.getCpAddress() == null ? "" : data.getCpAddress()) + "        装修热线：" + (data.getPhone() == null ? "" : data.getPhone()));
        cell3.setCellStyle(cellStyleInfo);
        CellRangeAddress cellRangeAddress4 = new CellRangeAddress(3, 3, 0, 6);
        sheet.addMergedRegion(cellRangeAddress4);
        RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress4, sheet, wb);
        RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress4, sheet, wb);
        RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress4, sheet, wb);
        RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress4, sheet, wb);
        // 第5行
        HSSFRow row4 = sheet.createRow(4);
        HSSFCell cell4 = row4.createCell(0);
        cell4.setCellValue("客户姓名：" + (data.getClientName() == null ? "" : data.getClientName()));
        cell4.setCellStyle(cellStyleInfo);
        CellRangeAddress cellRangeAddress5 = new CellRangeAddress(4, 4, 0, 6);
        sheet.addMergedRegion(cellRangeAddress5);
        RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress5, sheet, wb);
        RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress5, sheet, wb);
        RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress5, sheet, wb);
        RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeAddress5, sheet, wb);
        /*-----------------------开始数据行---->*/
        int datarowIndex = 5;
        List<PredictRoomEntity> roomList = data.getRoomList();
        if (roomList != null && roomList.size() > 0) {
            for (int i = 0; i < roomList.size(); i++) {
                PredictRoomEntity roomEntity = roomList.get(i);
                HSSFRow row = sheet.createRow(datarowIndex);
                HSSFCell rowCell = row.createCell(0);
                rowCell.setCellValue((i + 1) + "." +  roomEntity.getName());
                rowCell.setCellStyle(cellStyleHead);
                CellRangeAddress cellRangeRoom = new CellRangeAddress(datarowIndex, datarowIndex, 0, 6);
                sheet.addMergedRegion(cellRangeRoom);
                RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeRoom, sheet, wb);
                RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeRoom, sheet, wb);
                RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeRoom, sheet, wb);
                RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeRoom, sheet, wb);
                datarowIndex++;

                HSSFRow rowhd = sheet.createRow(datarowIndex);
                HSSFCell cell50 = rowhd.createCell(0);
                cell50.setCellValue("序号");
                cell50.setCellStyle(cellStyleContent);
                HSSFCell cell51 = rowhd.createCell(1);
                cell51.setCellValue("项目/主材名称");
                cell51.setCellStyle(cellStyleContent);
                HSSFCell cell52 = rowhd.createCell(2);
                cell52.setCellValue("主材及辅料规格,品牌和工艺");
                cell52.setCellStyle(cellStyleContent);
                HSSFCell cell53 = rowhd.createCell(3);
                cell53.setCellValue("单位");
                cell53.setCellStyle(cellStyleContent);
                HSSFCell cell54 = rowhd.createCell(4);
                cell54.setCellValue("数量");
                cell54.setCellStyle(cellStyleContent);
                HSSFCell cell55 = rowhd.createCell(5);
                cell55.setCellValue("单价");
                cell55.setCellStyle(cellStyleContent);
                HSSFCell cell56 = rowhd.createCell(6);
                cell56.setCellValue("金额");
                cell56.setCellStyle(cellStyleContent);
                datarowIndex++;
                // 处理空间下施工项
                List<PredictProjectEntity> projectList = roomEntity.getProjectList();
                if (null != projectList && projectList.size() > 0) {
                    for (int j = 0; j < projectList.size(); j++) {
                        PredictProjectEntity entity = projectList.get(j);
                        HSSFRow prorow = sheet.createRow(datarowIndex);
                        HSSFCell proCell0 = prorow.createCell(0);
                        proCell0.setCellValue(j+1);
                        proCell0.setCellStyle(cellStyleContent);
                        HSSFCell proCell1 = prorow.createCell(1);
                        proCell1.setCellValue(entity.getName());
                        proCell1.setCellStyle(cellStyleContent);
                        HSSFCell proCell2 = prorow.createCell(2);
                        proCell2.setCellValue(entity.getRemark());
                        proCell2.setCellStyle(cellStyleContent);
                        HSSFCell proCell3 = prorow.createCell(3);
                        proCell3.setCellValue(entity.getUnit());
                        proCell3.setCellStyle(cellStyleContent);
                        HSSFCell proCell4 = prorow.createCell(4);
                        proCell4.setCellValue(entity.getAmount().toString());
                        proCell4.setCellStyle(cellStyleContent);
                        HSSFCell proCell5 = prorow.createCell(5);
                        proCell5.setCellValue(entity.getTotalPrice().toString());
                        proCell5.setCellStyle(cellStyleContent);
                        HSSFCell proCell6 = prorow.createCell(6);
                        proCell6.setCellValue(entity.getSalePrice().toString());
                        proCell6.setCellStyle(cellStyleContent);
                        datarowIndex++;
                    }
                }
                // 处理空间下主材
                List<PredictMaterialEntity> materialList = roomEntity.getMaterialList();
                if (null != materialList && materialList.size() > 0) {
                    for (int j = 0; j < materialList.size(); j++) {
                        PredictMaterialEntity entity = materialList.get(j);
                        HSSFRow mtrow = sheet.createRow(datarowIndex);
                        HSSFCell mtrowCell = mtrow.createCell(0);
                        mtrowCell.setCellValue(j+1);
                        mtrowCell.setCellStyle(cellStyleContent);
                        HSSFCell mtrowCell1 = mtrow.createCell(1);
                        mtrowCell1.setCellValue(entity.getMaterialName());
                        mtrowCell1.setCellStyle(cellStyleContent);
                        HSSFCell mtrowCell2 = mtrow.createCell(2);
                        mtrowCell2.setCellValue((entity.getBrandName() == null ? "" : entity.getBrandName()) + (entity.getModel() == null ? "" : entity.getModel()));
                        mtrowCell2.setCellStyle(cellStyleContent);
                        HSSFCell mtrowCell3 = mtrow.createCell(3);
                        mtrowCell3.setCellValue(entity.getUnit());
                        mtrowCell3.setCellStyle(cellStyleContent);
                        HSSFCell mtrowCell4 = mtrow.createCell(4);
                        mtrowCell4.setCellValue(entity.getAmount().toString());
                        mtrowCell4.setCellStyle(cellStyleContent);
                        HSSFCell mtrowCell5 = mtrow.createCell(5);
                        mtrowCell5.setCellValue(entity.getTotalPrice().toString());
                        mtrowCell5.setCellStyle(cellStyleContent);
                        HSSFCell mtrowCell6 = mtrow.createCell(6);
                        mtrowCell6.setCellValue(entity.getSalePrice().toString());
                        mtrowCell6.setCellStyle(cellStyleContent);
                        datarowIndex++;
                    }
                }
                // 小计
                HSSFRow row5 = sheet.createRow(datarowIndex);
                HSSFCell cell5 = row5.createCell(0);
                cell5.setCellValue("小计：" + (roomEntity.getSubtotal()==null?"":roomEntity.getSubtotal().toString()));
                cell5.setCellStyle(cellStyleSub);
                CellRangeAddress cellRangeSub1 = new CellRangeAddress(datarowIndex, datarowIndex, 0, 6);
                sheet.addMergedRegion(cellRangeSub1);
                RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
                RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
                RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
                RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
                datarowIndex++;
            }
            // 总计
            HSSFRow row5 = sheet.createRow(datarowIndex);
            HSSFCell cell5 = row5.createCell(0);
            cell5.setCellValue("总计：" + (data.getSalePrice()==null?"":data.getSalePrice().toString()));
            cell5.setCellStyle(cellStyleSub);
            CellRangeAddress cellRangeSub1 = new CellRangeAddress(datarowIndex, datarowIndex, 0, 6);
            sheet.addMergedRegion(cellRangeSub1);
            RegionUtil.setBorderTop(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
            RegionUtil.setBorderBottom(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
            RegionUtil.setBorderLeft(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
            RegionUtil.setBorderRight(HSSFBorderFormatting.BORDER_THIN, cellRangeSub1, sheet, wb);
        }

        // 流处理
        OutputStream tempout = null;
        FileInputStream fileInputStream = null;
        try {
            File tempFile = File.createTempFile("temp", ".xls");
            tempFile.deleteOnExit();
            tempout = new FileOutputStream(tempFile);
            wb.write(tempout);
            fileInputStream = new FileInputStream(tempFile);
            return DownLoadUtil.uploadFile2Database(fileInputStream);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (tempout != null) {
                    tempout.flush();
                    tempout.close();
                }
                if (fileInputStream != null) {
                    fileInputStream.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private void init() {
        wb = new HSSFWorkbook();
        //标题样式设置
        HSSFFont font1 = wb.createFont();
        font1.setFontName("宋体");
        font1.setFontHeightInPoints((short) 18);
        cellStyle1 = wb.createCellStyle();
        cellStyle1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle1.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyle1.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle1.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle1.setFont(font1);
        cellStyle1.setWrapText(true);
        //副标题
        HSSFFont font2 = wb.createFont();
        font2.setFontName("宋体");
        font2.setFontHeightInPoints((short) 12);
        cellStyle2 = wb.createCellStyle();
        cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle2.setFont(font2);
        cellStyle2.setWrapText(true);
        //表头
        HSSFFont head = wb.createFont();
        head.setFontName("宋体");
        head.setFontHeightInPoints((short) 12);
        cellStyleHead = wb.createCellStyle();
        cellStyleHead.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        cellStyleHead.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyleHead.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyleHead.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyleHead.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyleHead.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyleHead.setFont(head);
        cellStyleHead.setWrapText(true);
        cellStyleHead.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        cellStyleHead.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        cellStyleHead.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        cellStyleHead.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        //单元格数据样式设置
        HSSFFont content = wb.createFont();
        content.setFontName("宋体");
        content.setFontHeightInPoints((short) 12);
        cellStyleContent = wb.createCellStyle();
        cellStyleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyleContent.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyleContent.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyleContent.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyleContent.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyleContent.setFont(content);
        cellStyleContent.setWrapText(true);
        // 基本信息
        HSSFFont info = wb.createFont();
        info.setFontName("宋体");
        info.setFontHeightInPoints((short) 12);
        cellStyleInfo = wb.createCellStyle();
        cellStyleInfo.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        cellStyleInfo.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyleInfo.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyleInfo.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyleInfo.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyleInfo.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyleInfo.setFont(info);
        cellStyleInfo.setWrapText(true);
        // 合计
        HSSFFont subfont = wb.createFont();
        subfont.setFontName("宋体");
        subfont.setFontHeightInPoints((short) 12);
        subfont.setBoldweight((short) 600);
        cellStyleSub = wb.createCellStyle();
        cellStyleSub.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        cellStyleSub.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cellStyleSub.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyleSub.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyleSub.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyleSub.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyleSub.setFont(subfont);
        cellStyleSub.setWrapText(true);
    }

}
