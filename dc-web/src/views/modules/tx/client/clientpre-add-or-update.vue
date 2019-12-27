<style>
  .tangram-suggestion {
    z-index: 300000000;
  }
</style>
<style lang="scss" scoped>
  .mod-demo-ueditor {
    position: relative;
    z-index: 510;

    > .el-alert {
      margin-bottom: 10px;
    }
  }

  #allmap {
    height: 300px;
    margin-top: 0.4em;
    border: 1px solid rgb(223, 224, 228);
  }
</style>
<template>
  <el-row v-if="visible">
    <el-row style="background-color: #eaeaea;height: 35px;line-height: 35px">
      <el-tag style="margin-left: 50px;margin-right: 50px">{{title=!dataForm.id ? '新增预约客户' : '修改预约客户'}}</el-tag>
      <el-button  @click="back">取消</el-button>
      <el-button  type="primary" @click="dataFormSubmit()">保存</el-button>
    </el-row>
    <el-row style="max-width: 800px;margin-top: 20px">
      <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
        <el-form-item label="客户名称" prop="clientName">
          <el-input v-model="dataForm.clientName" placeholder="可手填或从系统中选择">
            <el-button slot="append" icon="el-icon-search" @click="chooseClient()">选择</el-button>
          </el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input type="number" v-model="dataForm.phone" placeholder="电话"></el-input>
        </el-form-item>
        <el-form-item label="预约时间" prop="preTime">
          <el-date-picker
            value-format="yyyy-MM-dd HH:mm:ss"
            v-model="dataForm.preTime"
            type="datetime"
            placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="dataForm.status">
            <el-radio label="0">未处理</el-radio>
            <el-radio label="1">已处理</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="处理人" prop="dealMan">
          <el-input v-model="dataForm.dealMan" placeholder="处理人"></el-input>
        </el-form-item>
      </el-form>
    </el-row>
    <!--选择客户-->
    <client-choose v-if="chooseVisible" ref="chooseClient" :show-all="false" @change="chooseOne"></client-choose>
  </el-row>
</template>

<script>
  import ClientChoose from '../../public/clientchoose'

  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          clientName: '',
          phone: '',
          preTime: '',
          status: '0',
          dealMan: '',
          clientId: ''
        },
        selectClient: {
          name: ''
        },
        dataRule: {
          clientName: [
            {required: true, message: '客户名称不能为空', trigger: 'blur'}
          ],
          phone: [
            {required: true, message: '电话不能为空', trigger: 'blur'}
          ],
          preTime: [
            {required: true, message: '预约时间不能为空', trigger: 'blur'}
          ],
          status: [
            {required: true, message: '状态不能为空', trigger: 'blur'}
          ],
          dealMan: [
            {required: true, message: '处理人不能为空', trigger: 'blur'}
          ]
        },
        chooseVisible: false
      }
    },
    components: {
      ClientChoose
    },
    methods: {
      back () {
        this.$nextTick(() => {
          this.visible = false
          this.$refs['dataForm'].resetFields()
        })
        this.$emit('back')
      },
      // 选择我的客户
      chooseClient () {
        this.chooseVisible = true
        this.$nextTick(() => {
          this.$refs.chooseClient.init()
        })
      },
      chooseOne (obj) {
        this.dataForm.clientName = obj.clientName
        this.dataForm.clientId = obj.id
        this.dataForm.phone = obj.phone
      },
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/tx/clientpre/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.clientName = data.clientpre.clientName
                this.dataForm.phone = data.clientpre.phone
                this.dataForm.preTime = data.clientpre.preTime
                this.dataForm.source = data.clientpre.source
                this.dataForm.status = data.clientpre.status
                this.dataForm.dealMan = data.clientpre.dealMan
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
              url: this.$http.adornUrl(`/tx/clientpre/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'clientName': this.dataForm.clientName,
                'clientId': this.dataForm.clientId,
                'phone': this.dataForm.phone,
                'preTime': this.dataForm.preTime,
                'source': this.dataForm.source,
                'status': this.dataForm.status,
                'dealMan': this.dataForm.dealMan
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
