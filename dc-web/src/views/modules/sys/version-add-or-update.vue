<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" label-width="120px">
      <el-form-item label="版本号" prop="version">
        <el-input v-model="dataForm.version" placeholder="版本号"></el-input>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-date-picker
          value-format="yyyy-MM-dd"
          v-model="dataForm.updateTime"
          type="date"
          placeholder="选择日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="更新描述" prop="description">
        <el-input type="textarea" v-model="dataForm.description" placeholder="更新描述"></el-input>
      </el-form-item>
      <el-form-item label="win32更新包" prop="win32Href">
        <el-input v-model="dataForm.win32Href" placeholder="win32更新包"></el-input>
      </el-form-item>
      <el-form-item label="win64更新包" prop="win64Href">
        <el-input v-model="dataForm.win64Href" placeholder="win64更新包"></el-input>
      </el-form-item>
      <el-form-item label="mac更新包" prop="macHref">
        <el-input v-model="dataForm.macHref" placeholder="mac更新包"></el-input>
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
          version: '',
          updateTime: '',
          description: '',
          win32Href: '',
          win64Href: '',
          macHref: ''
        },
        dataRule: {
          version: [
            {required: true, message: '版本号不能为空', trigger: 'blur'}
          ],
          updateTime: [
            {required: true, message: '更新时间不能为空', trigger: 'blur'}
          ],
          description: [
            {required: true, message: '更新描述不能为空', trigger: 'blur'}
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
              url: this.$http.adornUrl(`/sys/version/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.version = data.version.version
                this.dataForm.updateTime = data.version.updateTime
                this.dataForm.description = data.version.description
                this.dataForm.win32Href = data.version.win32Href
                this.dataForm.win64Href = data.version.win64Href
                this.dataForm.macHref = data.version.macHref
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
              url: this.$http.adornUrl(`/sys/version/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'version': this.dataForm.version,
                'updateTime': this.dataForm.updateTime,
                'description': this.dataForm.description,
                'win32Href': this.dataForm.win32Href,
                'win64Href': this.dataForm.win64Href,
                'macHref': this.dataForm.macHref
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
