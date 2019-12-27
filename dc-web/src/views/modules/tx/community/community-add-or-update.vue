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
    font-family: "微软雅黑";
    border: 1px solid rgb(223, 224, 228);
  }
</style>
<template>
  <el-row>
    <el-dialog
      :title="!dataForm.id ? '新增' : '修改'"
      :close-on-click-modal="false"
      :visible.sync="visible">
      <el-form  :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
        <el-form-item label="小区行政编码：" prop="regionCode">
          <el-input type="number" v-model="dataForm.regionCode" placeholder="小区行政编码"></el-input>
        </el-form-item>
        <el-form-item label="小区名称：" prop="name">
          <el-input v-model="dataForm.name" placeholder="小区名称"></el-input>
        </el-form-item>
        <el-form-item label="经纬度：" prop="lgt">
          <el-input v-model="location" placeholder="经纬度" @focus="openMap"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
      <el-button  @click="visible = false">取消</el-button>
      <el-button  type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
    </el-dialog>
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
          regionCode: '',
          name: '',
          lgt: '',
          lat: ''
        },
        dataRule: {
          regionCode: [
            { required: true, message: '小区行政编码不能为空', trigger: 'blur' }
          ],
          name: [
            { required: true, message: '小区名称不能为空', trigger: 'blur' }
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
      init (id) {
        this.location = ''
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/tx/community/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.regionCode = data.community.regionCode
                this.dataForm.name = data.community.name
                this.dataForm.lgt = data.community.lgt
                this.dataForm.lat = data.community.lat

                // 注释经纬度
                this.userlocation.lgt = data.community.lgt
                this.userlocation.lat = data.community.lat
                this.location = `经度${this.dataForm.lgt}，纬度${this.dataForm.lat}`
                this.info = {
                  lng: Number(this.dataForm.lgt),
                  lat: Number(this.dataForm.lat)
                }
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
              url: this.$http.adornUrl(`/tx/community/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'regionCode': this.dataForm.regionCode,
                'name': this.dataForm.name,
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
          position: point,    // 指定文本标注所在的地理位置
          offset: new BMap.Size(30, -30)    //  设置文本偏移量
        }
        var label = new BMap.Label(`经度${e.point.lng}，纬度${e.point.lat}`, opts)  // 创建文本标注对象
        label.setStyle({
          borderColor: '#1e65ca',
          color: '#1e65ca',
          fontSize: '14px',
          height: '20px',
          lineHeight: '20px',
          fontFamily: '微软雅黑'
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
          var ac = new BMap.Autocomplete(    // 建立一个自动完成的对象
            {
              'input': 'suggestId',
              'location': this.map
            })
          var myValue
          this.ac = ac
          ac.addEventListener('onconfirm', function (e) {    // 鼠标点击下拉列表后的事件
            var _value = e.item.value
            myValue = _value.province + _value.city + _value.district + _value.street + _value.business
            vm.setPlace(myValue)
          })
          if (!this.map) {
            this.$nextTick(() => {
              this.map = new BMap.Map('allmap')
              // 初始化地图,设置中心点坐标，
              this.$nextTick(() => {
                var point = new BMap.Point(121.160724, 31.173277) // 创建点坐标，汉得公司的经纬度坐标
                this.map.centerAndZoom(point, 15)
                this.map.enableScrollWheelZoom()
                if (this.info) {
                  this.map.clearOverlays()
                  point = new BMap.Point(this.info.lng, this.info.lat)
                  var marker = new BMap.Marker(point)
                  this.map.centerAndZoom(point, 15)
                  this.map.addOverlay(marker)
                  var opts = {
                    position: point,    // 指定文本标注所在的地理位置
                    offset: new BMap.Size(30, -30)    // 设置文本偏移量
                  }
                  var label = new BMap.Label(`经度${this.info.lng}，纬度${this.info.lat}`, opts)  // 创建文本标注对象
                  label.setStyle({
                    borderColor: '#1e65ca',
                    color: '#1e65ca',
                    fontSize: '14px',
                    height: '20px',
                    lineHeight: '20px',
                    fontFamily: '微软雅黑'
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
                  position: point,    // 指定文本标注所在的地理位置
                  offset: new BMap.Size(30, -30)    //  设置文本偏移量
                }
                var label = new BMap.Label(`经度${this.info.lng}，纬度${this.info.lat}`, opts)  // 创建文本标注对象
                label.setStyle({
                  borderColor: '#1e65ca',
                  color: '#1e65ca',
                  fontSize: '14px',
                  height: '20px',
                  lineHeight: '20px',
                  fontFamily: '微软雅黑'
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
        this.map.clearOverlays()    //  清除地图上所有覆盖物
        this.local = new BMap.LocalSearch(vm.map, { //  智能搜索
          onSearchComplete: this.myFun
        })
        this.local.search(myValue)
      },
      myFun () {
        var a = this.local.getResults().getPoi(0).point    // 获取第一个智能搜索的结果
        this.info = a
        this.map.centerAndZoom(this.info, 15)
        this.map.addOverlay(new BMap.Marker(this.info))    // 添加标注
        var point = new BMap.Point(a.lng, a.lat)
        var opts = {
          position: point,    // 指定文本标注所在的地理位置
          offset: new BMap.Size(30, -30)    // 设置文本偏移量
        }
        var label = new BMap.Label(`经度${a.lng}，纬度${a.lat}`, opts)  // 创建文本标注对象
        label.setStyle({
          borderColor: '#1e65ca',
          color: '#1e65ca',
          fontSize: '14px',
          height: '20px',
          lineHeight: '20px',
          fontFamily: '微软雅黑'
        })
        this.map.addOverlay(label)
      }
    }
  }
</script>
