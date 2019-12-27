<style scoped>
  .el-form-item {
    margin-bottom: 1px;
  }
</style>
<template>
  <el-dialog
    width="900px"
    title="主材选择"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-row>
      <el-col :span="5" :height="this.$store.state.common.documentClientHeight-162">
        <el-card :body-style="siteContentViewHeight">
          <div slot="header" class="clearfix">
            <span style="font-weight: 700">材料分类</span>
          </div>
          <el-tree :data="this.dataList" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-card>
      </el-col>
      <el-col :span="19">
        <el-row style="margin-left: 10px;margin-top: 10px;">
          <material ref="materiallist" @hiddenDialog="visible = false"></material>
        </el-row>
      </el-col>
    </el-row>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  import Material from './material'
  import TableTreeColumn from '@/components/table-tree-column/index'
  import {treeDataTranslate} from '@/utils/index'

  export default {
    computed: {
      siteContentViewHeight () {
        var height = this.$store.state.common.documentClientHeight - 180
        return {height: height + 'px', 'overflow-y': 'scroll'}
      }
    },
    components: {
      Material,
      TableTreeColumn
    },
    data () {
      return {
        dataList: [],
        dataListLoading: false,
        singleSelect: {
          name: '',
          id: ''
        },
        addOrUpdateVisible: false,
        defaultProps: {
          children: 'child',
          label: 'typeName'
        },
        visible: false,
        room: {}
      }
    },
    methods: {
      init (room) {
        this.visible = true
        this.getDataList()
        this.room = room
      },
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
              this.$refs.materiallist.findListByType(this.dataList[0], this.room.id)
            })
          }
        })
      },
      // 单选
      handleNodeClick (val) {
        this.singleSelect = val
        this.$refs.materiallist.findListByType(val)
      },
      // 提交
      dataFormSubmit () {
        if (this.$refs.materiallist.dataListSelections.length === 0) {
          this.$message({
            message: '至少选择一个',
            type: 'warning'
          })
          return
        }
        this.$http({
          url: this.$http.adornUrl(`/tx/predictmaterial/choose`),
          method: 'post',
          data: this.$http.adornData({
            'roomId': this.room.id,
            'materialList': this.$refs.materiallist.dataListSelections
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500,
              onClose: () => {
                this.visible = false
                this.$emit('refreshDataList', this.room)
              }
            })
          } else {
            this.$message.error(data.msg)
          }
        })
      }
    }
  }
</script>
