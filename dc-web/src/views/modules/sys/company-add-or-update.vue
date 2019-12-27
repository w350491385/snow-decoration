<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="企业名称" prop="cpName">
        <el-input v-model="dataForm.cpName" placeholder="企业名称"></el-input>
      </el-form-item>
      <el-form-item label="企业主姓名" prop="ceo">
        <el-input v-model="dataForm.ceo" placeholder="CEO"></el-input>
      </el-form-item>
      <el-form-item label="许可子账号数量" prop="ceo">
        <el-input type="number" v-model="dataForm.allowAccount" placeholder="许可子账号数量"></el-input>
      </el-form-item>
      <el-form-item label="营业执照" prop="licenseUrl">
        <el-input v-model="dataForm.licenseUrl" placeholder="营业执照"></el-input>
      </el-form-item>
      <el-form-item label="联系电话" prop="phone">
        <el-input v-model="dataForm.phone" placeholder="联系电话"></el-input>
      </el-form-item>
      <el-form-item label="授权">
        <el-tree
          :data="menuList"
          :props="menuListTreeProps"
          node-key="menuId"
          ref="menuListTree"
          show-checkbox>
        </el-tree>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()" :loading=submitLoading>确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  import { treeDataTranslate } from '@/utils'
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          cpId: 0,
          cpName: '',
          ceo: '',
          licenseUrl: '',
          phone: '',
          allowAccount: ''
        },
        submitLoading: false,
        dataRule: {
          cpName: [
            {required: true, message: '企业名称不能为空', trigger: 'blur'}
          ]
        },
        menuListTreeProps: {
          label: 'name',
          children: 'child'
        },
        menuList: [],
        tempKey: -666666 // 临时key, 用于解决tree半选中状态项不能传给后台接口问题. # 待优化
      }
    },
    methods: {
      init (id) {
        this.dataForm.cpId = id || 0
        this.$http({
          url: this.$http.adornUrl('/sys/menu/list'),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          this.menuList = treeDataTranslate(data, 'menuId')
        }).then(() => {
          this.visible = true
          this.$nextTick(() => {
            this.$refs['dataForm'].resetFields()
            this.$refs.menuListTree.setCheckedKeys([])
          })
        }).then(() => {
          if (this.dataForm.cpId) {
            this.$http({
              url: this.$http.adornUrl(`/sys/company/info/${this.dataForm.cpId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.cpName = data.company.cpName
                this.dataForm.ceo = data.company.ceo
                this.dataForm.licenseUrl = data.company.licenseUrl
                this.dataForm.phone = data.company.phone
                this.dataForm.allowAccount = data.company.allowAccount
                var idx = data.company.menuIdList.indexOf(this.tempKey)
                if (idx !== -1) {
                  data.company.menuIdList.splice(idx, data.company.menuIdList.length - idx)
                }
                this.$refs.menuListTree.setCheckedKeys(data.company.menuIdList)
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.submitLoading = true
            this.$http({
              url: this.$http.adornUrl(`/sys/company/${!this.dataForm.cpId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'cpId': this.dataForm.cpId || undefined,
                'cpName': this.dataForm.cpName,
                'ceo': this.dataForm.ceo,
                'licenseUrl': this.dataForm.licenseUrl,
                'phone': this.dataForm.phone,
                'allowAccount': this.dataForm.allowAccount,
                'menuIdList': [].concat(this.$refs.menuListTree.getCheckedKeys(), [this.tempKey], this.$refs.menuListTree.getHalfCheckedKeys())
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
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
                this.$message.error(data.msg)
              }
              this.submitLoading = false
            })
          }
        })
      }
    }
  }
</script>
