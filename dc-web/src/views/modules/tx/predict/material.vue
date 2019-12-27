<template>
  <div class="mod-config">
    <el-form  :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-input v-model="dataForm.name" placeholder="材料名" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <el-button @click="routerMaterial" type="text">配置可选项</el-button>
      </el-form-item>
    </el-form>
    <el-table
      empty-text="无数据,可点击上方 <<配置可选项>> 进行材料维护"
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
        width="120"
        prop="name"
        header-align="center"
        align="center"
        label="名称">
      </el-table-column>
      <el-table-column
        prop="brandName"
        header-align="center"
        align="center"
        label="品牌">
      </el-table-column>
      <el-table-column
        prop="model"
        header-align="center"
        align="center"
        label="型号">
      </el-table-column>
      <el-table-column
        prop="unit"
        header-align="center"
        align="center"
        label="标准单位">
      </el-table-column>
      <el-table-column
        prop="pricePurchase"
        header-align="center"
        align="center"
        label="采购价">
      </el-table-column>
      <el-table-column
        prop="priceContract"
        header-align="center"
        align="center"
        label="承包价">
      </el-table-column>
      <el-table-column
        prop="priceSalse"
        header-align="center"
        align="center"
        label="销售价">
        <template slot-scope="scope">
          <span style="color: red">{{scope.row.priceSalse}}</span>
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
        addOrUpdateVisible: false,
        roomId: ''
      }
    },
    activated () {
      this.getDataList()
    },
    methods: {
      routerMaterial () {
        this.$emit('hiddenDialog')
        this.$router.push({name: 'tx-material/materialtype'})
      },
      findListByType (val, roomId) {
        this.roomId = roomId
        this.dataForm.typeId = val.id
        this.dataForm.typeName = val.typeName
        this.getDataList()
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/material/fiterByPredictRoom'),
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
