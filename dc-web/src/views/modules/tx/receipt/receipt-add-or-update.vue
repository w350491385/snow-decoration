<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
    <el-form-item label="单据类型" prop="receiptType">
      <el-select style="width: 100%" v-model="dataForm.receiptType" placeholder="请选择">
        <el-option
          v-for="item in receiptTypeList"
          :key="item.value"
          :label="item.label"
          :value="item.value">
        </el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="单据名称" prop="name">
      <el-input v-model="dataForm.name" placeholder="单据名称"></el-input>
    </el-form-item>
    <el-form-item label="是否启用" prop="ifOn">
      <el-radio-group v-model="dataForm.ifOn">
        <el-radio :label=1>是</el-radio>
        <el-radio :label=0>否</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="物流信息" prop="logistics">
      <el-input v-model="dataForm.logistics" placeholder="物流信息"></el-input>
    </el-form-item>
    <el-form-item label="标记状态" prop="status">
      <el-radio-group v-model="dataForm.status">
        <el-radio :label=0>未发货</el-radio>
        <el-radio :label=1>已发货</el-radio>
        <el-radio :label=2>已收货</el-radio>
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
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          receiptType: '',
          name: '',
          ifOn: 1,
          logistics: '',
          status: 0
        },
        dataRule: {
          receiptType: [
            { required: true, message: '单据类型不能为空', trigger: 'blur' }
          ],
          name: [
            { required: true, message: '单据名称不能为空', trigger: 'blur' }
          ]
        },
        receiptTypeList: [
          {
            value: '1',
            label: '出货'
          },
          {
            value: '2',
            label: '装运'
          },
          {
            value: '3',
            label: '交货'
          }
        ]
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
              url: this.$http.adornUrl(`/tx/receipt/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.receiptType = data.receipt.receiptType
                this.dataForm.name = data.receipt.name
                this.dataForm.ifOn = data.receipt.ifOn
                this.dataForm.logistics = data.receipt.logistics
                this.dataForm.status = data.receipt.status
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
              url: this.$http.adornUrl(`/tx/receipt/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'receiptType': this.dataForm.receiptType,
                'name': this.dataForm.name,
                'ifOn': this.dataForm.ifOn,
                'logistics': this.dataForm.logistics,
                'status': this.dataForm.status
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
