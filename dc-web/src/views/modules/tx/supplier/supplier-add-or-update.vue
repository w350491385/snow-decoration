<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="供应商名称" prop="name">
        <el-input v-model="dataForm.name" placeholder="名称"></el-input>
      </el-form-item>
      <el-form-item label="联系人" prop="manName">
        <el-input v-model="dataForm.manName" placeholder="联系人"></el-input>
      </el-form-item>
      <el-form-item label="联系人电话" prop="phone">
        <el-input type="number" v-model="dataForm.phone" placeholder="联系人电话"></el-input>
      </el-form-item>
      <el-form-item label="银行" prop="bankName">
        <el-input v-model="dataForm.bankName" placeholder="银行"></el-input>
      </el-form-item>
      <el-form-item label="银行账户" prop="bankAccount">
        <el-input v-model="dataForm.bankAccount" placeholder="银行账户"></el-input>
      </el-form-item>
      <el-form-item label="地址" prop="address">
        <el-input v-model="dataForm.address" placeholder="地址"></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="dataForm.remark" placeholder="备注"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          name: '',
          address: '',
          manName: '',
          bankAccount: '',
          bankName: '',
          remark: '',
          phone: ''
        },
        dataRule: {
          name: [
            {required: true, message: '名称不能为空', trigger: 'blur'}
          ],
          manName: [
            {required: true, message: '联系人不能为空', trigger: 'blur'}
          ],
          phone: [
            {required: true, message: '联系人电话不能为空', trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/tx/supplier/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.name = data.supplier.name
                this.dataForm.address = data.supplier.address
                this.dataForm.manName = data.supplier.manName
                this.dataForm.bankAccount = data.supplier.bankAccount
                this.dataForm.bankName = data.supplier.bankName
                this.dataForm.phone = data.supplier.phone
                this.dataForm.remark = data.supplier.remark
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/tx/supplier/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'name': this.dataForm.name,
                'address': this.dataForm.address,
                'manName': this.dataForm.manName,
                'bankAccount': this.dataForm.bankAccount,
                'bankName': this.dataForm.bankName,
                'remark': this.dataForm.remark,
                'phone': this.dataForm.phone
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
            })
          }
        })
      }
    }
  }
</script>
