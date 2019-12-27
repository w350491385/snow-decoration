<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="计划类别" prop="planType">
        <el-select v-model="dataForm.planType" placeholder="请选择" style="width: 100%">
          <el-option
            v-for="item in planTypeoptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="项目" prop="projectId">
        <el-select v-model="dataForm.projectId" placeholder="请选择" style="width: 100%">
          <el-option
            v-for="item in projectoptions"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="偏移天数" prop="offsetDays">
        <el-input type="number" placeholder="请输入偏移天数" v-model="dataForm.offsetDays">
          <template slot="append">天</template>
        </el-input>
      </el-form-item>
      <el-form-item label="历时天数" prop="durationDays">
        <el-input type="number" placeholder="请输入历时天数" v-model="dataForm.durationDays">
          <template slot="append">天</template>
        </el-input>
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input type="number" v-model="dataForm.sort" placeholder="排序"></el-input>
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
          planType: '',
          projectId: '',
          offsetDays: '',
          durationDays: '',
          sort: '',
          remark: ''
        },
        projectoptions: [],
        planTypeoptions: [],
        dataRule: {
          planType: [
            {required: true, message: '计划类别不能为空', trigger: 'blur'}
          ],
          projectId: [
            {required: true, message: '项目不能为空', trigger: 'blur'}
          ],
          offsetDays: [
            {required: true, message: '偏移天数不能为空', trigger: 'blur'}
          ],
          durationDays: [
            {required: true, message: '历时天数不能为空', trigger: 'blur'}
          ],
          sort: [
            {required: true, message: '排序不能为空', trigger: 'blur'}
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
              url: this.$http.adornUrl(`/tx/plantype/all`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.planTypeoptions = data.list
              }
            }).then(() => {
              if (this.dataForm.id) {
                this.$http({
                  url: this.$http.adornUrl(`/tx/plantemplat/info/${this.dataForm.id}`),
                  method: 'get',
                  params: this.$http.adornParams()
                }).then(({data}) => {
                  if (data && data.code === 0) {
                    this.dataForm.planType = data.plantemplat.planType
                    this.dataForm.projectId = data.plantemplat.projectId
                    this.dataForm.offsetDays = data.plantemplat.offsetDays
                    this.dataForm.durationDays = data.plantemplat.durationDays
                    this.dataForm.sort = data.plantemplat.sort
                    this.dataForm.remark = data.plantemplat.remark
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
              url: this.$http.adornUrl(`/tx/plantemplat/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'planType': this.dataForm.planType,
                'projectId': this.dataForm.projectId,
                'offsetDays': this.dataForm.offsetDays,
                'durationDays': this.dataForm.durationDays,
                'sort': this.dataForm.sort,
                'remark': this.dataForm.remark
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
