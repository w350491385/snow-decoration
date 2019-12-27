<template>
  <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-input v-model="dataForm.name" placeholder="材料名" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button v-if="isAuth('tx:material:save')" type="primary" @click="addHandle()">新增</el-button>
        <el-button v-if="isAuth('tx:material:delete')" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
      </el-form-item>
    </el-form>
    <el-table
      empty-text="该材料分类下无数据"
      :height="siteContentViewHeight"
      :data="dataList"
      border
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      style="width: 100%;">
      <el-table-column
        type="selection"
        align="center"
        width="50">
      </el-table-column>
      <el-table-column
        prop="name"
        width="200"
        show-overflow-tooltip
        label="名称">
      </el-table-column>
      <el-table-column
        prop="superCode"
        width="120"
        show-overflow-tooltip
        label="商品编码">
      </el-table-column>
      <el-table-column
        prop="brandName"
        show-overflow-tooltip
        width="120"
        label="品牌">
      </el-table-column>
      <el-table-column
        prop="model"
        show-overflow-tooltip
        width="100"
        label="型号">
      </el-table-column>
      <el-table-column
        prop="unit"
        label="标准单位">
      </el-table-column>
      <el-table-column
        prop="pricePurchase"
        width="90"
        label="采购价(元)">
      </el-table-column>
      <el-table-column
        prop="priceSalse"
        width="90"
        label="销售价(元)">
      </el-table-column>
      <el-table-column
        prop="priceContract"
        width="90"
        label="承包价(元)">
      </el-table-column>
      <el-table-column
        prop="ifOn"
        align="center"
        label="是否启用">
        <template slot-scope="scope">
          <el-tag>{{ scope.row.ifOn===true?'是':'否' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="roomAreaName"
        label="房间区域">
      </el-table-column>
      <el-table-column
        prop="origin"
        label="产地">
      </el-table-column>
      <el-table-column
        prop="remark"
        show-overflow-tooltip
        width="150"
        label="备注">
      </el-table-column>
      <el-table-column
        fixed="right"
        align="center"
        width="150"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="updateHandle(scope.row.id)">修改</el-button>
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
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import AddOrUpdate from './material-add-or-update'

  export default {
    computed: {
      siteContentViewHeight () {
        return this.$store.state.common.documentClientHeight - 250
      }
    },
    data () {
      return {
        checkStatus: -1,
        importStatus: -1,
        showExport: false,
        active: 0,
        dataForm: {
          name: '',
          typeId: '',
          typeName: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false
      }
    },
    components: {
      AddOrUpdate
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 选择文件
      chooseFile () {
      },
      // 下载模板
      downTemplate () {

      },
      importHandle () {
        this.showExport = true
      },
      next () {
        if (this.active === 0) {
          this.active++
        } else if (this.active === 1) {
          this.active++
        } else if (this.active === 2) {
          // todo 校验，1成功，2失败
          this.checkStatus = 0
          var res = 1
          if (res === 1) {
            this.checkStatus = 1
            this.active++
          } else {
            this.checkStatus = 2
          }
        } else if (this.active === 3) {
          // todo 导入，1成功，2失败
          this.importStatus = 0
          var rest = 1
          if (rest === 1) {
            this.importStatus = 1
            this.active = 4
          } else {
            this.importStatus = 2
          }
        }
      },
      // 根据部门id查询用户列表
      findListByType (val) {
        this.dataForm.typeId = val.id
        this.dataForm.typeName = val.typeName
        this.getDataList()
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/material/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'name': this.dataForm.name,
            'typeId': this.dataForm.typeId
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
      // 新增
      addHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(null, this.dataForm)
        })
      },
      // 修改
      updateHandle (id) {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(id, this.dataForm)
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
            url: this.$http.adornUrl('/tx/material/delete'),
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
