<template>
  <div class="mod-config">
    <el-row v-if="listVisible">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item label="模板名称：">
          <el-input v-model="dataForm.name"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">刷新</el-button>
          <el-button v-if="isAuth('tx:accepttemplet:save')" type="primary" @click="addOrUpdateHandle()">新增</el-button>
          <el-button v-if="isAuth('tx:accepttemplet:delete')" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
          <el-button v-if="isAuth('tx:accepttemplet:save')" type="primary" @click="addTypeHandle()">新增类别</el-button>
        </el-form-item>
      </el-form>
      <el-table
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
          prop="acceptTypeName"
          header-align="center"
          align="center"
          label="验收类别">
        </el-table-column>
        <el-table-column
          prop="projectName"
          header-align="center"
          align="center"
          label="验收项目">
        </el-table-column>
        <el-table-column
          prop="standard"
          header-align="center"
          align="center"
          label="标准">
        </el-table-column>
        <el-table-column
          prop="ifMust"
          header-align="center"
          align="center"
          label="是否必检">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.ifMust===0" type="warning">否</el-tag>
            <el-tag v-if="scope.row.ifMust===1" type="success">是</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="pictureJson"
          header-align="center"
          align="center"
          label="标准图片_json">
        </el-table-column>
        <el-table-column
          fixed="right"
          header-align="center"
          align="center"
          width="150"
          label="操作">
          <template slot-scope="scope">
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
    <accept-type v-if="typeVisible" ref="acceptType" @back="back"></accept-type>
  </div>
</template>

<script>
  import AddOrUpdate from './accepttemplet-add-or-update'
  import AcceptType from './accepttype'

  export default {
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
        listVisible: true,
        typeVisible: false
      }
    },
    components: {
      AddOrUpdate,
      AcceptType
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 返回
      back () {
        this.typeVisible = false
        this.listVisible = true
      },
      // 新增类别
      addTypeHandle () {
        this.listVisible = false
        this.typeVisible = true
        this.$nextTick(() => {
          this.$refs.acceptType.getDataList()
        })
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/accepttemplet/list'),
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
            url: this.$http.adornUrl('/tx/accepttemplet/delete'),
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
