<template>
  <el-dialog
    :title="!dataForm.userId ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="姓名:" prop="username">
        <el-input v-model="dataForm.username" placeholder="员工姓名"></el-input>
      </el-form-item>
      <el-form-item label="所属部门:" prop="deptId">
        <el-popover
          ref="deptListPopover"
          placement="bottom-start"
          trigger="click">
          <el-tree
            clearable
            :data="dataList"
            :props="deptListTreeProps"
            node-key="id"
            ref="deptListTree"
            @current-change="deptListTreeCurrentChangeHandle"
            :default-expand-all="true"
            :highlight-current="true"
            :expand-on-click-node="false">
          </el-tree>
        </el-popover>
        <el-input v-model="dataForm.deptName" v-popover:deptListPopover :readonly="true" placeholder="点击选择部门" class="menu-list__input"></el-input>
      </el-form-item>
      <el-form-item label="入职日期:" prop="entry">
        <el-date-picker style="width: 100%"
                        v-model="dataForm.entry"
                        type="date"
                        placeholder="选择日期时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="公司职位:" prop="job">
        <el-input v-model="dataForm.job" placeholder="公司职位"></el-input>
      </el-form-item>
      <el-form-item label="手机号:" prop="mobile">
        <el-input v-model="dataForm.mobile" placeholder="手机号或邮箱为登录账号，默认密码000000"></el-input>
      </el-form-item>
      <el-form-item label="邮箱:" prop="email">
        <el-input v-model="dataForm.email" placeholder="手机号或邮箱为登录账号，默认密码000000"></el-input>
      </el-form-item>
      <el-form-item label="功能菜单分配:" prop="roleIdList">
        <el-row v-if="roleList.length<=0">
          <span style="color: #dd3900">当前无可选项,需要先配置</span>
        </el-row>
        <el-checkbox-group v-model="dataForm.roleIdList">
          <el-checkbox v-for="role in roleList" :key="role.roleId" :label="role.roleId">{{ role.roleName }}</el-checkbox>
          <el-button style="margin-left: 30px" type="text" @click="routerRole">配置可选项</el-button>
        </el-checkbox-group>

      </el-form-item>
      <el-form-item label="服务岗位:" prop="positionIdList">
        <el-checkbox-group v-model="dataForm.positionIdList">
          <el-checkbox v-for="item in positionList" :key="item.id" :label="item.id">{{ item.name }}</el-checkbox>
          <el-button style="margin-left: 30px" type="text" @click="routerPosition">配置可选项</el-button>
        </el-checkbox-group>
      </el-form-item>
      <el-form-item label="是否激活:" prop="ifOn">
        <el-radio-group v-model="dataForm.ifOn">
          <el-radio :label="true">是</el-radio>
          <el-radio :label="false">否</el-radio>
        </el-radio-group>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  import {isMobile} from '@/utils/validate'
  import {treeDataTranslate} from '@/utils'
  import * as Public from '../../../js/api/public'

  export default {
    data () {
      var validateMobile = (rule, value, callback) => {
        if (!isMobile(value)) {
          callback(new Error('手机号格式错误'))
        } else {
          callback()
        }
      }
      return {
        visible: false,
        roleList: [],
        positionList: [],
        dataForm: {
          userId: 0,
          deptId: '',
          deptName: '',
          entry: null,
          username: '',
          mobile: '',
          job: '',
          roleIdList: [],
          ifOn: true,
          positionIdList: [],
          email: ''
        },
        dataRule: {
          username: [
            {required: true, message: '姓名不能为空', trigger: 'blur'}
          ],
          deptId: [
            {required: true, message: '所属部门不能为空', trigger: 'change'}
          ],
          job: [
            {required: true, message: '公司职位不能为空', trigger: 'blur'}
          ],
          email: [
            {required: true, message: '邮箱不能为空', trigger: 'blur'}
          ],
          mobile: [
            {required: true, message: '手机号不能为空', trigger: 'blur'},
            {validator: validateMobile, trigger: 'blur'}
          ]
        },
        dataList: [],
        deptListTreeProps: {
          label: 'name',
          children: 'child'
        }
      }
    },
    methods: {
      routerRole () {
        this.visible = false
        this.$router.push({name: 'sys-role'})
      },
      routerPosition () {
        this.visible = false
        this.$router.push({name: 'tx-sysposition/sysposition'})
      },
      // 菜单树选中
      deptListTreeCurrentChangeHandle (data, node) {
        this.dataForm.deptId = data.id
        this.dataForm.deptName = data.name
      },
      // 菜单树设置当前选中节点
      deptListTreeSetCurrentNode () {
        this.$refs.deptListTree.setCurrentKey(this.dataForm.deptId)
        this.dataForm.deptName = (this.$refs.deptListTree.getCurrentNode() || {})['name']
      },
      initPublic () {
        Public.findAllSysposition.r().then((res) => {
          this.positionList = res.data && res.data.code === 0 ? res.data.list : []
        }).then(() => {
          Public.findAllRole.r().then((res) => {
            this.roleList = res.data && res.data.code === 0 ? res.data.list : []
          }).then(() => {
            Public.findAllDept.r().then((res) => {
              if (res.data && res.data.code === 0) {
                this.dataList = treeDataTranslate(res.data.list, 'id')
              } else {
                this.dataList = []
              }
              this.dataListLoading = false
            })
          })
        })
      },
      init (id, val) {
        this.$nextTick(() => {
          this.initPublic()
        })
        this.dataForm.userId = id || 0
        this.dataForm.deptName = ''
        this.dataForm.deptId = ''
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
        })
        if (this.dataForm.userId) {
          this.$http({
            url: this.$http.adornUrl(`/sys/user/info/${this.dataForm.userId}`),
            method: 'get',
            params: this.$http.adornParams()
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$nextTick(() => {
                this.dataForm = data.user
              })
            }
          })
        }
      },
      // 新增或修改
      dataFormSubmit () {
        if (this.dataForm.roleIdList.length === 0) {
          this.$message.error('功能菜单分配至少分配一个')
          return
        }
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            Public.addOrUpUser.r(this.dataForm).then((res) => {
              if (res.data && res.data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 500,
                  onClose: () => {
                    this.visible = false
                    this.$emit('refreshDataList')
                  }
                })
              } else {
                this.$message.error(res.data.msg)
              }
            })
          }
        })
      }
    }
  }
</script>
<style lang="scss">
  .mod-menu {
    .menu-list__input,
    .icon-list__input {
      > .el-input__inner {
        cursor: pointer;
      }
    }

    &__icon-popover {
      max-width: 370px;
    }

    &__icon-list {
      max-height: 180px;
      padding: 0;
      margin: -8px 0 0 -8px;

      > .el-button {
        padding: 8px;
        margin: 8px 0 0 8px;

        > span {
          display: inline-block;
          vertical-align: middle;
          width: 18px;
          height: 18px;
          font-size: 18px;
        }
      }
    }

    .icon-list__tips {
      font-size: 18px;
      text-align: center;
      color: #e6a23c;
      cursor: pointer;
    }
  }
</style>
