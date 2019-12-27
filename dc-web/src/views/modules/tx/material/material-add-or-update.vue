<template>
  <div>
    <el-dialog
      :title="!dataForm.id ? '新增' : '修改'"
      :close-on-click-modal="false"
      :visible.sync="visible">
      <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
        <el-form-item label="材料分类" prop="typeId">
          <el-tag type="success">{{dataForm.typeName}}</el-tag>
        </el-form-item>
        <el-form-item label="名称" prop="name">
          <el-input v-model="dataForm.name" placeholder="名称"></el-input>
        </el-form-item>
        <el-form-item label="商品编码" prop="superCode">
          <el-input v-model="dataForm.superCode" placeholder="商品编码"></el-input>
        </el-form-item>
        <el-form-item label="型号" prop="model">
          <el-input v-model="dataForm.model" placeholder="型号"></el-input>
        </el-form-item>
        <el-form-item label="标准单位" prop="unit">
          <el-input v-model="dataForm.unit" placeholder="如m2,m,个 等"></el-input>
        </el-form-item>
        <el-form-item label="品牌" prop="brand">
          <el-select v-model="dataForm.brand" placeholder="请选择">
            <el-option
              v-for="item in brandList"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
          <el-button type="text" @click="routerBrand">配置可选项</el-button>
        </el-form-item>
        <el-form-item label="采购价" prop="pricePurchase">
          <el-input type="number" v-model="dataForm.pricePurchase">
            <template slot="append">元</template>
          </el-input>
        </el-form-item>
        <el-form-item label="销售价" prop="priceSalse">
          <el-input type="number" v-model="dataForm.priceSalse">
            <template slot="append">元</template>
          </el-input>
        </el-form-item>
        <el-form-item label="承包价" prop="priceContract">
          <el-input type="number" v-model="dataForm.priceContract">
            <template slot="append">元</template>
          </el-input>
        </el-form-item>
        <el-form-item label="是否启用" prop="ifOn">
          <el-radio-group v-model="dataForm.ifOn">
            <el-radio :label=true>是</el-radio>
            <el-radio :label=false>否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="房间区域" prop="roomAreaName">
          <el-select v-model="dataForm.roomArea" placeholder="请选择">
            <el-option
              v-for="item in roomAreaList"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
          <el-button type="text" @click="routerDict">配置可选项</el-button>
        </el-form-item>
        <el-form-item label="产地" prop="origin">
          <el-input v-model="dataForm.origin" placeholder="产地"></el-input>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input type="textarea" v-model="dataForm.remark" placeholder="备注"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
      <el-button  @click="visible = false">取消</el-button>
      <el-button  type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
    </el-dialog>
    <!-- 弹窗, 上传文件 -->
    <upload v-if="uploadVisible" ref="upload"></upload>
  </div>
</template>

<script>
  import {treeDataTranslate} from '@/utils/index'
  import Upload from '@/views/modules/oss/oss-upload'
  import * as Public from '@/js/api/public'

  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          typeId: '',
          typeName: '',
          name: '',
          pictureJson: '',
          brand: '',
          brandName: '',
          model: '',
          roomArea: '',
          roomAreaName: '',
          origin: '',
          unit: '',
          pricePurchase: '',
          priceSalse: '',
          priceContract: '',
          superCode: '',
          otherCode: '',
          purchaseUnit: '',
          purchaseCeo: '',
          salseUnit: '',
          salseCeo: '',
          ifOn: true,
          remark: ''
        },
        roomAreaList: [],
        dataRule: {
          typeId: [
            {required: true, message: '分类不能为空', trigger: 'blur'}
          ],
          name: [
            {required: true, message: '名称不能为空', trigger: 'blur'},
            {max: 50, message: '最多50个字', trigger: 'blur'}
          ],
          model: [
            {required: true, message: '型号不能为空', trigger: 'blur'},
            {max: 100, message: '最多100个字', trigger: 'blur'}
          ],
          unit: [
            {required: true, message: '标准单位不能为空', trigger: 'blur'},
            {max: 100, message: '最多32个字', trigger: 'blur'}
          ],
          pricePurchase: [
            {required: true, message: '采购价不能为空', trigger: 'blur'}
          ],
          priceSalse: [
            {required: true, message: '销售价不能为空', trigger: 'blur'}
          ],
          priceContract: [
            {required: true, message: '承包价不能为空', trigger: 'blur'}
          ],
          ifOn: [
            {required: true, message: '是否启用不能为空', trigger: 'blur'}
          ]
        },
        dataList: [],
        brandList: [],
        materialTypeListTreeProps: {
          label: 'name',
          children: 'child'
        },
        uploadVisible: false
      }
    },
    components: {
      Upload,
      Public
    },
    methods: {
      routerDict () {
        this.visible = false
        this.$router.push({name: 'sys-dict'})
        this.$message.info('请选择[房间区域分类]进行配置')
      },
      routerBrand () {
        this.visible = false
        this.$router.push({name: 'tx-brand/brandclass'})
      },
      // 上传文件
      uploadHandle () {
        this.uploadVisible = true
        this.$nextTick(() => {
          this.$refs.upload.init()
        })
      },
      init (id, val) {
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          this.dataForm.brand = ''
          this.dataForm.roomArea = ''
          this.dataForm.id = id
          this.dataForm.typeId = val.typeId
          this.dataForm.typeName = val.typeName
          this.$http({
            url: this.$http.adornUrl('/tx/materialtype/list'),
            method: 'get'
          }).then(({data}) => {
            this.dataList = treeDataTranslate(data, 'id')
          }).then(() => {
            Public.findDictByType.r({typeId: 1002}).then((res) => {
              this.roomAreaList = res.data.list
            }).then(() => {
              this.$http({
                url: this.$http.adornUrl('/tx/brand/listByType'),
                method: 'get',
                params: this.$http.adornParams({
                  'typeId': this.dataForm.typeId
                })
              }).then(({data}) => {
                this.brandList = data.list
              }).then(() => {
                if (this.dataForm.id) {
                  this.$http({
                    url: this.$http.adornUrl(`/tx/material/info/${this.dataForm.id}`),
                    method: 'get',
                    params: this.$http.adornParams()
                  }).then(({data}) => {
                    if (data && data.code === 0) {
                      this.dataForm.typeId = data.material.typeId
                      this.dataForm.name = data.material.name
                      this.dataForm.pictureJson = data.material.pictureJson
                      this.dataForm.brand = data.material.brand
                      this.dataForm.brandName = data.material.brandName
                      this.dataForm.model = data.material.model
                      this.dataForm.roomArea = data.material.roomArea
                      this.dataForm.origin = data.material.origin
                      this.dataForm.unit = data.material.unit
                      this.dataForm.pricePurchase = data.material.pricePurchase
                      this.dataForm.priceSalse = data.material.priceSalse
                      this.dataForm.priceContract = data.material.priceContract
                      this.dataForm.superCode = data.material.superCode
                      this.dataForm.otherCode = data.material.otherCode
                      this.dataForm.purchaseUnit = data.material.purchaseUnit
                      this.dataForm.purchaseCeo = data.material.purchaseCeo
                      this.dataForm.salseUnit = data.material.salseUnit
                      this.dataForm.salseCeo = data.material.salseCeo
                      this.dataForm.ifOn = data.material.ifOn
                      this.dataForm.remark = data.material.remark
                    }
                  })
                }
                this.dataListLoading = false
              })
            })
          })
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/tx/material/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'typeId': this.dataForm.typeId,
                'name': this.dataForm.name,
                'pictureJson': this.dataForm.pictureJson,
                'brand': this.dataForm.brand,
                'model': this.dataForm.model,
                'roomArea': this.dataForm.roomArea,
                'origin': this.dataForm.origin,
                'unit': this.dataForm.unit,
                'pricePurchase': this.dataForm.pricePurchase,
                'priceSalse': this.dataForm.priceSalse,
                'priceContract': this.dataForm.priceContract,
                'superCode': this.dataForm.superCode,
                'otherCode': this.dataForm.otherCode,
                'purchaseUnit': this.dataForm.purchaseUnit,
                'purchaseCeo': this.dataForm.purchaseCeo,
                'salseUnit': this.dataForm.salseUnit,
                'salseCeo': this.dataForm.salseCeo,
                'ifOn': this.dataForm.ifOn,
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
