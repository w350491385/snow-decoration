<template>
  <div class="mod-config">
    <el-row>
      <el-col :span="5">
        <el-card :body-style="siteContentViewHeight">
          <div slot="header" class="clearfix">
            <span style="font-weight: 700">部门</span>
            <el-button type="primary"  icon="el-icon-plus" circle plain @click="addHandle"></el-button>
          </div>
          <el-tree default-expand-all v-loading="loadingDept" ref="deptTree" node-key="id" :data="dataList" highlight-current :props="defaultProps" @node-click="handleCurrentChange"></el-tree>
        </el-card >
        <el-button style="width: 100%" align="center" type="text" @click="retiredLook()">查看已离职员工</el-button>
      </el-col>
      <el-col :span="19">
        <el-row style="background-color: #f1eff0;height: 36.2px;line-height: 36.2px">
          <el-col :span="19">
            <el-tag size="midle" type="info" style="margin-left: 20px;font-weight: 600" v-if="singleSelect.id != null">{{singleSelect.name}}</el-tag>
            <el-button style="margin-left: 15px" v-if="isAuth('sys:dept:update') && singleSelect.id != null" @click="updateHandle()" type="primary"
                       icon="el-icon-edit"
                       circle plain></el-button>
            <el-button v-if="isAuth('sys:dept:delete') && singleSelect.id" type="primary" @click="deleteHandle()" icon="el-icon-delete"
                       circle plain></el-button>
          </el-col>
        </el-row>
        <el-row style="margin-left: 10px;margin-top: 10px;">
          <user ref="userlist" @loadingData="loadingDept = true" @loadingCommplet="loadingDept = false"></user>
        </el-row>
      </el-col>
    </el-row>

    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import AddOrUpdate from './dept-add-or-update'
  import TableTreeColumn from '@/components/table-tree-column'
  import {treeDataTranslate} from '@/utils'
  import User from './dept-user'

  export default {
    computed: {
      siteContentViewHeight () {
        var height = this.$store.state.common.documentClientHeight - 180
        return {height: height + 'px', 'overflow-y': 'scroll'}
      }
    },
    data () {
      return {
        dataForm: {
          name: ''
        },
        dataList: [],
        dataListLoading: false,
        singleSelect: {
          name: '',
          id: null
        },
        addOrUpdateVisible: false,
        defaultProps: {
          children: 'child',
          label: 'name'
        },
        loadingDept: false
      }
    },
    components: {
      TableTreeColumn,
      AddOrUpdate,
      User
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 查看离职员工
      retiredLook () {
        this.$router.push({ name: 'tx-sysretired/sysretired' })
      },
      // 组件的method方法
      renderHeader (h, para) {
        return (
          h('span', [
            h('span', para.column.label),
            h('el-button', {
              props: {
                type: 'primary ',
                size: 'mini',
                icon: 'el-icon-plus',
                circle: true,
                plain: true
              },
              on: {
                click: this.addHandle
              },
              style: 'padding:5px;margin-left:5px'
            })
          ])
        )
      },
      leftHeight () {
        return `${document.documentElement.clientHeight}` - 165
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/sys/dept/list'),
          method: 'get',
          params: this.$http.adornParams({
            'name': this.dataForm.name
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            if (data.list !== null && data.list.length > 0) {
              this.dataList = treeDataTranslate(data.list, 'id')
              this.singleSelect = this.dataList[0]
            }
          } else {
            this.dataList = []
          }
          this.dataListLoading = false
        }).then(() => {
          if (this.dataList.length > 0) {
            this.$nextTick(() => {
              this.$refs.deptTree.setCurrentKey(this.dataList[0].id)
              this.$refs.userlist.findListByType(this.dataList[0])
            })
          }
        })
      },
      // 单选
      handleCurrentChange (val) {
        this.singleSelect = val
        this.$nextTick(() => {
          this.$refs.userlist.findListByType(val)
        })
      },
      // 新增
      addHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init()
        })
      },
      // 修改
      updateHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(this.singleSelect.id)
        })
      },
      // 删除
      deleteHandle () {
        this.$confirm('确定要删除部门：' + this.singleSelect.name + '吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/sys/dept/delete'),
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
