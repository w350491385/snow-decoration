<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form  :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="客户姓名" prop="clientName">
        <el-input v-model="dataForm.clientName" placeholder="必填"></el-input>
      </el-form-item>
      <el-form-item label="客户电话" prop="phone">
        <el-input type="number" v-model="dataForm.phone" placeholder="必填"></el-input>
      </el-form-item>
      <el-form-item label="客户编码" prop="clientCode">
        <el-input v-model="dataForm.clientCode" placeholder="选填"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-radio-group v-model="dataForm.sex">
          <el-radio label='1'>男</el-radio>
          <el-radio label='2'>女</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="地址" prop="address">
        <el-input v-model="dataForm.address" placeholder="选填"></el-input>
      </el-form-item>
      <el-form-item label="业务类型" prop="busType">
        <el-select v-model="dataForm.busType" placeholder="请选择">
          <el-option
            v-for="item in busTypeList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="阶段" prop="busPhase">
        <el-select v-model="dataForm.busPhase" placeholder="请选择">
          <el-option
            v-for="item in busPhaseList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="户型" prop="roomType">
        <el-select v-model="dataForm.roomType" placeholder="请选择">
          <el-option
            v-for="item in roomTypeList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="房型" prop="houseType">
        <el-select v-model="dataForm.houseType" placeholder="请选择">
          <el-option
            v-for="item in houseTypeList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="实用面积" prop="usefulArea">
        <el-input type="number" placeholder="选填" v-model="dataForm.usefulArea">
          <template slot="append">㎡</template>
        </el-input>
      </el-form-item>
      <el-form-item label="建筑面积" prop="buidArea">
        <el-input type="number" placeholder="选填" v-model="dataForm.buidArea">
          <template slot="append">㎡</template>
        </el-input>
      </el-form-item>
      <el-form-item label="所处状态" prop="status">
        <el-radio-group v-model="dataForm.status">
          <el-radio label='1'>开发中</el-radio>
          <el-radio label='2'>已签约</el-radio>
          <el-radio label='3'>未开工</el-radio>
          <el-radio label='4'>已开工</el-radio>
          <el-radio label='5'>已交付</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="领取时间" prop="receiveTime">
        <el-date-picker value-format="yyyy-MM-dd HH:mm:ss"
                        v-model="dataForm.receiveTime"
                        type="datetime"
                        placeholder="选择日期时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="数据来源" prop="source">
        <el-select v-model="dataForm.source" placeholder="请选择">
          <el-option
            v-for="item in sourceList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="客户类型" prop="clientType">
        <el-select v-model="dataForm.clientType" placeholder="请选择">
          <el-option
            v-for="item in clientTypeList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="期望签单金额" prop="hopeAmount">
        <el-input type="number" placeholder="选填" v-model="dataForm.hopeAmount">
          <template slot="append">元</template>
        </el-input>
      </el-form-item>
      <el-form-item label="期望签单日期" prop="hopeTime">
        <el-date-picker value-format="yyyy-MM-dd HH:mm:ss"
                        v-model="dataForm.hopeTime"
                        type="datetime"
                        placeholder="选择日期时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="合同金额" prop="contractAmount">
        <el-input type="number" v-model="dataForm.contractAmount" placeholder="选填">
          <template slot="append">元</template>
        </el-input>
      </el-form-item>
      <el-form-item label="已收款" prop="paidAmount">
        <el-input type="number" v-model="dataForm.paidAmount" placeholder="选填">
          <template slot="append">元</template>
        </el-input>
      </el-form-item>
      <el-form-item label="未跟进天数" prop="unfollwedDays">
        <el-input type="number" v-model="dataForm.unfollwedDays" placeholder="选填">
          <template slot="append">天</template>
        </el-input>
      </el-form-item>
      <el-form-item label="详细地址" prop="community">
        <el-select v-model="dataForm.community" placeholder="请选择小区">
          <el-option
            v-for="item in communityList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerCommunity">配置小区</el-button>
        <el-input placeholder="栋" v-model="dataForm.roof" style="width: 120px">
          <template slot="append">栋</template>
        </el-input>
        <el-input placeholder="单元" v-model="dataForm.unit" style="width: 120px">
          <template slot="append">单元</template>
        </el-input>
        <el-input placeholder="门牌" v-model="dataForm.doorplate" style="width: 120px">
          <template slot="append">号</template>
        </el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button  @click="visible = false">取消</el-button>
      <el-button  type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  import * as Public from '@/js/api/public'
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          belongId: '',
          clientName: '',
          phone: '',
          clientCode: '',
          sex: '1',
          address: '',
          busType: '',
          busPhase: '',
          roomType: '',
          houseType: '',
          createMan: '',
          createTime: '',
          usefulArea: '',
          status: '1',
          buidArea: '',
          receiveTime: '',
          source: '',
          clientType: '',
          escape: '',
          hopeAmount: '',
          hopeTime: '',
          contractAmount: '',
          paidAmount: '',
          paidPercent: '',
          unfollwedDays: '',
          community: '',
          roof: '',
          unit: '',
          doorplate: ''
        },
        busTypeList: [],
        busPhaseList: [],
        roomTypeList: [],
        houseTypeList: [],
        sourceList: [],
        clientTypeList: [],
        communityList: [],
        dataRule: {
          clientName: [
            {required: true, message: '客户姓名不能为空', trigger: 'blur'}
          ]
        }
      }
    },
    components: {
      Public
    },
    methods: {
      routerDict () {
        this.visible = false
        this.$router.push({name: 'sys-dict'})
        this.$message.info('请选择相应分类进行配置')
      },
      routerCommunity () {
        this.visible = false
        this.$router.push({name: 'tx-community/community'})
      },
      init (id) {
        this.dataForm.id = id || 0
        this.dataForm.roof = ''
        this.dataForm.unit = ''
        this.dataForm.doorplate = ''
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          Public.findDictByType.r({typeId: 1005}).then((res) => {
            this.sourceList = res.data.list
          })
          Public.findDictByType.r({typeId: 1003}).then((res) => {
            this.busPhaseList = res.data.list
          })
          Public.findDictByType.r({typeId: 1024}).then((res) => {
            this.roomTypeList = res.data.list
          })
          Public.findDictByType.r({typeId: 1004}).then((res) => {
            this.busTypeList = res.data.list
          })
          Public.findDictByType.r({typeId: 1006}).then((res) => {
            this.clientTypeList = res.data.list
          })
          Public.findDictByType.r({typeId: 1011}).then((res) => {
            this.houseTypeList = res.data.list
          })
          Public.findCommunity.r({}).then((res) => {
            this.communityList = res.data.list
          })
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/tx/formalclient/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.belongId = data.formalclient.belongId
                this.dataForm.clientName = data.formalclient.clientName
                this.dataForm.phone = data.formalclient.phone
                this.dataForm.clientCode = data.formalclient.clientCode
                this.dataForm.sex = data.formalclient.sex
                this.dataForm.address = data.formalclient.address
                this.dataForm.busType = data.formalclient.busType
                this.dataForm.busPhase = data.formalclient.busPhase
                this.dataForm.roomType = data.formalclient.roomType
                this.dataForm.houseType = data.formalclient.houseType
                this.dataForm.createMan = data.formalclient.createMan
                this.dataForm.createTime = data.formalclient.createTime
                this.dataForm.usefulArea = data.formalclient.usefulArea
                this.dataForm.status = data.formalclient.status
                this.dataForm.buidArea = data.formalclient.buidArea
                this.dataForm.receiveTime = data.formalclient.receiveTime
                this.dataForm.source = data.formalclient.source
                this.dataForm.clientType = data.formalclient.clientType
                this.dataForm.escape = data.formalclient.escape
                this.dataForm.hopeAmount = data.formalclient.hopeAmount
                this.dataForm.hopeTime = data.formalclient.hopeTime
                this.dataForm.contractAmount = data.formalclient.contractAmount
                this.dataForm.paidAmount = data.formalclient.paidAmount
                this.dataForm.paidPercent = data.formalclient.paidPercent
                this.dataForm.unfollwedDays = data.formalclient.unfollwedDays
                this.dataForm.community = data.formalclient.community
                this.dataForm.roof = data.formalclient.roof
                this.dataForm.unit = data.formalclient.unit
                this.dataForm.doorplate = data.formalclient.doorplate
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
              url: this.$http.adornUrl(`/tx/formalclient/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'belongId': this.dataForm.belongId,
                'clientName': this.dataForm.clientName,
                'phone': this.dataForm.phone,
                'clientCode': this.dataForm.clientCode,
                'sex': this.dataForm.sex,
                'address': this.dataForm.address,
                'busType': this.dataForm.busType,
                'busPhase': this.dataForm.busPhase,
                'roomType': this.dataForm.roomType,
                'houseType': this.dataForm.houseType,
                'createMan': this.dataForm.createMan,
                'createTime': this.dataForm.createTime,
                'usefulArea': this.dataForm.usefulArea,
                'status': this.dataForm.status,
                'buidArea': this.dataForm.buidArea,
                'receiveTime': this.dataForm.receiveTime,
                'source': this.dataForm.source,
                'clientType': this.dataForm.clientType,
                'escape': this.dataForm.escape,
                'hopeAmount': this.dataForm.hopeAmount,
                'hopeTime': this.dataForm.hopeTime,
                'contractAmount': this.dataForm.contractAmount,
                'paidAmount': this.dataForm.paidAmount,
                'paidPercent': this.dataForm.paidPercent,
                'unfollwedDays': this.dataForm.unfollwedDays,
                'community': this.dataForm.community,
                'roof': this.dataForm.roof,
                'unit': this.dataForm.unit,
                'doorplate': this.dataForm.doorplate
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
