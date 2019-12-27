<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" label-width="120px">
      <el-form-item label="所属空间：" prop="roomId">
        {{dataForm.roomName}}
      </el-form-item>
      <el-form-item label="名称：" prop="name">
        {{dataForm.name}}
      </el-form-item>
      <el-form-item label="工种：" prop="workType">
        {{dataForm.workTypeName}}
      </el-form-item>
      <el-form-item label="单位：" prop="unit">
        {{dataForm.unit}}
      </el-form-item>
      <el-form-item label="数量：" prop="amount">
        <el-input type="number" v-model="dataForm.amount"></el-input>
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
          roomId: '',
          projectId: '',
          roomName: '',
          name: '',
          workType: '',
          unit: '',
          amount: 0,
          workTypeName: ''
        },
        room: {},
        dataRule: {
          name: [
            {required: true, message: '项目名称不能为空', trigger: 'blur'}
          ],
          workType: [
            {required: true, message: '工种不能为空', trigger: 'blur'}
          ],
          unit: [
            {required: true, message: '单位不能为空', trigger: 'blur'}
          ],
          amount: [
            {required: true, message: '数量不能为空', trigger: 'blur'}
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
              url: this.$http.adornUrl(`/tx/predictproject/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.roomId = data.predictproject.roomId
                this.dataForm.roomName = data.predictproject.roomName
                this.dataForm.projectId = data.predictproject.projectId
                this.dataForm.name = data.predictproject.name
                this.dataForm.workType = data.predictproject.workType
                this.dataForm.workTypeName = data.predictproject.workTypeName
                this.dataForm.unit = data.predictproject.unit
                this.dataForm.amount = data.predictproject.amount
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
              url: this.$http.adornUrl(`/tx/predictproject/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'roomId': this.dataForm.roomId,
                'projectId': this.dataForm.projectId,
                'name': this.dataForm.name,
                'workType': this.dataForm.workType,
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
