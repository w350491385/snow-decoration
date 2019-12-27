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
  <el-row v-if="listVisible">
    <el-row style="margin-bottom: 3px">
      <el-tag type="success" size="midle" style="margin-left: 10px;margin-right: 30px;font-weight: 600;font-size: 14px">{{template.name}}</el-tag>
      <el-button @click="back" style="margin-left: 20px">返回</el-button>
    </el-row>
    <el-row>
      <el-col :span="5" :height="this.$store.state.common.documentClientHeight-162">
        <el-card :body-style="siteContentViewHeight">
          <div slot="header" class="clearfix">
            <span style="font-weight: 700">空间列表</span>
            <el-button type="primary" icon="el-icon-plus" circle plain @click="addHandle()"></el-button>
          </div>
          <el-tree ref="roomTree" node-key="id" highlight-current :data="this.dataList" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-card>
      </el-col>
      <el-col :span="19">
        <el-row style="background-color: #f1eff0;height: 36.2px;line-height: 36.2px">
          <el-col :span="20">
            <el-tag type="success" v-if="singleSelect.id" style="margin-left: 20px">{{singleSelect.name}}</el-tag>
            <el-button style="margin-left: 15px" v-if="isAuth('tx:predicttemplate:update') && singleSelect.id!=null" @click="updateHandle()"
                       type="primary"
                       icon="el-icon-edit"
                       circle plain></el-button>
            <el-button v-if="isAuth('tx:predicttemplate:delete') && singleSelect.id!=null" type="primary" @click="deleteHandle()"
                       icon="el-icon-delete"
                       circle plain></el-button>
          </el-col>
        </el-row>
        <el-row style="margin-left: 10px;margin-top: 10px;">
          <el-tabs v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="施工费用" name="first">
              <predictproject ref="predictproject"></predictproject>
            </el-tab-pane>
            <el-tab-pane label="主材费用" name="second">
              <predictmaterial ref="predictmaterial"></predictmaterial>
            </el-tab-pane>
          </el-tabs>
        </el-row>
      </el-col>
    </el-row>

    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </el-row>
</template>

<script>
  import AddOrUpdate from './predictroom-add-or-update'
  import Predictmaterial from './predictmaterial'
  import Predictproject from './predictproject'

  export default {
    computed: {
      siteContentViewHeight () {
        var height = this.$store.state.common.documentClientHeight - 190
        return {height: height + 'px', 'overflow-y': 'scroll'}
      }
    },
    data () {
      return {
        dataForm: {
          name: ''
        },
        template: {},
        defaultProps: {
          children: 'children',
          label: 'name'
        },
        activeName: 'first',
        dataList: [],
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false,
        listVisible: false,
        singleSelect: {
          name: '',
          id: ''
        }
      }
    },
    components: {
      AddOrUpdate,
      Predictmaterial,
      Predictproject
    },
    methods: {
      // 单选
      handleNodeClick (val) {
        this.singleSelect = val
        this.$refs.predictproject.getDataList(this.singleSelect)
        this.$refs.predictmaterial.getDataList(this.singleSelect)
      },
      handleClick (tab, event) {
      },
      back () {
        this.$nextTick(() => {
          this.listVisible = false
        })
        this.$emit('back')
      },
      init (row) {
        this.template = row
        this.listVisible = true
        this.getDataList()
      },
      // 根据模板查空间列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl(`/tx/predictroom/all/${this.template.id}`),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.list
            if (data.list != null && data.list.length > 0) {
              this.$nextTick(() => {
                this.$refs.roomTree.setCurrentKey(data.list[0].id)
                this.handleNodeClick(data.list[0])
              })
            } else {
              // 如果空间没有了,子页面不显示添加按钮
              this.singleSelect = {}
              this.$refs.predictproject.clearRoom()
              this.$refs.predictmaterial.clearRoom()
            }
          } else {
            this.dataList = []
          }
          this.dataListLoading = false
        })
      },
      // 新增
      addHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(null, this.template)
        })
      },
      // 修改
      updateHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(this.singleSelect.id, this.template)
        })
      },
      // 删除
      deleteHandle () {
        this.$confirm('确定要删除吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/tx/predictroom/delete'),
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
