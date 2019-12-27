<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="分类名称：" prop="typeName">
        <span>{{typeName}}</span>
      </el-form-item>
      <el-form-item label="项目名称：" prop="name">
        <el-input v-model="dataForm.name" placeholder="项目名称"></el-input>
      </el-form-item>
      <el-form-item label="工种：" prop="workType">
        <el-select v-model="dataForm.workType" placeholder="请选择">
          <el-option
            v-for="item in workTypeList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>
        <el-button type="text" @click="routerDict">配置可选项</el-button>
      </el-form-item>
      <el-form-item label="计量单位：" prop="unit">
        <el-input v-model="dataForm.unit" placeholder="如m,㎡等"></el-input>
      </el-form-item>
      <el-form-item label="人工成本：" prop="humanCost">
        <el-input style="width: 40%" type="number" v-model="dataForm.humanCost" @blur="countAmount">
          <template slot="append">元</template>
        </el-input>
        <el-tag type="info">最多精确到小数点后两位</el-tag>
      </el-form-item>
      <el-form-item label="辅材成本：" prop="helpCost">
        <el-input style="width: 40%" type="number" v-model="dataForm.helpCost" @blur="countAmount">
          <template slot="append">元</template>
        </el-input>
        <el-tag type="info">最多精确到小数点后两位</el-tag>
      </el-form-item>
      <el-form-item label="综合成本：" prop="totalCost">
        <el-input type="number" v-model="dataForm.totalCost" style="width: 40%" @blur="countTotalPrice">
          <template slot="append">元</template>
        </el-input>
        <el-tag type="info">综合成本 = 人工成本 + 辅材成本 + 其他成本</el-tag>
      </el-form-item>
      <el-form-item label="利润率：" prop="profit">
        <el-input type="number" style="width: 40%" v-model="dataForm.profit" @blur="countAmount">
          <template slot="append">%</template>
        </el-input>
      </el-form-item>
      <el-form-item label="综合价：" prop="totalPrice">
        <el-input style="width: 40%" type="number" v-model="dataForm.totalPrice">
          <template slot="append">元</template>
        </el-input>
        <el-tag type="info">综合价 = 综合成本 x (1+利润率)</el-tag>
      </el-form-item>
      <el-form-item label="是否启用：" prop="ifOn">
        <el-radio-group v-model="dataForm.ifOn">
          <el-radio :label=true>是</el-radio>
          <el-radio :label=false>否</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="说明：" prop="unit">
        <el-input type="textarea" v-model="dataForm.remark" placeholder="主材及辅料规格,品牌和工艺"></el-input>
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
          typeId: '',
          name: '',
          workType: '',
          unit: '',
          totalPrice: 0,
          superCode: '',
          totalCost: 0,
          humanCost: 0,
          helpCost: 0,
          ifOn: true,
          ifEditble: true,
          profit: 20,
          remark: ''
        },
        typeName: '',
        workTypeList: [],
        dataRule: {
          name: [
            {required: true, message: '项目名称不能为空', trigger: 'blur'}
          ],
          workType: [
            {required: true, message: '工种不能为空', trigger: 'blur'}
          ],
          totalPrice: [
            {required: true, message: '综合价不能为空', trigger: 'blur'}
          ],
          totalCost: [
            {required: true, message: '综合成本不能为空', trigger: 'blur'}
          ],
          humanCost: [
            {required: true, message: '人工成本不能为空', trigger: 'blur'}
          ],
          helpCost: [
            {required: true, message: '辅材成本不能为空', trigger: 'blur'}
          ],
          ifOn: [
            {required: true, message: '是否启用不能为空', trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      // 计价
      countAmount () {
        this.dataForm.totalCost = +this.dataForm.humanCost + +this.dataForm.helpCost
        this.dataForm.totalPrice = +this.dataForm.totalCost * ((this.dataForm.profit * 0.01) + 1)
      },
      countTotalPrice () {
        this.dataForm.totalPrice = +this.dataForm.totalCost * ((this.dataForm.profit * 0.01) + 1)
      },
      routerDict () {
        this.visible = false
        this.$router.push({name: 'sys-dict'})
        this.$message.info('请选择[工种]分类进行配置')
      },
      init (id, val) {
        this.dataForm.id = id || 0
        this.dataForm.typeId = val.typeId
        this.typeName = val.typeName
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          Public.findDictByType.r({typeId: 1026}).then((res) => {
            this.workTypeList = res.data.list
          }).then(() => {
            if (this.dataForm.id) {
              this.$http({
                url: this.$http.adornUrl(`/tx/project/info/${this.dataForm.id}`),
                method: 'get',
                params: this.$http.adornParams()
              }).then(({data}) => {
                if (data && data.code === 0) {
                  this.dataForm = data.project
                }
              })
            }
          })
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/tx/project/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'typeId': this.dataForm.typeId,
                'name': this.dataForm.name,
                'workType': this.dataForm.workType,
                'unit': this.dataForm.unit,
                'totalPrice': this.dataForm.totalPrice,
                'superCode': this.dataForm.superCode,
                'totalCost': this.dataForm.totalCost,
                'humanCost': this.dataForm.humanCost,
                'helpCost': this.dataForm.helpCost,
                'ifOn': this.dataForm.ifOn,
                'ifEditble': this.dataForm.ifEditble,
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
