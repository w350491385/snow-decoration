<template>
  <div class="mod-config">
    <el-form  :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-input v-model="dataForm.name" placeholder="项目名称" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button @click="routerProject" type="text">配置可选项</el-button>
      </el-form-item>
    </el-form>
    <el-table empty-text="无数据,可点击上方 <<配置可选项>> 进行施工项定额维护"
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
        width="120"
        header-align="center"
        align="center"
        label="项目名称">
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
        prop="humanCost"
        header-align="center"
        align="center"
        label="人工成本">
      </el-table-column>
      <el-table-column
        prop="helpCost"
        header-align="center"
        align="center"
        label="辅材成本">
      </el-table-column>
      <el-table-column
        prop="totalCost"
        header-align="center"
        align="center"
        label="综合成本">
      </el-table-column>
      <el-table-column
        prop="totalPrice"
        header-align="center"
        align="center"
        label="综合单价">
        <template slot-scope="scope">
          <span style="color: red">{{scope.row.totalPrice}}</span>
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
  </div>
</template>

<script>
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
        addOrUpdateVisible: false,
        roomId: ''
      }
    },
    activated () {
      this.getDataList()
    },
    methods: {
      routerProject () {
        this.$emit('hiddenDialog')
        this.$router.push({name: 'tx-project/projecttype'})
      },
      // 根据部门id查询用户列表
      findListByType (val, roomId) {
        this.roomId = roomId
        this.dataForm.typeId = val.id
        this.dataForm.typeName = val.name
        this.getDataList()
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/project/fiterByPredictRoom'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'name': this.dataForm.name,
            'typeId': this.dataForm.typeId,
            'roomId': this.roomId
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
