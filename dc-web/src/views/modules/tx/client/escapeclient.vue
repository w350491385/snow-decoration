<template>
  <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item label="客户姓名:">
        <el-input v-model="dataForm.key" placeholder="关键词查询" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button v-if="isAuth('tx:escapeclient:sea')" type="primary" @click="seaHandle()" :disabled="dataListSelections.length <= 0">转入公海</el-button>
        <el-button v-if="isAuth('tx:escapeclient:delete')" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
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
        prop="phone"
        width="100"
        header-align="center"
        align="center"
        label="客户电话">
      </elx-table-column>
      <elx-table-column
        prop="sex"
        width="60"
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
        show-overflow-tooltip
        align="center"
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
        prop="houseTypeName"
        header-align="center"
        align="center"
        label="房型">
      </elx-table-column>
      <elx-table-column
        prop="escape"
        header-align="center"
        align="center"
        label="逃单描述">
      </elx-table-column>
      <elx-table-column
        prop="remark"
        header-align="center"
        align="center"
        label="备注">
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
  </div>
</template>

<script>
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
          key: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false,
        customColumns: []
      }
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/escapeclient/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'key': this.dataForm.key
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
            url: this.$http.adornUrl('/tx/escapeclient/delete'),
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
      // 转入公海
      seaHandle (id) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.id
        })
        this.$confirm('确定转入公海?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/tx/escapeclient/sea'),
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
