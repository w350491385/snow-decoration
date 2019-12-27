<template>
  <div class="mod-config">
    <el-row v-if="room==null">请选择空间</el-row>
    <el-button v-if="room!=null" type="text" size="small" @click="chooseHandle()">+选择添加</el-button>
    <el-table
      show-summary
      :height="siteContentViewHeight"
      :data="dataList"
      border
      v-loading="dataListLoading"
      style="width: 100%;">
      <el-table-column
        prop="materialName"
        header-align="center"
        align="center"
        label="名称">
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
        label="综合单价">
      </el-table-column>
      <el-table-column
        prop="amount"
        header-align="center"
        align="center"
        label="数量">
      </el-table-column>
      <el-table-column
        prop="salePrice"
        header-align="center"
        align="center"
        label="销售总价">
      </el-table-column>
      <el-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="150"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">修改数量</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
    <choose v-if="chooseVisible" ref="chooseList" @refreshDataList="getDataList"></choose>
  </div>
</template>

<script>
  import AddOrUpdate from './predictmaterial-add-or-update'
  import Choose from './predictmaterial-choose'

  export default {
    computed: {
      siteContentViewHeight () {
        return this.$store.state.common.documentClientHeight - 260
      }
    },
    data () {
      return {
        dataList: [],
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false,
        chooseVisible: false,
        room: null
      }
    },
    components: {
      AddOrUpdate,
      Choose
    },
    methods: {
      clearRoom () {
        this.room = null
      },
      // 获取数据列表
      getDataList (room) {
        this.room = room
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/predictmaterial/list'),
          method: 'get',
          params: this.$http.adornParams({
            'roomId': room.id
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.list
          } else {
            this.dataList = []
          }
          this.dataListLoading = false
        })
      },
      // 修改
      addOrUpdateHandle (id) {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(id, this.room)
        })
      },
      // 基础库选择新增
      chooseHandle () {
        this.chooseVisible = true
        this.$nextTick(() => {
          this.$refs.chooseList.init(this.room)
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
            url: this.$http.adornUrl('/tx/predictmaterial/delete'),
            method: 'post',
            data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 500,
                onClose: () => {
                  this.getDataList(this.room)
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
