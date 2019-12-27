<template>
  <div>
    <el-dialog
      :title="!dataForm.id ? '新增' : '修改'"
      :close-on-click-modal="false"
      :visible.sync="visible">
      <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
        <el-form-item label="报修客户" prop="clientName">
          <el-input v-model="dataForm.clientName" placeholder="报修客户" @focus="chooseClient()"></el-input>
        </el-form-item>
        <el-form-item label="报修类型" prop="repairType">
          <el-select style="width: 100%" v-model="dataForm.repairType" placeholder="请选择">
            <el-option
              v-for="item in repairTypeList"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="报修描述" prop="repairDesc">
          <el-input v-model="dataForm.repairDesc" placeholder="报修描述"></el-input>
        </el-form-item>
        <el-form-item label="修理人" prop="repairMan">
          <el-input v-model="dataForm.repairMan" placeholder="修理人"></el-input>
        </el-form-item>
        <el-form-item label="修理人联系电话" prop="repairPhone">
          <el-input type="number" v-model="dataForm.repairPhone" placeholder="修理人联系电话"></el-input>
        </el-form-item>
        <el-form-item label="分配描述" prop="distributeDesc">
          <el-input v-model="dataForm.distributeDesc" placeholder="分配描述"></el-input>
        </el-form-item>
        <el-form-item label="核价" prop="amount">
          <el-input type="number" v-model="dataForm.amount" placeholder="核价">
            <template slot="append">元</template>
          </el-input>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="dataForm.status">
            <el-radio :label=0>未受理</el-radio>
            <el-radio :label=1>受理中</el-radio>
            <el-radio :label=2>已解决</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="反馈时间" prop="feedbackTime">
          <el-date-picker value-format="yyyy-MM-dd HH:mm:ss"
                          v-model="dataForm.feedbackTime"
                          type="datetime"
                          placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="发起时间" prop="launchTime">
          <el-date-picker value-format="yyyy-MM-dd HH:mm:ss"
                          v-model="dataForm.launchTime"
                          type="datetime"
                          placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="图片描述" prop="repairPic">
          <el-upload
            class="upload-demo"
            :action="url"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :on-success="successHandle"
            :file-list="fileList"
            list-type="picture">
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
          </el-upload>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
    </el-dialog>
    <!--选择客户-->
    <client-choose v-if="chooseVisible" ref="chooseClient" :show-all="false" @change="chooseOne"></client-choose>
  </div>
</template>

<script>
  import ClientChoose from '../../public/clientchoose'
  import * as Public from '@/js/api/public'
  import {getToken} from '@/utils'

  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          clientId: '',
          clientName: '',
          repairType: '',
          repairDesc: '',
          repairPic: '',
          repairMan: '',
          repairPhone: '',
          distributeDesc: '',
          repairSource: '',
          amount: '',
          status: 0,
          feedbackTime: '',
          launchTime: ''
        },
        dataRule: {
          clientId: [
            {required: true, message: '报修客户不能为空', trigger: 'blur'}
          ],
          repairType: [
            {required: true, message: '保修类型不能为空', trigger: 'blur'}
          ],
          repairMan: [
            {required: true, message: '修理人不能为空', trigger: 'blur'}
          ],
          repairPhone: [
            {required: true, message: '修理人联系电话不能为空', trigger: 'blur'}
          ],
          distributeDesc: [
            {required: true, message: '分配描述不能为空', trigger: 'blur'}
          ],
          feedbackTime: [
            {required: true, message: '反馈时间不能为空', trigger: 'blur'}
          ],
          launchTime: [
            {required: true, message: '发起时间不能为空', trigger: 'blur'}
          ]
        },
        repairTypeList: [],
        chooseVisible: false,
        fileList: [],
        url: ''
      }
    },
    components: {
      ClientChoose
    },
    methods: {
      // 图片相关
      handleRemove (file, fileList) {},
      handlePreview (file) {},
      // 上传成功
      successHandle (response, file, fileList) {
        var fileJson = {
          name: file.name,
          url: response.url
        }
        this.fileList.push(fileJson)
        this.successNum++
        if (response && response.code === 0) {
          this.$message.success('上传成功')
        } else {
          this.$message.error(response.msg)
        }
      },
      chooseOne (obj) {
        this.dataForm.clientName = obj.clientName
        this.dataForm.clientId = obj.id
      },
      // 选择我的客户
      chooseClient () {
        this.chooseVisible = true
        this.$nextTick(() => {
          this.$refs.chooseClient.init()
        })
      },
      init (id) {
        this.url = this.$http.adornUrl(`/sys/oss/upload?token=${getToken()}`)
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          Public.findDictByType.r({typeId: 1022}).then((res) => {
            this.repairTypeList = res.data.list
          }).then(() => {
            if (this.dataForm.id) {
              this.$http({
                url: this.$http.adornUrl(`/tx/repair/info/${this.dataForm.id}`),
                method: 'get',
                params: this.$http.adornParams()
              }).then(({data}) => {
                if (data && data.code === 0) {
                  this.dataForm.clientId = data.repair.clientId
                  this.dataForm.repairType = data.repair.repairType
                  this.dataForm.repairDesc = data.repair.repairDesc
                  this.dataForm.repairPic = data.repair.repairPic
                  if (data.repair.repairPic) {
                    this.fileList = JSON.parse(data.repair.repairPic)
                  }
                  this.dataForm.repairMan = data.repair.repairMan
                  this.dataForm.repairPhone = data.repair.repairPhone
                  this.dataForm.distributeDesc = data.repair.distributeDesc
                  this.dataForm.repairSource = data.repair.repairSource
                  this.dataForm.amount = data.repair.amount
                  this.dataForm.status = data.repair.status
                  this.dataForm.feedbackTime = data.repair.feedbackTime
                  this.dataForm.launchTime = data.repair.launchTime
                }
              })
            }
          })
        })
      },
      // 表单提交
      dataFormSubmit () {
        if (this.fileList) {
          this.dataForm.repairPic = JSON.stringify(this.fileList).toString()
        }
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/tx/repair/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'clientId': this.dataForm.clientId,
                'repairType': this.dataForm.repairType,
                'repairDesc': this.dataForm.repairDesc,
                'repairPic': this.dataForm.repairPic,
                'repairMan': this.dataForm.repairMan,
                'repairPhone': this.dataForm.repairPhone,
                'distributeDesc': this.dataForm.distributeDesc,
                'repairSource': this.dataForm.repairSource,
                'amount': this.dataForm.amount,
                'status': this.dataForm.status,
                'feedbackTime': this.dataForm.feedbackTime,
                'launchTime': this.dataForm.launchTime
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
