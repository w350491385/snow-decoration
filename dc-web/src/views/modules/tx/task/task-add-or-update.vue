<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
    <el-form-item label="发起人" prop="launchMan">
      <el-input v-model="dataForm.launchMan" placeholder="发起人"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="content">
      <el-input v-model="dataForm.content" placeholder="内容"></el-input>
    </el-form-item>
    <el-form-item label="状态" prop="status">
      <el-radio-group v-model="dataForm.status">
        <el-radio :label=0>未开始</el-radio>
        <el-radio :label=1>进行中</el-radio>
        <el-radio :label=2>已完成</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="重要性" prop="importance">
      <el-radio-group v-model="dataForm.importance">
        <el-radio label='一般'>一般</el-radio>
        <el-radio label='重要'>重要</el-radio>
        <el-radio label='非常重要'>非常重要</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="负责人" prop="principal">
      <el-input v-model="dataForm.principal" placeholder="负责人"></el-input>
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
          launchMan: '',
          content: '',
          status: 0,
          importance: '一般',
          principal: ''
        },
        dataRule: {
          launchMan: [
            { required: true, message: '发起人不能为空', trigger: 'blur' }
          ],
          content: [
            { required: true, message: '内容不能为空', trigger: 'blur' }
          ],
          status: [
            { required: true, message: '状态不能为空', trigger: 'blur' }
          ],
          importance: [
            { required: true, message: '重要性不能为空', trigger: 'blur' }
          ],
          principal: [
            { required: true, message: '负责人不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/tx/task/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.launchMan = data.task.launchMan
                this.dataForm.content = data.task.content
                this.dataForm.status = data.task.status
                this.dataForm.importance = data.task.importance
                this.dataForm.principal = data.task.principal
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
              url: this.$http.adornUrl(`/tx/task/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'launchMan': this.dataForm.launchMan,
                'content': this.dataForm.content,
                'status': this.dataForm.status,
                'importance': this.dataForm.importance,
                'principal': this.dataForm.principal
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
