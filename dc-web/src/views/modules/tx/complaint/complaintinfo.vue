<template>
  <div class="mod-config">
    <el-row style="height: 35px;line-height: 35px">
      <el-button  @click="back">返回</el-button>
    </el-row>
    <el-row>
      <el-table
        :data="dataList"
        border
        v-loading="dataListLoading"
        style="width: 100%;">
        <el-table-column
          prop="manId"
          header-align="center"
          align="center"
          label="发言人">
        </el-table-column>
        <el-table-column
          prop="action"
          header-align="center"
          align="center"
          label="动作行为">
        </el-table-column>
        <el-table-column
          prop="content"
          header-align="center"
          align="center"
          label="内容">
        </el-table-column>
        <el-table-column
          prop="createTime"
          header-align="center"
          align="center"
          label="时间">
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
  </div>
</template>

<script>
  export default {
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
        addOrUpdateVisible: false
      }
    },
    activated () {
      this.getDataList()
    },
    methods: {
      back () {
        this.$nextTick(() => {
          this.visible = false
        })
        this.$emit('back')
      },
      init (complaintId) {
        this.getDataList(complaintId)
      },
      // 获取数据列表
      getDataList (complaintId) {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/complaint/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'complaintId': complaintId
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
      }
    }
  }
</script>
