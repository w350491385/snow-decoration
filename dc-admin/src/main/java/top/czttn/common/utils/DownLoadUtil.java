package top.czttn.common.utils;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.net.URLEncoder;

/**
 * @author czj
 * @date 2018/5/7.
 * @company 南京斯普顿
 */
public class DownLoadUtil {

    /**
     * @param fis 文件流
     * @return String
     * @throws IOException IO异常
     */
    public static String uploadFile2Database(FileInputStream fis)
            throws IOException {
        StringWriter sw = new StringWriter();
        int len = 1;
        byte[] temp = new byte[len];

        /* 16进制转化模块 */
        for (; (fis.read(temp, 0, len)) != -1; ) {
            if (temp[0] > 0xf) {
                sw.write(Integer.toHexString(temp[0]));
                //对于只有1位的16进制数前边补“0”
            } else if (temp[0] >= 0x0 && temp[0] <= 0xf) {
                sw.write("0" + Integer.toHexString(temp[0]));
            } else { // 对于int<0的位转化为16进制的特殊处理，因为Java没有Unsigned
                // int，所以这个int可能为负数
                sw.write(Integer.toHexString(temp[0]).substring(6));
            }
        }
        return sw.toString();
    }

    /**
     * @param sos      输出流
     * @param replaced 替换
     * @throws NumberFormatException 转换异常
     * @throws IOException           io异常
     */
    private static void writeNew2Binary(ServletOutputStream sos, String replaced)
            throws NumberFormatException, IOException {
        for (int i = 0; i < replaced.length(); i = i + 2) {
            sos.write(Integer.parseInt(replaced.substring(i, i + 2), 16));
        }
    }

    /**
     * 文件下载
     *
     * @param response    响应
     * @param fileName    文件名
     * @param fileContent 文件内容
     */
    public static void downFile(HttpServletResponse response, String fileName, String fileContent) {
        try {
            // 从页面下载的流
            response.setHeader("Content-disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));
            response.addHeader("filename", URLEncoder.encode(fileName, "UTF-8"));
            response.addHeader("Access-Control-Expose-Headers", "filename");
            response.setContentLength((int) fileContent.length() / 2);
            response.setContentType("application/x-download");
            // 文件名编码转换
            ServletOutputStream servletOutputStream = response.getOutputStream();
            writeNew2Binary(servletOutputStream, fileContent);
            servletOutputStream.flush();
            servletOutputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
