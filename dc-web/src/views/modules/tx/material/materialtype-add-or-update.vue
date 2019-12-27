<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form  :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="上级分类" prop="parentId">
        <el-popover
          ref="materialTypeListPopover"
          placement="bottom-start"
          trigger="click">
          <el-tree
            clearable
            :data="dataList"
            :props="materialTypeListTreeProps"
            node-key="typeId"
            ref="materialTypeListTree"
            @current-change="materialTypeListTreeCurrentChangeHandle"
            :default-expand-all="true"
            :highlight-current="true"
            :expand-on-click-node="false">
          </el-tree>
        </el-popover>
        <el-input v-model="dataForm.parentName" v-popover:materialTypeListPopover :readonly="true" placeholder="点击选择分类" class="menu-list__input"></el-input>
      </el-form-item>
      <el-form-item label="分类名称" prop="typeName">
        <el-input v-model="dataForm.typeName" placeholder="分类名称"></el-input>
      </el-form-item>
      <el-form-item label="分类编码" prop="typeCode">
        <el-input v-model="dataForm.typeCode" placeholder="选填"></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button  @click="visible = false">取消</el-button>
      <el-button  type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  import {treeDataTranslate} from '@/utils/index'

  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          parentId: '',
          typeName: '',
          typeCode: '',
          parentName: ''
        },
        dataRule: {
          typeName: [
            {required: true, message: '分类名称不能为空', trigger: 'blur'}
          ]
        },
        materialTypeListTreeProps: {
          label: 'typeName',
          children: 'child'
        },
        dataList: []
      }
    },
    methods: {
      // 菜单树选中
      materialTypeListTreeCurrentChangeHandle (data, node) {
        this.dataForm.parentId = data.id
        this.dataForm.parentName = data.typeName
      },
      // 菜单树设置当前选中节点
      materialTypeListTreeSetCurrentNode () {
        this.$refs.materialTypeListTree.setCurrentKey(this.dataForm.parentId)
        this.dataForm.parentName = (this.$refs.materialTypeListTree.getCurrentNode() || {})['name']
      },
      init (id) {
        this.dataForm.id = id
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          this.$http({
            url: this.$http.adornUrl('/tx/materialtype/list'),
            method: 'get'
          }).then(({data}) => {
            this.dataList = treeDataTranslate(data.list, 'id')
            this.dataListLoading = false
          }).then(() => {
            if (this.dataForm.id) {
              this.$http({
                url: this.$http.adornUrl(`/tx/materialtype/info/${this.dataForm.id}`),
                method: 'get',
                params: this.$http.adornParams()
              }).then(({data}) => {
                if (data && data.code === 0) {
                  this.dataForm.parentId = data.materialType.parentId
                  this.dataForm.typeName = data.materialType.typeName
                  this.dataForm.typeCode = data.materialType.typeCode
                  this.dataForm.parentName = data.materialType.parentName
                }
              }).then(() => {
                if (this.dataForm.deptId != null) {
                  this.materialTypeListTreeSetCurrentNode()
                }
              })
            } else {
              this.dataForm.parentName = ''
              this.dataForm.parentId = ''
            }
          })
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/tx/materialtype/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'parentId': this.dataForm.parentId,
                'typeName': this.dataForm.typeName,
                'typeCode': this.dataForm.typeCode
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
