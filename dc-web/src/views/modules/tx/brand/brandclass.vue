<style scoped>
  .el-card__header {
    padding: 5px 20px;
    border-bottom: 1px solid #ebeef5;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    background-color: #f1eff0;
    line-height: 24px;
  }

  .el-button.is-circle {
    border-radius: 50%;
    padding: 6px;
  }
</style>
<template>
  <div class="mod-config">
    <el-row>
      <el-col :span="5">
        <el-card :body-style="siteContentViewHeight">
          <div slot="header" class="clearfix">
            <span style="font-weight: 700">材料分类</span>
            <el-button type="primary"  icon="el-icon-plus" circle plain @click="addHandle"></el-button>
          </div>
          <el-tree ref="brandTypeTree" node-key="id" :data="this.dataList" highlight-current :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-card>
      </el-col>
      <el-col :span="19">
        <el-row style="background-color: #f1eff0;height: 36.2px;line-height: 36.2px">
          <el-col :span="19">
            <el-tag  size="midle" type="info" style="margin-left: 20px;font-weight: 600" v-if="singleSelect.id">{{singleSelect.typeName}}</el-tag>
            <el-button style="margin-left: 15px"  v-if="isAuth('tx:materialtype:update') && singleSelect.id" @click="updateHandle()"
                       type="primary"
                       icon="el-icon-edit"
                       circle plain></el-button>
            <el-button  v-if="isAuth('tx:materialtype:delete') && singleSelect.id" type="primary" @click="deleteHandle()"
                       icon="el-icon-delete"
                       circle plain></el-button>
          </el-col>
        </el-row>
        <el-row style="margin-left: 10px;margin-top: 10px;">
          <brand ref="brandlist"></brand>
        </el-row>
      </el-col>
    </el-row>

    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import TableTreeColumn from '@/components/table-tree-column/index'
  import AddOrUpdate from '../material/materialtype-add-or-update'
  import {treeDataTranslate} from '@/utils/index'
  import Brand from './brand'

  export default {
    computed: {
      siteContentViewHeight () {
        var height = this.$store.state.common.documentClientHeight - 150
        return {height: height + 'px', 'overflow-y': 'scroll'}
      }
    },
    data () {
      return {
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        singleSelect: {
          name: '',
          id: ''
        },
        addOrUpdateVisible: false,
        defaultProps: {
          children: 'child',
          label: 'typeName'
        }
      }
    },
    components: {
      AddOrUpdate,
      TableTreeColumn,
      Brand
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/tx/materialtype/list'),
          method: 'get'
        }).then(({data}) => {
          this.dataList = treeDataTranslate(data.list, 'id')
          this.dataListLoading = false
        }).then(() => {
          if (this.dataList.length > 0) {
            this.singleSelect = this.dataList[0]
            this.$nextTick(() => {
              this.$refs.brandTypeTree.setCurrentKey(this.dataList[0].id)
              this.$refs.brandlist.findListByType(this.dataList[0])
            })
          }
        })
      },
      // 材料分类单选
      handleNodeClick (val) {
        this.singleSelect = val
        this.$refs.brandlist.findListByType(val)
      },
      // 材料分类新增
      addHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(null)
        })
      },
      // 材料分类修改
      updateHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(this.singleSelect.id)
        })
      },
      // 删除
      deleteHandle (id) {
        this.$confirm('确定要删除吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/tx/materialtype/delete'),
            method: 'post',
            data: this.$http.adornData(this.singleSelect.id, false)
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
