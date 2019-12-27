package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.sys.service.DeptViewService;
import top.czttn.modules.sys.service.DictService;
import top.czttn.modules.sys.service.SysUserService;
import top.czttn.modules.sys.service.UserViewService;
import top.czttn.modules.tx.dao.ClientDao;
import top.czttn.modules.tx.dao.CommunityDao;
import top.czttn.modules.tx.entity.ClientEntity;
import top.czttn.modules.tx.entity.CommunityEntity;
import top.czttn.modules.tx.service.ClientService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service("formalClientService")
public class ClientServiceImpl extends ServiceImpl<ClientDao, ClientEntity> implements ClientService {

    @Resource
    private DictService dictService;
    @Resource
    private CommunityDao communityDao;
    @Resource
    private UserViewService userViewService;
    @Resource
    private DeptViewService deptViewService;
    @Resource
    private SysUserService sysUserService;

    /**
     * @param params
     * @param cpId
     * @param userId
     * @return
     */
    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId) {
        // 查询个人视野，部门视野
        String userviewIds;
        String deptviewIds;
        List<Long> userview = userViewService.findPersonViewIdList(userId);
        List<Long> deptView = deptViewService.findDeptViewIdList(userId);
        if (deptView != null && deptView.size() > 0) {
            deptviewIds = StringUtils.join(deptView, ",");
            List<Long> userIds = sysUserService.findByDeptIds(deptviewIds);
            if (userview == null && userIds != null && userIds.size() > 0) {
                userview = new ArrayList<>(userIds);
            }
        }
        if (userview != null && userview.size() > 0) {
            userview.add(userId);
            userviewIds = StringUtils.join(userview, ",");
        } else {
            userviewIds = userId.toString();
        }
        // 查询数据类型
        int dataType = params.get("dataType") == null ? 0 : Integer.parseInt(params.get("dataType").toString());
        String clientName = params.get("clientName") != null ? params.get("clientName").toString() : "";
        String clientCode = params.get("clientCode") != null ? params.get("clientCode").toString() : "";
        EntityWrapper<ClientEntity> wrapper = new EntityWrapper<>();

        wrapper.like(StringUtils.isNotBlank(clientName), "client_name", clientName);
        wrapper.like(StringUtils.isNotBlank(clientCode), "client_code", clientCode);
        wrapper.eq("cp_id", cpId);
        if (dataType == 1) {
            // 我的客户
            wrapper.isNull("escape");
            // 添加视野
            wrapper.in("belong_id", userviewIds);
        } else if (dataType == 2) {
            // 逃单客户
            wrapper.isNotNull("escape");
            // 添加视野
            wrapper.in("belong_id", userviewIds);
        } else {
            wrapper.isNull("belong_id");
        }
        Page<ClientEntity> page = this.selectPage(new Query<ClientEntity>(params).getPage(), wrapper);
        if (page.getRecords() != null && page.getRecords().size() > 0) {
            // 查询码表
            Map<Long, String> source = dictService.findMapByType(1005);
            Map<Long, String> busPhase = dictService.findMapByType(1003);
            Map<Long, String> roomType = dictService.findMapByType(1024);
            Map<Long, String> busType = dictService.findMapByType(1004);
            Map<Long, String> clientType = dictService.findMapByType(1006);
            Map<Long, String> houseType = dictService.findMapByType(1011);
            for (ClientEntity record : page.getRecords()) {
                if (record.getCommunity() != null) {
                    CommunityEntity communityEntity = communityDao.selectById(record.getCommunity());
                    record.setCommunityName(communityEntity.getName());
                }
                record.setSourceName(source.get(record.getSource()));
                record.setBusPhaseName(busPhase.get(record.getBusPhase()));
                record.setRoomTypeName(roomType.get(record.getRoomType()));
                record.setBusTypeName(busType.get(record.getBusType()));
                record.setClientTypeName(clientType.get(record.getClientType()));
                record.setHouseTypeName(houseType.get(record.getHouseType()));
                if (record.getPaidAmount() != null && record.getContractAmount() != null && !record.getContractAmount().equals(new BigDecimal("0"))) {
                    record.setPaidPercent(record.getPaidAmount().divide(record.getContractAmount(), 0));
                }
            }
        }


        return new PageUtils(page);
    }

    /**
     * 转为逃单客户
     *
     * @param list
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void escape(List<ClientEntity> list) {
        for (ClientEntity clientEntity : list) {
            this.baseMapper.updateEscape(clientEntity);
        }
    }

    /**
     * 领取
     *
     * @param ids
     * @param userId
     */
    @Override
    public void receive(Long[] ids, Long userId) {
        if (null != ids && ids.length > 0) {
            StringBuilder upids = new StringBuilder();
            for (Long id : ids) {
                upids.append(",").append(id);
            }
            this.baseMapper.receive(upids.substring(1), userId);
        }
    }

    /**
     * 转入公海
     *
     * @param ids
     */
    @Override
    public void sea(Long[] ids) {
        if (null != ids && ids.length > 0) {
            StringBuilder str = new StringBuilder();
            for (Long id : ids) {
                str.append(",").append(id);
            }
            this.baseMapper.sea(str.substring(1));
        }
    }

    /**
     * 旗下客户转到公海池
     *
     * @param userId
     */
    @Override
    public void moveToPubByUserId(Long userId) {
        this.baseMapper.moveToPubByUserId(userId);
    }

    /**
     * @param id
     * @return
     */
    @Override
    public List<ClientEntity> findByUser(Long id) {
        return this.baseMapper.findByUser(id);
    }

    /**
     * 转客户
     *
     * @param clientIdList
     * @param targetUser
     */
    @Override
    public void exchange(List<Long> clientIdList, Long targetUser) {
        String ids = StringUtils.join(clientIdList, ',');
        this.baseMapper.exchange(ids, targetUser);
    }
}
