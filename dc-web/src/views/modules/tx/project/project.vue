<template>
  <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-input v-model="dataForm.name" placeholder="项目名称" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button v-if="isAuth('tx:project:save')" type="primary" @click="addHandle()">新增</el-button>
        <el-button v-if="isAuth('tx:project:delete')" type="danger" @click="deleteHandle()"
                   :disabled="dataListSelections.length <= 0">批量删除
        </el-button>
        <el-button v-if="isAuth('tx:project:export')" type="danger" @click="exportHandle()">导出</el-button>
      </el-form-item>
    </el-form>
    <el-table
      empty-text="该项目分类下无数据"
      :data="dataList"
      border
      :height="siteContentViewHeight"
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
        align="center"
        label="施工项名称">
      </el-table-column>
      <el-table-column
        prop="workTypeName"
        header-align="center"
        align="center"
        label="工种">
      </el-table-column>
      <el-table-column
        prop="unit"
        header-align="center"
        align="center"
        label="计量单位">
      </el-table-column>
      <el-table-column
        prop="totalPrice"
        header-align="center"
        align="center"
        label="综合价(元)">
      </el-table-column>
      <el-table-column
        prop="totalCost"
        header-align="center"
        align="center"
        label="综合成本(元)">
      </el-table-column>
      <el-table-column
        prop="humanCost"
        header-align="center"
        align="center"
        label="人工成本(元)">
      </el-table-column>
      <el-table-column
        prop="helpCost"
        header-align="center"
        align="center"
        label="辅材成本(元)">
      </el-table-column>
      <el-table-column
        prop="ifOn"
        header-align="center"
        align="center"
        label="是否启用">
        <template slot-scope="scope">
          <el-tag>{{ scope.row.ifOn===true?'是':'否' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        width="80"
        prop="remark"
        show-overflow-tooltip
        header-align="center"
        align="center"
        label="说明">
      </el-table-column>
      <el-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="100"
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
  import AddOrUpdate from './project-add-or-update'

  export default {
    computed: {
      siteContentViewHeight () {
        return this.$store.state.common.documentClientHeight - 250
      }
    },
    data () {
      return {
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
      // 根据部门id查询用户列表
      findListByType (val) {
        this.dataForm.typeId = val.id
        this.dataForm.typeName = val.name
        this.getDataList()
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/project/list'),
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
        if (!this.dataForm.typeId) {
          this.$message.error('请先选择或添加一个分类')
          return
        }
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
      // 导出
      exportHandle () {
        // todo
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
            url: this.$http.adornUrl('/tx/project/delete'),
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
