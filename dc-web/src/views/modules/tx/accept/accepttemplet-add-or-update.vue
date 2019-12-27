<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="模板名称" prop="name">
        <el-input v-model="dataForm.name" placeholder="模板名称"></el-input>
      </el-form-item>
      <el-form-item label="验收类别" prop="acceptType">
        <el-select v-model="dataForm.acceptType" placeholder="请选择" style="width: 100%">
          <el-option
            v-for="item in acceptTypeoptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="验收项目" prop="projectId">
        <el-select v-model="dataForm.projectId" placeholder="请选择" style="width: 100%">
          <el-option
            v-for="item in projectoptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="标准" prop="standard">
        <el-input v-model="dataForm.standard" placeholder="标准"></el-input>
      </el-form-item>
      <el-form-item label="是否启用" prop="ifMust">
        <el-radio-group v-model="dataForm.ifMust">
          <el-radio :label=0>否</el-radio>
          <el-radio :label=1>是</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="图片说明" prop="pictureJson">
        <el-input v-model="dataForm.pictureJson" placeholder="图片说明"></el-input>
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
          acceptType: '',
          projectId: '',
          standard: '',
          ifMust: 1,
          pictureJson: ''
        },
        acceptTypeoptions: [],
        projectoptions: [],
        dataRule: {
          name: [
            {required: true, message: '模板名称不能为空', trigger: 'blur'}
          ],
          acceptType: [
            {required: true, message: '验收类别不能为空', trigger: 'blur'}
          ],
          projectId: [
            {required: true, message: '验收项目不能为空', trigger: 'blur'}
          ],
          standard: [
            {required: true, message: '标准不能为空', trigger: 'blur'}
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
          this.$http({
            url: this.$http.adornUrl(`/tx/project/all`),
            method: 'get',
            params: this.$http.adornParams()
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.projectoptions = data.list
            }
          }).then(() => {
            this.$http({
              url: this.$http.adornUrl(`/tx/accepttype/all`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.acceptTypeoptions = data.list
              }
            }).then(() => {
              if (this.dataForm.id) {
                this.$http({
                  url: this.$http.adornUrl(`/tx/accepttemplet/info/${this.dataForm.id}`),
                  method: 'get',
                  params: this.$http.adornParams()
                }).then(({data}) => {
                  if (data && data.code === 0) {
                    this.dataForm.acceptType = data.accepttemplet.acceptType
                    this.dataForm.projectId = data.accepttemplet.projectId
                    this.dataForm.standard = data.accepttemplet.standard
                    this.dataForm.ifMust = data.accepttemplet.ifMust
                    this.dataForm.pictureJson = data.accepttemplet.pictureJson
                  }
                })
              }
            })
          })
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/tx/accepttemplet/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'acceptType': this.dataForm.acceptType,
                'projectId': this.dataForm.projectId,
                'standard': this.dataForm.standard,
                'ifMust': this.dataForm.ifMust,
                'pictureJson': this.dataForm.pictureJson
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
