<template>
  <div class="mod-user">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <span style="font-size: 13px;font-weight: 600">员工列表</span>
      </el-form-item>
      <el-form-item>
        <el-button v-if="isAuth('sys:user:save')" type="primary" @click="addHandle()">新增</el-button>
        <el-button v-if="isAuth('sys:user:update')" type="primary" @click="updateHandle()" :disabled="currentRow==null">修改</el-button>
        <el-button v-if="isAuth('sys:user:retired')" type="primary" @click="quitHandle()" :disabled="currentRow==null">离职</el-button>
        <el-button v-if="isAuth('sys:user:exchange')" type="primary" @click="exchangeClient()" :disabled="currentRow==null">转客户</el-button>
        <el-button v-if="isAuth('sys:user:update')" type="primary" @click="chooseRoles()" :disabled="currentRow==null">系统角色分配</el-button>
        <el-button v-if="isAuth('sys:user:update')" type="primary" @click="choosePositions()" :disabled="currentRow==null">服务岗位分配</el-button>
        <el-button v-if="isAuth('sys:user:update')" type="primary" @click="choosePersonView()" :disabled="currentRow==null">个人视野</el-button>
        <el-button v-if="isAuth('sys:user:update')" type="primary" @click="chooseDeptView()" :disabled="currentRow==null">部门视野</el-button>
        <el-button v-if="isAuth('sys:user:delete')" type="danger" @click="deleteHandle()" :disabled="currentRow==null">删除员工</el-button>
      </el-form-item>
    </el-form>
    <el-table empty-text="该部门下无员工，请点击左侧部门进行查询"
              :height="siteContentViewHeight"
              :data="dataList"
              border
              v-loading="dataListLoading"
              highlight-current-row
              @current-change="handleCurrentChange"
              style="width: 100%;">
      <el-table-column
        prop="username"
        header-align="center"
        align="center"
        label="姓名">
      </el-table-column>
      <el-table-column
        prop="mobile"
        header-align="center"
        align="center"
        label="手机号">
      </el-table-column>
      <el-table-column
        prop="job"
        header-align="center"
        align="center"
        label="职位">
      </el-table-column>
      <el-table-column
        prop="entry"
        header-align="center"
        align="center"
        label="入职日期">
      </el-table-column>
      <el-table-column
        prop="position"
        header-align="center"
        align="center"
        label="服务岗位">
        <template slot-scope="scope">
          <el-tag v-for="item in scope.row.position" :key="item" type="success" disable-transitions>{{item}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="role"
        header-align="center"
        align="center"
        label="系统角色">
        <template slot-scope="scope">
          <el-tag v-for="item in scope.row.role" :key="item" type="success" disable-transitions>{{item}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        width="55"
        prop="ifOn"
        header-align="center"
        align="center"
        label="激活">
        <template slot-scope="scope">
          <el-tag v-if="!scope.row.ifOn" size="small" type="danger">否</el-tag>
          <el-tag v-else size="small">是</el-tag>
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

    <el-dialog
      title="系统角色分配"
      :close-on-click-modal="true"
      :visible.sync="roleVisible">
      <el-form :model="roleForm" ref="roleForm" @keyup.enter.native="roleFormSubmit()">
        <el-form-item label="" prop="roleIdList" label-width="20px">
          <el-checkbox-group v-model="roleForm.roleIdList">
            <el-checkbox border v-for="role in roleList" :key="role.roleId" :label="role.roleId">{{ role.roleName }}</el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
      <el-button @click="roleVisible = false">取消</el-button>
      <el-button type="primary" @click="roleFormSubmit()">保存</el-button>
    </span>
    </el-dialog>
    <el-dialog
      title="服务岗位分配"
      :close-on-click-modal="true"
      :visible.sync="positionVisible">
      <el-form :model="positionForm" ref="positionForm" @keyup.enter.native="positionFormSubmit()">
        <el-form-item label="" prop="positionList" label-width="20px">
          <el-checkbox-group v-model="positionForm.positionIdList">
            <el-checkbox border v-for="position in positionList" :key="position.id" :label="position.id">{{ position.name }}</el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
      <el-button @click="positionVisible = false">取消</el-button>
      <el-button type="primary" @click="positionFormSubmit()">保存</el-button>
    </span>
    </el-dialog>
    <el-dialog
      title="个人视野"
      :close-on-click-modal="true"
      :visible.sync="personVisible">
      <el-form :model="personViewForm" ref="personViewForm" @keyup.enter.native="personViewFormSubmit()" style="text-align: center">
        <el-form-item label="" prop="positionList" label-width="20px">
          <el-transfer
            style="text-align: left; display: inline-block"
            v-model="personViewForm.personViewIdList"
            :data="personViewList"
            :titles="['可选列表', '视野']"
            :button-texts="['移出视野', '加入视野']"
          ></el-transfer>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
      <el-button @click="personVisible = false">取消</el-button>
      <el-button type="primary" @click="personViewFormSubmit()">保存</el-button>
    </span>
    </el-dialog>
    <el-dialog
      title="部门视野"
      :close-on-click-modal="true"
      :visible.sync="deptVisible">
      <el-tree
        ref="deptViewRef"
        :data="deptViewList"
        show-checkbox
        node-key="id"
        default-expand-all
        :default-checked-keys="deptViewForm.deptViewIdList"
        :props="deptViewProps">
      </el-tree>
      <span slot="footer" class="dialog-footer">
      <el-button @click="deptVisible = false">取消</el-button>
      <el-button type="primary" @click="deptViewFormSubmit()">保存</el-button>
    </span>
    </el-dialog>
    <el-dialog
      title="转客户"
      :close-on-click-modal="true"
      :visible.sync="exchangeVisible">
      <el-row :gutter="20" align="center">
        <el-col :span="12">
          <el-table
            border
            empty-text="该员工没有客户"
            height="300"
            title="选择客户"
            ref="exchangeClientTable"
            :data="exchangeClientData"
            tooltip-effect="dark"
            style="width: 100%"
            @selection-change="exchangeClientTableChange">
            <el-table-column
              type="selection"
              header-align="center"
              align="center"
              width="50">
            </el-table-column>
            <el-table-column
              prop="clientName"
              header-align="center"
              align="center"
              label="客户姓名">
            </el-table-column>
            <el-table-column
              prop="address"
              header-align="center"
              align="center"
              label="客户地址">
            </el-table-column>
          </el-table>
        </el-col>
        <el-col :span="12">
          <el-table
            empty-text="无可选员工"
            border
            height="300"
            title="选择员工"
            ref="exchangeUserTable"
            :data="exchangeUserData"
            tooltip-effect="dark"
            style="width: 100%"
            @selection-change="exchangeUserTableChange">
            <el-table-column
              type="selection"
              header-align="center"
              align="center"
              width="50">
            </el-table-column>
            <el-table-column
              prop="username"
              header-align="center"
              align="center"
              label="目标员工">
            </el-table-column>
            <el-table-column
              prop="deptName"
              header-align="center"
              align="center"
              label="所属部门">
            </el-table-column>
          </el-table>
        </el-col>
      </el-row>
      <span slot="footer" class="dialog-footer">
      <el-button @click="exchangeVisible = false">取消</el-button>
      <el-button type="primary" @click="exchangeViewFormSubmit()">保存</el-button>
    </span>
    </el-dialog>

    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import AddOrUpdate from './dept-user-add-or-update'
  import * as Public from '../../../js/api/public'
  import * as Dept from '../../../js/api/sys/dept'

  export default {
    computed: {
      siteContentViewHeight () {
        return this.$store.state.common.documentClientHeight - 250
      }
    },
    data () {
      return {
        roleVisible: false,
        positionVisible: false,
        personVisible: false,
        deptVisible: false,
        exchangeVisible: false,
        dataForm: {
          userName: '',
          deptId: '',
          deptName: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        currentRow: null,
        addOrUpdateVisible: false,
        roleForm: {
          roleIdList: []
        },
        roleList: [],
        positionForm: {
          positionIdList: []
        },
        positionList: [],
        personViewForm: {
          personViewIdList: []
        },
        personViewList: [],
        deptViewForm: {
          deptViewIdList: []
        },
        deptViewList: [],
        deptViewProps: {
          children: 'children',
          label: 'name'
        },
        exchangeClientData: [],
        exchangeClientDataSelect: [],
        exchangeUserData: [],
        exchangeUserDataSelect: []
      }
    },
    components: {
      AddOrUpdate
    },
    methods: {
      leftHeight () {
        return `${document.documentElement.clientHeight}` - 250
      },
      // 根据部门id查询用户列表
      findListByType (val) {
        this.dataForm.deptId = val.id
        this.dataForm.deptName = val.name
        this.getDataList()
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$emit('loadingData')
        this.$http({
          url: this.$http.adornUrl('/sys/user/list'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'deptId': this.dataForm.deptId
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
          this.$emit('loadingCommplet')
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
      // 单选
      handleCurrentChange (val) {
        this.currentRow = val
      },
      // 新增
      addHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(null, this.dataForm)
        })
      },
      // 修改
      updateHandle () {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(this.currentRow.userId, this.dataForm)
        })
      },
      // 选择角色
      chooseRoles () {
        this.roleVisible = true
        Public.findAllRole.r().then((res) => {
          this.roleList = res.data && res.data.code === 0 ? res.data.list : []
        }).then(() => {
          Dept.findRoleIdList.r(this.currentRow.userId).then((res) => {
            this.roleForm.roleIdList = res.data && res.data.code === 0 ? res.data.list : []
          })
        })
      },
      // 选择服务岗位
      choosePositions () {
        this.positionVisible = true
        Public.findAllSysposition.r().then((res) => {
          this.positionList = res.data && res.data.code === 0 ? res.data.list : []
        }).then(() => {
          Dept.findPositionIdList.r(this.currentRow.userId).then((res) => {
            this.positionForm.positionIdList = res.data && res.data.code === 0 ? res.data.list : []
          })
        })
      },
      // 选择个人视野
      choosePersonView () {
        this.personVisible = true
        this.personViewList = []
        Public.findAllUser.r().then((res) => {
          const list = res.data && res.data.code === 0 ? res.data.list : []
          if (list.length > 0) {
            for (const person of list) {
              this.personViewList.push({
                key: person.userId,
                label: person.username
              })
            }
          }
        }).then(() => {
          Dept.findPersonViewIdList.r(this.currentRow.userId).then((res) => {
            this.personViewForm.personViewIdList = res.data && res.data.code === 0 ? res.data.list : []
          })
        })
      },
      // 选择部门视野
      chooseDeptView () {
        this.deptVisible = true
        this.deptViewList = []
        Public.findAllDeptMulti.r().then((res) => {
          this.deptViewList = res.data && res.data.code === 0 ? res.data.list : []
        }).then(() => {
          Dept.findDeptViewIdList.r(this.currentRow.userId).then((res) => {
            this.deptViewForm.deptViewIdList = res.data && res.data.code === 0 ? res.data.list : []
            this.$refs.deptViewRef.setCheckedKeys(this.deptViewForm.deptViewIdList)
          })
        })
      },
      // 转客户
      exchangeClient () {
        this.exchangeVisible = true
        this.$nextTick(() => {
          this.$http({
            url: this.$http.adornUrl(`/tx/formalclient/select/${this.currentRow.userId}`),
            method: 'get',
            params: this.$http.adornParams()
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.exchangeClientData = data.list
            }
          }).then(() => {
            this.$http({
              url: this.$http.adornUrl(`/sys/user/select`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.exchangeUserData = data.list
              }
            })
          })
        })
      },
      // 转客户，选择客户
      exchangeClientTableChange (val) {
        this.exchangeClientDataSelect = val
      },
      // 转客户，选择员工
      exchangeUserTableChange (val) {
        this.exchangeUserDataSelect = val
      },
      // 删除
      deleteHandle () {
        var userId = this.currentRow.userId
        var userName = this.currentRow.username
        this.$confirm(`确定删除: ${userName}?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/sys/user/delete'),
            method: 'post',
            data: this.$http.adornData(userId, false)
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
        }).catch(() => {
        })
      },
      // 离职
      quitHandle (id) {
        var userId = this.currentRow.userId
        var userName = this.currentRow.username
        this.$confirm(`确定离职：${userName}?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          Dept.retired.r(userId).then((res) => {
            if (res.data && res.data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 500,
                onClose: () => {
                  this.getDataList()
                }
              })
            } else {
              this.$message.error(res.data.msg)
            }
          })
        })
      },
      // 提交用户角色
      roleFormSubmit () {
        const params = {
          userId: this.currentRow.userId,
          roleIdList: this.roleForm.roleIdList
        }
        Dept.updateUserRole.r(params).then((res) => {
          if (res.data && res.data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500
            })
            this.getDataList()
            this.roleVisible = false
          } else {
            this.$message.error(res.data.msg)
          }
        })
      },
      // 服务岗位提交
      positionFormSubmit () {
        const params = {
          userId: this.currentRow.userId,
          positionIdList: this.positionForm.positionIdList
        }
        Dept.updateUserPosition.r(params).then((res) => {
          if (res.data && res.data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500
            })
            this.getDataList()
            this.positionVisible = false
          } else {
            this.$message.error(res.data.msg)
          }
        })
      },
      // 个人视野提交
      personViewFormSubmit () {
        const params = {
          userId: this.currentRow.userId,
          personViewIdList: this.personViewForm.personViewIdList
        }
        Dept.updateUserPersonView.r(params).then((res) => {
          if (res.data && res.data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500
            })
            this.getDataList()
            this.personVisible = false
          } else {
            this.$message.error(res.data.msg)
          }
        })
      },
      // 部门视野提交
      deptViewFormSubmit () {
        const params = {
          userId: this.currentRow.userId,
          deptViewIdList: this.$refs.deptViewRef.getCheckedKeys()
        }
        Dept.updateUserDeptView.r(params).then((res) => {
          if (res.data && res.data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500
            })
            this.getDataList()
            this.deptVisible = false
          } else {
            this.$message.error(res.data.msg)
          }
        })
      },
      // 转客户提交
      exchangeViewFormSubmit () {
        if (!this.exchangeClientDataSelect || this.exchangeClientDataSelect.length === 0) {
          this.$message.error('至少选择一个客户')
          return
        }
        if (!this.exchangeUserDataSelect || this.exchangeUserDataSelect.length === 0) {
          this.$message.error('请选择目标员工')
          return
        }
        if (this.exchangeUserDataSelect.length > 1) {
          this.$message.error('一次只能指定一个目标员工')
        }
        var clientIds = this.exchangeClientDataSelect.map(item => {
          return item.id
        })
        const params = {
          targetUser: this.exchangeUserDataSelect[0].userId,
          clientIdList: clientIds
        }
        Dept.exchangeClient.r(params).then((res) => {
          if (res.data && res.data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500,
              onClose: () => {
                this.getDataList()
              }
            })
            this.exchangeVisible = false
          } else {
            this.$message.error(res.data.msg)
          }
        })
      }
    }
  }
</script>
