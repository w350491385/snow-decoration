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
      <el-tag style="margin-left: 50px;margin-right: 50px">{{title=!dataForm.id ? '新增考勤点' : '修改考勤点'}}</el-tag>
      <el-button  @click="back">取消</el-button>
      <el-button  type="primary" @click="dataFormSubmit()">保存</el-button>
    </el-row>
    <el-row style="max-width: 800px">
      <el-form  :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="20%">
        <el-form-item label="考勤点名称：" prop="name">
          <el-input v-model="dataForm.name" placeholder="考勤点名称"></el-input>
        </el-form-item>
        <el-form-item label="考勤点地址：" prop="address">
          <el-input v-model="dataForm.address" placeholder="考勤点地址" @focus="openMap"></el-input>
        </el-form-item>
        <el-form-item label="误差范围(米)：" prop="errorRange">
          <el-input-number style="width: 100%" v-model="dataForm.errorRange"></el-input-number>
        </el-form-item>
        <el-form-item label="上班时间：">
          <el-time-select :picker-options="{start: '00:00',end: '24:00'}"
                          style="width: 100%" v-model="dataForm.startTime" placeholder="上班时间"></el-time-select>
        </el-form-item>
        <el-form-item label="下班时间：">
          <el-time-select :picker-options="{start: '00:00',end: '24:00'}"
                          style="width: 100%" v-model="dataForm.endTime" placeholder="下班时间"></el-time-select>
        </el-form-item>
        <el-form-item label="最早打卡时间：">
          <el-time-select :picker-options="{start: '00:00',end: '24:00'}"
                          style="width: 100%" v-model="dataForm.estartTime" placeholder="最早打卡时"></el-time-select>
        </el-form-item>
        <el-form-item label="最晚打卡时间：">
          <el-time-select :picker-options="{start: '00:00',end: '24:00'}"
                          style="width: 100%" v-model="dataForm.eendTime" placeholder="最晚打卡时"></el-time-select>
        </el-form-item>
      </el-form>
    </el-row>
    <el-dialog title="选取经纬度" :visible.sync="mapShow" width="60%" @open="afterOpen" :close-on-click-modal="false">
      <el-input placeholder="输入地址进行查找" style="width:50%;" size="small" id="suggestId" v-model="suggestId"></el-input>
      <div style="margin: 10px 0;font-size:12px;">提示：若百度地图查找结果精度不够，请使用标记工具手动标记
        <el-button type="primary"  @click="changeTool" style="margin-left: 10px;">{{text}}</el-button>
      </div>
      <div id="allmap">

      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelLoc">取 消</el-button>
        <el-button type="primary" @click="saveLoc">确 定</el-button>
      </span>
    </el-dialog>
  </el-row>
</template>

<script>
  /* global BMap */
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          name: '',
          address: '',
          errorRange: '',
          startTime: '',
          endTime: '',
          applicable: '',
          estartTime: '',
          eendTime: '',
          lgt: '',
          lat: ''
        },
        dataRule: {
          name: [
            {required: true, message: '请选择考勤点位置', trigger: 'blur'}
          ],
          address: [
            {required: true, message: '考勤点地址不能为空', trigger: 'change'}
          ],
          errorRange: [
            {required: true, message: '误差范围不能为空', trigger: 'blur'}
          ],
          startTime: [
            {required: true, message: '上班时间不能为空', trigger: 'blur'}
          ],
          endTime: [
            {required: true, message: '下班时间不能为空', trigger: 'blur'}
          ]
        },
        text: '使用工具',
        suggestId: '',
        mapShow: false,
        map: null,
        ac: null,
        locInfo: {},
        local: null,
        info: null,
        a: null,
        b: null,
        userlocation: {
          lgt: '',
          lat: ''
        },
        location: ''
      }
    },
    methods: {
      back () {
        this.$nextTick(() => {
          this.visible = false
          this.$refs['dataForm'].resetFields()
        })
        this.$emit('back')
      },
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          this.dataForm.startTime = ''
          this.dataForm.endTime = ''
          this.dataForm.estartTime = ''
          this.dataForm.eendTime = ''
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/tx/attendance/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.name = data.attendance.name
                this.dataForm.address = data.attendance.address
                this.dataForm.errorRange = data.attendance.errorRange
                this.dataForm.startTime = data.attendance.startTime
                this.dataForm.endTime = data.attendance.endTime
                this.dataForm.applicable = data.attendance.applicable
                this.dataForm.estartTime = data.attendance.estartTime
                this.dataForm.eendTime = data.attendance.eendTime
                this.dataForm.lgt = data.attendance.lgt
                this.dataForm.lat = data.attendance.lat
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
              url: this.$http.adornUrl(`/tx/attendance/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'name': this.dataForm.name,
                'address': this.dataForm.address,
                'errorRange': this.dataForm.errorRange,
                'startTime': this.dataForm.startTime,
                'endTime': this.dataForm.endTime,
                'applicable': this.dataForm.applicable,
                'estartTime': this.dataForm.estartTime,
                'eendTime': this.dataForm.eendTime,
                'lgt': this.dataForm.lgt,
                'lat': this.dataForm.lat
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
                    this.$emit('back')
                  }
                })
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      },
      // 取消修改
      cancelMod () {
        this.visible = false
        this.$refs['dataForm'].resetFields()
      },
      changeTool () {
        this.suggestId = ''
        this.ac.setInputValue('')
        if (this.text === '使用工具') {
          this.text = '关闭工具'
          this.map.addEventListener('click', this.chooseSpot, false)
        } else {
          this.text = '使用工具'
          this.map.removeEventListener('click', this.chooseSpot, false)
        }
      },
      //  点选
      chooseSpot (e) {
        this.map.clearOverlays()
        var point = new BMap.Point(e.point.lng, e.point.lat)
        var marker = new BMap.Marker(point)
        this.map.addOverlay(marker)
        var opts = {
          // 指定文本标注所在的地理位置
          position: point,
          //  设置文本偏移量
          offset: new BMap.Size(30, -30)
        }
        // 创建文本标注对象
        var label = new BMap.Label(`经度${e.point.lng}，纬度${e.point.lat}`, opts)
        label.setStyle({
          borderColor: '#1e65ca',
          color: '#1e65ca',
          fontSize: '14px',
          height: '20px',
          lineHeight: '20px'
        })
        this.map.addOverlay(label)
        this.info = {
          lng: e.point.lng,
          lat: e.point.lat
        }
      },
      cancelLoc () {
        this.ac.dispose()
        this.$nextTick(() => {
          this.mapShow = false
        })
      },
      saveLoc () {
        this.userlocation.lgt = this.info.lng
        this.userlocation.lat = this.info.lat
        this.location = `经度${this.userlocation.lgt}，纬度${this.userlocation.lat}`
        if (!this.info.address) {
          this.dataForm.address = this.dataForm.name
        } else {
          this.dataForm.address = this.info.address
        }
        this.dataForm.lat = this.info.lat
        this.dataForm.lgt = this.info.lng
        this.ac.dispose()
        this.$nextTick(() => {
          this.mapShow = false
        })
      },
      afterOpen () {
        this.$nextTick(() => {
          let vm = this
          // 建立一个自动完成的对象
          var ac = new BMap.Autocomplete(
            {
              'input': 'suggestId',
              'location': this.map
            })
          var myValue
          this.ac = ac
          // 鼠标点击下拉列表后的事件
          ac.addEventListener('onconfirm', function (e) {
            var _value = e.item.value
            myValue = _value.province + _value.city + _value.district + _value.street + _value.business
            vm.setPlace(myValue)
          })
          if (!this.map) {
            this.$nextTick(() => {
              this.map = new BMap.Map('allmap')
              // 初始化地图,设置中心点坐标，
              this.$nextTick(() => {
                // 创建点坐标，汉得公司的经纬度坐标
                var point = new BMap.Point(121.160724, 31.173277)
                this.map.centerAndZoom(point, 15)
                this.map.enableScrollWheelZoom()
                if (this.info) {
                  this.map.clearOverlays()
                  point = new BMap.Point(this.info.lng, this.info.lat)
                  var marker = new BMap.Marker(point)
                  this.map.centerAndZoom(point, 15)
                  this.map.addOverlay(marker)
                  var opts = {
                    // 指定文本标注所在的地理位置
                    position: point,
                    // 设置文本偏移量
                    offset: new BMap.Size(30, -30)
                  }
                  // 创建文本标注对象
                  var label = new BMap.Label(`经度${this.info.lng}，纬度${this.info.lat}`, opts)
                  label.setStyle({
                    borderColor: '#1e65ca',
                    color: '#1e65ca',
                    fontSize: '14px',
                    height: '20px',
                    lineHeight: '20px'
                  })
                  this.map.addOverlay(label)
                }
              })
            })
          } else {
            if (this.info) {
              this.$nextTick(() => {
                this.map.clearOverlays()
                var point = new BMap.Point(this.info.lng, this.info.lat)
                this.map.centerAndZoom(point, 15)
                var marker = new BMap.Marker(point)
                this.map.addOverlay(marker)
                var opts = {
                  // 指定文本标注所在的地理位置
                  position: point,
                  //  设置文本偏移量
                  offset: new BMap.Size(30, -30)
                }
                // 创建文本标注对象
                var label = new BMap.Label(`${this.info.address}`, opts)
                label.setStyle({
                  borderColor: '#1e65ca',
                  color: '#1e65ca',
                  fontSize: '14px',
                  height: '20px',
                  lineHeight: '20px'
                })
                this.map.addOverlay(label)
                this.map.centerAndZoom(point, 15)
              })
            }
          }
        })
      },
      openMap () {
        this.mapShow = true
      },
      setPlace (myValue) {
        let vm = this
        //  清除地图上所有覆盖物
        this.map.clearOverlays()
        //  智能搜索
        this.local = new BMap.LocalSearch(vm.map, {
          onSearchComplete: this.myFun
        })
        this.local.search(myValue)
      },
      myFun () {
        // 获取第一个智能搜索的结果
        var a = this.local.getResults().getPoi(0)
        this.info = {
          lat: a.point.lat,
          lng: a.point.lng,
          address: a.address
        }
        this.map.centerAndZoom(a.point, 15)
        // 添加标注
        this.map.addOverlay(new BMap.Marker(a.point))
        var point = new BMap.Point(a.point.lng, a.point.lat)
        var opts = {
          // 指定文本标注所在的地理位置
          position: point,
          // 设置文本偏移量
          offset: new BMap.Size(30, -30)
        }
        // 创建文本标注对象
        var label = new BMap.Label(a.address, opts)
        label.setStyle({
          borderColor: '#1e65ca',
          color: '#1e65ca',
          fontSize: '14px',
          height: '20px',
          lineHeight: '20px'
        })
        this.map.addOverlay(label)
      }
    }
  }
</script>
