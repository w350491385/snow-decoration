<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="客户姓名" prop="clientName">
        <el-input v-model="dataForm.clientName" placeholder="必填"></el-input>
      </el-form-item>
      <el-form-item label="客户电话" prop="phone">
        <el-input type="number" v-model="dataForm.phone" placeholder="必填"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-radio-group v-model="dataForm.sex">
          <el-radio label='1'>男</el-radio>
          <el-radio label='2'>女</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="联系地址" prop="address">
        <el-input v-model="dataForm.address" placeholder="客户现居住地址"></el-input>
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
      <el-form-item label="期望签单金额" prop="hopeAmount" class="el-input--mini">
        <el-input type="number" placeholder="选填" v-model="dataForm.hopeAmount">
          <template slot="append">元</template>
        </el-input>
      </el-form-item>
      <el-form-item label="期望签单日" prop="hopeTime">
        <el-date-picker value-format="yyyy-MM-dd HH:mm:ss"
          v-model="dataForm.hopeTime"
          type="datetime"
          placeholder="选择日期时间">
        </el-date-picker>
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
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
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
          clientName: '',
          phone: '',
          sex: '1',
          address: '',
          busType: '',
          busPhase: '',
          roomType: '',
          houseType: '',
          usefulArea: '',
          buidArea: '',
          source: '',
          clientType: '',
          hopeAmount: '',
          hopeTime: '',
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
          ],
          phone: [
            {required: true, message: '客户电话不能为空', trigger: 'blur'}
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
              url: this.$http.adornUrl(`/tx/seaclient/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.clientName = data.seaclient.clientName
                this.dataForm.phone = data.seaclient.phone
                this.dataForm.sex = data.seaclient.sex
                this.dataForm.address = data.seaclient.address
                this.dataForm.busType = data.seaclient.busType
                this.dataForm.busPhase = data.seaclient.busPhase
                this.dataForm.roomType = data.seaclient.roomType
                this.dataForm.houseType = data.seaclient.houseType
                this.dataForm.createMan = data.seaclient.createMan
                this.dataForm.createTime = data.seaclient.createTime
                this.dataForm.usefulArea = data.seaclient.usefulArea
                this.dataForm.buidArea = data.seaclient.buidArea
                this.dataForm.source = data.seaclient.source
                this.dataForm.openSee = data.seaclient.openSee
                this.dataForm.clientType = data.seaclient.clientType
                this.dataForm.receiveCount = data.seaclient.receiveCount
                this.dataForm.escape = data.seaclient.escape
                this.dataForm.hopeAmount = data.seaclient.hopeAmount
                this.dataForm.hopeTime = data.seaclient.hopeTime
                this.dataForm.community = data.seaclient.community
                this.dataForm.roof = data.seaclient.roof
                this.dataForm.unit = data.seaclient.unit
                this.dataForm.doorplate = data.seaclient.doorplate
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
              url: this.$http.adornUrl(`/tx/seaclient/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'clientName': this.dataForm.clientName,
                'phone': this.dataForm.phone,
                'sex': this.dataForm.sex,
                'address': this.dataForm.address,
                'busType': this.dataForm.busType,
                'busPhase': this.dataForm.busPhase,
                'roomType': this.dataForm.roomType,
                'houseType': this.dataForm.houseType,
                'createMan': this.dataForm.createMan,
                'createTime': this.dataForm.createTime,
                'usefulArea': this.dataForm.usefulArea,
                'buidArea': this.dataForm.buidArea,
                'source': this.dataForm.source,
                'openSee': this.dataForm.openSee,
                'clientType': this.dataForm.clientType,
                'receiveCount': this.dataForm.receiveCount,
                'escape': this.dataForm.escape,
                'hopeAmount': this.dataForm.hopeAmount,
                'hopeTime': this.dataForm.hopeTime,
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
