<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="报修主表" prop="repairId">
      <el-input v-model="dataForm.repairId" placeholder="报修主表"></el-input>
    </el-form-item>
    <el-form-item label="发言人" prop="manId">
      <el-input v-model="dataForm.manId" placeholder="发言人"></el-input>
    </el-form-item>
    <el-form-item label="动作行为" prop="action">
      <el-input v-model="dataForm.action" placeholder="动作行为"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="content">
      <el-input v-model="dataForm.content" placeholder="内容"></el-input>
    </el-form-item>
    <el-form-item label="时间" prop="createTime">
      <el-input v-model="dataForm.createTime" placeholder="时间"></el-input>
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
          repairId: '',
          manId: '',
          action: '',
          content: '',
          createTime: ''
        },
        dataRule: {
          repairId: [
            { required: true, message: '报修主表不能为空', trigger: 'blur' }
          ],
          manId: [
            { required: true, message: '发言人不能为空', trigger: 'blur' }
          ],
          action: [
            { required: true, message: '动作行为不能为空', trigger: 'blur' }
          ],
          content: [
            { required: true, message: '内容不能为空', trigger: 'blur' }
          ],
          createTime: [
            { required: true, message: '时间不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/tx/repairinfo/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.repairId = data.repairinfo.repairId
                this.dataForm.manId = data.repairinfo.manId
                this.dataForm.action = data.repairinfo.action
                this.dataForm.content = data.repairinfo.content
                this.dataForm.createTime = data.repairinfo.createTime
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
              url: this.$http.adornUrl(`/tx/repairinfo/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'repairId': this.dataForm.repairId,
                'manId': this.dataForm.manId,
                'action': this.dataForm.action,
                'content': this.dataForm.content,
                'createTime': this.dataForm.createTime
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
