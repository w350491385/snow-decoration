<template>
  <el-dialog title="选择客户"
             :close-on-click-modal="false"
             :visible.sync="visible">
    <el-form  :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item label="客户姓名：">
        <el-input v-model="dataForm.clientName" placeholder="关键词搜索" clearable></el-input>
      </el-form-item>
      <el-form-item label="客户编码：">
        <el-input v-model="dataForm.clientCode" placeholder="关键词搜索" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button v-if="isAuth('tx:formalclient:save') && showAll" type="primary" @click="addOrUpdateHandle()">新增</el-button>
        <el-button v-if="isAuth('tx:formalclient:delete') && showAll" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      border
      @row-click="selectOne"
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      style="width: 100%;">
      <el-table-column
        v-if="showAll"
        type="selection"
        header-align="center"
        align="center"
        width="50">
      </el-table-column>
      <el-table-column
        prop="clientName"
        header-align="center"
        align="center"
        label="客户姓名">
      </el-table-column>
      <el-table-column
        prop="phone"
        header-align="center"
        width="100"
        align="center"
        label="客户电话">
      </el-table-column>
      <el-table-column
        prop="clientCode"
        v-if="showClientCode || showAll"
        header-align="center"
        align="center"
        label="客户编码">
      </el-table-column>
      <el-table-column
        prop="sex"
        header-align="center"
        align="center"
        label="性别">
        <template slot-scope="scope">
          <el-tag >{{ scope.row.sex==='1'?'男':'女' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="address"
        v-if="showAddress || showAll"
        header-align="center"
        align="center"
        show-overflow-tooltip
        label="联系地址">
      </el-table-column>
      <el-table-column
        v-if="showBusTypeName || showAll"
        prop="busTypeName"
        header-align="center"
        align="center"
        label="业务类型">
      </el-table-column>
      <el-table-column
        prop="busPhaseName"
        v-if="showBusPhaseName || showAll"
        header-align="center"
        align="center"
        label="阶段">
      </el-table-column>
      <el-table-column
        prop="roomTypeName"
        v-if="showRoomTypeName || showAll"
        header-align="center"
        align="center"
        label="户型">
      </el-table-column>
      <el-table-column
        prop="houseTypeName"
        v-if="showHouseTypeName || showAll"
        header-align="center"
        align="center"
        label="房型">
      </el-table-column>
      <el-table-column
        prop="usefulArea"
        v-if="showUsefulArea || showAll"
        header-align="center"
        align="center"
        label="实用面积(㎡)">
      </el-table-column>
      <el-table-column
        prop="buidArea"
        v-if="showBuidArea || showAll"
        header-align="center"
        align="center"
        label="建筑面积(㎡)">
      </el-table-column>
      <el-table-column
        prop="status"
        v-if="showStatus || showAll"
        header-align="center"
        align="center"
        label="所处状态">
        <template slot-scope="scope">
          <el-tag >{{
            scope.row.status==='1'?'开发中':scope.row.status==='2'?'已签约':scope.row.status==='3'?'未开工':scope.row.status==='4'?'已开工':scope.row.status==='5'?'已交付':'开发中' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="receiveTime"
        v-if="showReceiveTime || showAll"
        header-align="center"
        align="center"
        width="90"
        label="领取时间">
      </el-table-column>
      <el-table-column
        prop="sourceName"
        v-if="showSourceName || showAll"
        header-align="center"
        align="center"
        label="数据来源">
      </el-table-column>
      <el-table-column
        prop="clientTypeName"
        v-if="showClientTypeName || showAll"
        header-align="center"
        align="center"
        label="客户类型">
      </el-table-column>
      <el-table-column
        prop="hopeAmount"
        v-if="showHopeAmount || showAll"
        header-align="center"
        align="center"
        label="期望签单金额">
      </el-table-column>
      <el-table-column
        prop="hopeTime"
        v-if="showHopeTime || showAll"
        header-align="center"
        align="center"
        width="90"
        label="期望签单日期">
      </el-table-column>
      <el-table-column
        prop="contractAmount"
        v-if="showContractAmount || showAll"
        header-align="center"
        align="center"
        label="合同金额">
      </el-table-column>
      <el-table-column
        prop="paidAmount"
        v-if="showPaidAmount || showAll"
        header-align="center"
        align="center"
        label="已收款/收款百分比">
      </el-table-column>
      <el-table-column
        prop="unfollwedDays"
        v-if="showUnfollwedDays || showAll"
        header-align="center"
        align="center"
        label="未跟进天数">
      </el-table-column>
      <el-table-column
        prop="community"
        v-if="showCommunity || showAll"
        header-align="center"
        show-overflow-tooltip
        align="center"
        label="工程详细地址">
        <template slot-scope="scope">
          {{ scope.row.communityName!==null?scope.row.communityName+'小区':'' }}
          {{ scope.row.roof!==null?scope.row.roof+'栋':'' }}
          {{ scope.row.unit!==null?scope.row.unit+'单元':'' }}
          {{ scope.row.doorplate!==null?scope.row.doorplate+'号':'' }}
        </template>
      </el-table-column>
      <el-table-column
        v-if="showOp || showAll"
        fixed="right"
        header-align="center"
        align="center"
        width="150"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="chooseHandle(scope.row.id)">选择</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="sizeChangeHandle"
      @current-change="currentChangeHandle"
      :current-page="pageIndex"
      :page-sizes="[10, 20, 50, 100]"
      :page-size="pageSize"
      :total="totalPage"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">关闭</el-button>
      </span>
  </el-dialog>
</template>

<script>
  export default {
    props: {
      showClientCode: {
        type: Boolean,
        default: false
      },
      showAddress: {
        type: Boolean,
        default: false
      },
      showBusTypeName: {
        type: Boolean,
        default: false
      },
      showBusPhaseName: {
        type: Boolean,
        default: false
      },
      showRoomTypeName: {
        type: Boolean,
        default: false
      },
      showHouseTypeName: {
        type: Boolean,
        default: false
      },
      showUsefulArea: {
        type: Boolean,
        default: false
      },
      showBuidArea: {
        type: Boolean,
        default: false
      },
      showStatus: {
        type: Boolean,
        default: false
      },
      showReceiveTime: {
        type: Boolean,
        default: false
      },
      showSourceName: {
        type: Boolean,
        default: false
      },
      showClientTypeName: {
        type: Boolean,
        default: false
      },
      showHopeAmount: {
        type: Boolean,
        default: false
      },
      showHopeTime: {
        type: Boolean,
        default: false
      },
      showContractAmount: {
        type: Boolean,
        default: false
      },
      showPaidAmount: {
        type: Boolean,
        default: false
      },
      showCommunity: {
        type: Boolean,
        default: false
      },
      showUnfollwedDays: {
        type: Boolean,
        default: false
      },
      showOp: {
        type: Boolean,
        default: false
      },
      showAll: {
        type: Boolean,
        default: true
      },
      value: {}
    },
    data () {
      return {
        dataForm: {
          clientName: '',
          clientCode: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        selectSingle: this.value,
        visible: false
      }
    },
    methods: {
      selectOne (row) {
        this.selectSingle = row
        this.$emit('change', this.selectSingle)
        this.visible = false
      },
      init () {
        this.visible = true
        this.$nextTick(() => {
          this.getDataList()
        })
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/formalclient/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'clientName': this.dataForm.clientName,
            'clientCode': this.dataForm.clientCode
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.page.list
            this.totalPage = data.page.totalCount
          } else {
            this.dataList = []
            this.totalPage = 0
          }
          this.dataListLoading = false
        })
      },
      // 每页数
      sizeChangeHandle (val) {
        this.pageSize = val
        this.pageIndex = 1
        this.getDataList()
      },
      // 当前页
      currentChangeHandle (val) {
        this.pageIndex = val
        this.getDataList()
      },
      // 多选
      selectionChangeHandle (val) {
        this.dataListSelections = val
      }
    }
  }
</script>
