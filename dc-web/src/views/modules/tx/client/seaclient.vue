<template>
  <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-input v-model="dataForm.clientName" placeholder="客户姓名" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button v-if="isAuth('tx:seaclient:save')" type="primary" @click="addOrUpdateHandle()">新增</el-button>
        <el-button v-if="isAuth('tx:seaclient:receive')" type="primary" @click="receiveHandle()" :disabled="dataListSelections.length <= 0">领取</el-button>
        <el-button v-if="isAuth('tx:seaclient:delete')" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
      </el-form-item>
    </el-form>
    <el-row>
      <el-dropdown trigger="click" :hide-on-click="false" style="cursor: pointer;float: right">
          <span class="el-dropdown-link">
            <span style="font-size: 12px;color: #00a0e9">设置</span>
            <i class="el-icon-menu"></i>
            <i class="el-icon-caret-bottom"></i>
          </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>
            <el-checkbox style="display: block;" v-model="item.visible" v-for="item in allCustomColumnList" :key="item.prpo">{{ item.label }}</el-checkbox>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </el-row>
    <elx-table
      :height="siteContentViewHeight"
      :custom-columns.sync="customColumns"
      :data="dataList"
      border
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      style="width: 100%;">
      <elx-table-column
        type="selection"
        header-align="center"
        align="center"
        width="50">
      </elx-table-column>
      <elx-table-column
        prop="clientName"
        header-align="center"
        align="center"
        label="客户姓名">
      </elx-table-column>
      <elx-table-column
        prop="phone" width="110"
        header-align="center"
        align="center"
        label="客户电话">
      </elx-table-column>
      <elx-table-column
        prop="sex"
        header-align="center"
        align="center"
        label="性别">
        <template slot-scope="scope">
          <el-tag >{{ scope.row.sex==='1'?'男':'女' }}</el-tag>
        </template>
      </elx-table-column>
      <elx-table-column
        prop="address"
        header-align="center"
        align="center"
        show-overflow-tooltip
        label="联系地址">
      </elx-table-column>
      <elx-table-column
        prop="busTypeName"
        header-align="center"
        align="center"
        label="业务类型">
      </elx-table-column>
      <elx-table-column
        prop="busPhaseName"
        header-align="center"
        align="center"
        label="阶段">
      </elx-table-column>
      <elx-table-column
        prop="roomTypeName"
        header-align="center"
        align="center"
        label="户型">
      </elx-table-column>
      <elx-table-column
        prop="houseTypeName"
        header-align="center"
        align="center"
        label="房型">
      </elx-table-column>
      <elx-table-column
        prop="usefulArea"
        header-align="center"
        align="center"
        width="120"
        label="实用面积(㎡)">
      </elx-table-column>
      <elx-table-column
        prop="buidArea"
        header-align="center"
        align="center"
        width="120"
        label="建筑面积(㎡)">
        <template slot-scope="scope">
          {{ scope.row.buidArea!==null?scope.row.buidArea+'㎡':'' }}
        </template>
      </elx-table-column>
      <elx-table-column
        prop="sourceName"
        header-align="center"
        align="center"
        width="100"
        label="数据来源">
      </elx-table-column>
      <elx-table-column
        prop="clientTypeName"
        header-align="center"
        align="center"
        width="100"
        label="客户类型">
      </elx-table-column>
      <elx-table-column
        prop="receiveCount"
        header-align="center"
        align="center"
        label="领取次数">
      </elx-table-column>
      <elx-table-column
        prop="hopeAmount"
        header-align="center"
        align="center"
        width="100"
        label="期望签单金额(元)">
      </elx-table-column>
      <elx-table-column
        prop="hopeTime"
        width="160"
        header-align="center"
        align="center"
        label="期望签单日">
      </elx-table-column>
      <elx-table-column
        prop="community"
        header-align="center"
        show-overflow-tooltip
        align="center"
        width="180"
        label="工程详细地址">
        <template slot-scope="scope">
          {{ scope.row.communityName!==null?scope.row.communityName+'小区':'' }}
          {{ scope.row.roof!==null?scope.row.roof+'栋':'' }}
          {{ scope.row.unit!==null?scope.row.unit+'单元':'' }}
          {{ scope.row.doorplate!==null?scope.row.doorplate+'号':'' }}
        </template>
      </elx-table-column>
      <elx-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="100"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">修改</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.id)">删除</el-button>
        </template>
      </elx-table-column>
    </elx-table>
    <el-pagination
      @size-change="sizeChangeHandle"
      @current-change="currentChangeHandle"
      :current-page="pageIndex"
      :page-sizes="[10, 20, 50, 100]"
      :page-size="pageSize"
      :total="totalPage"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import AddOrUpdate from './seaclient-add-or-update'
  export default {
    computed: {
      allCustomColumnList () {
        return this.customColumns.filter(item => item.prop)
      },
      siteContentViewHeight () {
        return this.$store.state.common.documentClientHeight - 230
      }
    },
    data () {
      return {
        dataForm: {
          clientName: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false,
        detailVisible: false,
        customColumns: []
      }
    },
    components: {
      AddOrUpdate
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/seaclient/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'clientName': this.dataForm.clientName
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
      },
      // 新增 / 修改
      addOrUpdateHandle (id) {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(id)
        })
      },
      // 删除
      deleteHandle (id) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.id
        })
        this.$confirm('确定要删除吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/tx/seaclient/delete'),
            method: 'post',
            data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 500,
                onClose: () => {
                  this.getDataList()
                }
              })
            } else {
              this.$message.error(data.msg)
            }
          })
        })
      },
      // 领取
      receiveHandle (id) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.id
        })
        this.$confirm('领取后将自动转到“我的客户”下，确定要领取吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'info'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/tx/seaclient/receive'),
            method: 'post',
            data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 500,
                onClose: () => {
                  this.getDataList()
                }
              })
            } else {
              this.$message.error(data.msg)
            }
          })
        })
      }
    }
  }
</script>
