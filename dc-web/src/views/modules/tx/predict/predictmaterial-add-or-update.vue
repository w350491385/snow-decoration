<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="名称：" prop="materialName">
        <span>{{dataForm.materialName}}</span>
      </el-form-item>
      <el-form-item label="计量单位：" prop="unit">
        <span>{{dataForm.unit}}</span>
      </el-form-item>
      <el-form-item label="销售单价：" prop="unit">
        <span>{{dataForm.totalPrice}}</span>
      </el-form-item>
      <el-form-item label="数量：" prop="amount">
        <el-input v-model="dataForm.amount" placeholder="数量"></el-input>
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
          materialId: '',
          materialName: '',
          roomId: '',
          name: '',
          unit: '',
          amount: 0,
          totalPrice: ''
        },
        room: {},
        dataRule: {
          amount: [
            {required: true, message: '不能为空', trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      init (id, room) {
        this.room = room
        this.dataForm.id = id || 0
        this.dataForm.roomId = room.id
        this.dataForm.roomName = room.name
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/tx/predictmaterial/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.materialId = data.predictmaterial.materialId
                this.dataForm.materialName = data.predictmaterial.materialName
                this.dataForm.totalPrice = data.predictmaterial.totalPrice
                this.dataForm.roomId = data.predictmaterial.roomId
                this.dataForm.unit = data.predictmaterial.unit
                this.dataForm.amount = data.predictmaterial.amount
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
              url: this.$http.adornUrl(`/tx/predictmaterial/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'materialId': this.dataForm.materialId,
                'roomId': this.dataForm.roomId,
                'unit': this.dataForm.unit,
                'amount': this.dataForm.amount
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
        })
      }
    }
  }
</script>
