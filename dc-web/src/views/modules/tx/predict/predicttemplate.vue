<template>
  <div class="mod-config">
    <el-row v-if="listVisible">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.name" placeholder="模板名称" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">查询</el-button>
          <el-button v-if="isAuth('tx:predicttemplate:save')" type="primary" @click="addOrUpdateHandle()">新增</el-button>
          <el-button v-if="isAuth('tx:predicttemplate:export')" type="success" @click="exportHandle()">导出报价表</el-button>
        </el-form-item>
      </el-form>
      <el-table
        :height="siteContentViewHeight"
        :data="dataList"
        border
        v-loading="dataListLoading"
        @selection-change="selectionChangeHandle"
        style="width: 100%;">
        <el-table-column
          type="selection"
          header-align="center"
          align="center"
          width="50">
        </el-table-column>
        <el-table-column
          prop="name"
          header-align="center"
          align="left"
          width="200"
          label="报价表名称">
        </el-table-column>
        <el-table-column
          prop="templateTypeName"
          header-align="center"
          align="center"
          width="120"
          label="报价表类型">
        </el-table-column>
        <!--<el-table-column-->
          <!--prop="clientName"-->
          <!--header-align="center"-->
          <!--align="center"-->
          <!--width="120"-->
          <!--label="关联客户">-->
          <!--<template slot-scope="scope">-->
            <!--<el-button type="text" @click="showClientInfo">{{scope.row.clientName}}</el-button>-->
          <!--</template>-->
        <!--</el-table-column>-->
        <el-table-column
          prop="rooms"
          header-align="center"
          align="center"
          label="包含空间">
        </el-table-column>
        <el-table-column
          prop="totalCost"
          header-align="center"
          align="center"
          width="120"
          label="总成本(元)">
        </el-table-column>
        <el-table-column
          prop="salePrice"
          header-align="center"
          align="center"
          width="120"
          label="销售总价(元)">
        </el-table-column>
        <el-table-column
          prop="profit"
          header-align="center"
          align="center"
          width="120"
          label="利润(元)">
        </el-table-column>
        <el-table-column
          fixed="right"
          header-align="center"
          align="center"
          width="200"
          label="操作">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="configHandle(scope.row)">配置</el-button>
            <el-button type="text" size="small" @click="cloneHandle(scope.row.id)">克隆</el-button>
            <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">修改</el-button>
            <el-button type="text" size="small" @click="deleteHandle(scope.row.id)">删除</el-button>
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
    </el-row>
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
    <!--配置页面-->
    <predictroom v-if="predictroomVisible" ref="predictroom" @refreshDataList="getDataList" @back="backList"></predictroom>
  </div>
</template>

<script>
  import AddOrUpdate from './predicttemplate-add-or-update'
  import Predictroom from './predictroom'
  import {Loading} from 'element-ui'

  export default {
    computed: {
      siteContentViewHeight () {
        return this.$store.state.common.documentClientHeight - 230
      }
    },
    data () {
      return {
        dataForm: {
          name: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false,
        predictroomVisible: false,
        listVisible: true
      }
    },
    components: {
      AddOrUpdate,
      Predictroom
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 显示客户信息
      showClientInfo () {
        // todo
      },
      backList () {
        this.listVisible = true
        this.getDataList()
      },
      // 克隆
      cloneHandle (id) {
        this.$http({
          url: this.$http.adornUrl(`/tx/predicttemplate/clone/${id}`),
          method: 'post',
          data: this.$http.adornData()
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
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/predicttemplate/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'name': this.dataForm.name
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
      // 配置模板
      configHandle (row) {
        this.listVisible = false
        this.predictroomVisible = true
        this.$nextTick(() => {
          this.$refs.predictroom.init(row)
        })
      },
      // 新增 / 修改
      addOrUpdateHandle (id) {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(id)
        })
      },
      // 导出
      exportHandle () {
        if (this.dataListSelections.length === 0 || this.dataListSelections.length > 1) {
          this.$message.warning('选择一条记录进行导出')
        } else {
          let loadingInstance1 = Loading.service({
            fullscreen: true,
            background: 'rgba(0,0,0,0.3)',
            text: '文件生成中，请稍后...'
          })
          this.$http({
            url: this.$http.adornUrl(`/tx/predicttemplate/export/${this.dataListSelections[0].id}`),
            method: 'get',
            data: this.$http.adornData(),
            responseType: 'blob'
          }).then((res) => {
            loadingInstance1.close()
            const blob = new Blob([res.data], {type: "type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'"})
            const fileName = decodeURIComponent(res.headers.filename)
            if ('download' in document.createElement('a')) { // 非IE下载
              const elink = document.createElement('a')
              elink.download = fileName
              elink.style.display = 'none'
              elink.href = URL.createObjectURL(blob)
              document.body.appendChild(elink)
              elink.click()
              URL.revokeObjectURL(elink.href) // 释放URL 对象
              document.body.removeChild(elink)
            } else { // IE10+下载
              navigator.msSaveBlob(blob, fileName)
            }
            this.$message({
              message: '导出成功',
              type: 'success',
              duration: 500,
              onClose: () => {
                this.getDataList()
              }
            })
          })
        }
      },
      // 删除
      deleteHandle (id) {
        this.$confirm('确定要删除吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl(`/tx/predicttemplate/delete/${id}`),
            method: 'post',
            data: this.$http.adornData()
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
