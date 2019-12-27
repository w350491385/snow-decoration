<template>
  <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item label="客户：" label-width="100">
        <el-input v-model="dataForm.clientName" placeholder="客户姓名" clearable></el-input>
      </el-form-item>
      <el-form-item label="施工状态：" label-width="100">
        <el-radio-group v-model="dataForm.status">
          <el-radio :label="1">未开工</el-radio>
          <el-radio :label="2">已开工</el-radio>
          <el-radio :label="3">已完成</el-radio>
        </el-radio-group>
      </el-form-item>
      <br/>
      <el-form-item label="时间范围：" label-width="100">
        <el-date-picker
          v-model="dataForm.timeRange"
          type="datetimerange"
          :picker-options="pickerOptions2"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          align="right">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="动作：" label-width="100">
        <el-select v-model="dataForm.action" placeholder="请选择">
          <el-option
            v-for="item in actionoptions"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
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
        prop="linkedClient"
        header-align="center"
        align="center"
        label="客户">
      </el-table-column>
      <el-table-column
        prop="operateMan"
        header-align="center"
        align="center"
        label="操作人">
      </el-table-column>
      <el-table-column
        prop="createTime"
        header-align="center"
        align="center"
        label="发生时间">
      </el-table-column>
      <el-table-column
        prop="status"
        header-align="center"
        align="center"
        label="施工状态">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status===1" size="small" type="danger">未开工</el-tag>
          <el-tag v-if="scope.row.status===2" size="small" type="danger">已开工</el-tag>
          <el-tag v-if="scope.row.status===3" size="small" type="danger">已完成</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="action"
        header-align="center"
        align="center"
        label="动作">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.action===1" size="small" type="danger">设计</el-tag>
          <el-tag v-if="scope.row.action===2" size="small" type="danger">测量</el-tag>
          <el-tag v-if="scope.row.action===3" size="small" type="danger">施工</el-tag>
          <el-tag v-if="scope.row.action===4" size="small" type="danger">维修</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="description"
        header-align="center"
        align="center"
        label="描述">
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
  </div>
</template>

<script>
  export default {
    data () {
      return {
        dataForm: {
          timeRange: [],
          clientName: '',
          status: 1,
          action: ''
        },
        actionoptions: [{
          value: '1',
          label: '设计'
        }, {
          value: '2',
          label: '测量'
        }, {
          value: '3',
          label: '施工'
        }, {
          value: '4',
          label: '维修'
        }],
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false,
        pickerOptions2: {
          shortcuts: [{
            text: '最近一周',
            onClick (picker) {
              const end = new Date()
              const start = new Date()
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
              picker.$emit('pick', [start, end])
            }
          }, {
            text: '最近一个月',
            onClick (picker) {
              const end = new Date()
              const start = new Date()
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
              picker.$emit('pick', [start, end])
            }
          }, {
            text: '最近三个月',
            onClick (picker) {
              const end = new Date()
              const start = new Date()
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
              picker.$emit('pick', [start, end])
            }
          }]
        }
      }
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        var startTime
        var endTime
        if (!this.dataForm.timeRange) {
          startTime = this.dataForm.timeRange[0]
          if (this.dataForm.timeRange.length > 1) {
            endTime = this.dataForm.timeRange[1]
          }
        }
        this.$http({
          url: this.$http.adornUrl('/tx/constructionlog/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'clientName': this.dataForm.clientName,
            'startTime': startTime,
            'endTime': endTime,
            'status': this.dataForm.status,
            'action': this.dataForm.action
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
