<template>
  <div class="mod-config">
    <el-row v-if="listVisible">
      <el-form  :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item label-width="客户姓名">
          <el-input v-model="dataForm.clientName" placeholder="客户姓名" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">查询</el-button>
        </el-form-item>
      </el-form>
      <el-table
        :data="dataList"
        border
        v-loading="dataListLoading"
        style="width: 100%;">
        <el-table-column
          prop="clientName"
          header-align="center"
          align="center"
          label="投诉客户">
        </el-table-column>
        <el-table-column
          prop="complaintTypeName"
          header-align="center"
          align="center"
          label="投诉类型">
        </el-table-column>
        <el-table-column
          prop="complaintDesc"
          header-align="center"
          align="center"
          label="投诉描述">
        </el-table-column>
        <el-table-column
          prop="status"
          header-align="center"
          align="center"
          label="受理状态">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.status==='0'">未受理</el-tag>
            <el-tag v-if="scope.row.status==='1'" type="warning">已受理</el-tag>
            <el-tag v-if="scope.row.status==='2'" type="success">已完成</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="opinion"
          header-align="center"
          align="center"
          label="受理意见">
        </el-table-column>
        <el-table-column
          prop="complaintPic"
          header-align="center"
          align="center"
          label="投诉照片json">
        </el-table-column>
        <el-table-column
          fixed="right"
          header-align="center"
          align="center"
          width="150"
          label="操作">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="infoHandle(scope.row.id)">消息记录</el-button>
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
    <complaininfo v-if="comlpaininfoVisible" ref="comlpaininfo" @back="backList"></complaininfo>
  </div>
</template>

<script>
  import Complaininfo from './complaintinfo.vue'

  export default {
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
        comlpaininfoVisible: false,
        listVisible: true
      }
    },
    components: {
      Complaininfo
    },
    activated () {
      this.getDataList()
    },
    methods: {
      backList () {
        this.listVisible = true
        this.comlpaininfoVisible = false
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/complaint/list'),
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
      // 弹出消息记录
      infoHandle (id) {
        this.listVisible = false
        this.comlpaininfoVisible = true
        this.$nextTick(() => {
          this.$refs.comlpaininfo.init(id)
        })
      }
    }
  }
</script>
