import {treeDataTranslate} from '@/utils/index'

export default {
  data () {
    return {
      dataForm: {
        key: ''
      },
      dataList: [],
      dataListLoading: false,
      singleSelect: {
        name: '',
        id: ''
      },
      addOrUpdateVisible: false,
      defaultProps: {
        children: 'child',
        label: 'typeName'
      }
    }
  },
  activated () {
    this.getDataList()
  },
  methods: {
    // 获取数据列表
    getDataList () {
      this.dataListLoading = true
      this.$http({
        url: this.$http.adornUrl('/tx/materialtype/list'),
        method: 'get'
      }).then(({data}) => {
        this.dataList = treeDataTranslate(data.list, 'id')
        this.dataListLoading = false
      }).then(() => {
        if (this.dataList.length > 0) {
          this.singleSelect = this.dataList[0]
          this.$refs.materialTypeTree.setCurrentKey(this.dataList[0].id)
          this.$nextTick(() => {
            this.$refs.materiallist.findListByType(this.dataList[0])
          })
        }
      })
    },
    // 单选
    handleNodeClick (val) {
      this.singleSelect = val
      this.$refs.materiallist.findListByType(val)
    },
    // 新增
    addHandle () {
      this.addOrUpdateVisible = true
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(null)
      })
    },
    // 修改
    updateHandle () {
      this.addOrUpdateVisible = true
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(this.singleSelect.id)
      })
    },
    // 删除
    deleteHandle () {
      this.$confirm('确定要删除吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$http({
          url: this.$http.adornUrl('/tx/materialtype/delete'),
          method: 'post',
          data: this.$http.adornData(this.singleSelect.id, false)
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.$message({
              message: '操作成功',
              type: 'success',
              duration: 500,
              onClose: () => {
                this.getDataList()
              }
            })
          } else {
            this.$message.error(data.msg)
          }
        })
      })
    }
  }
}
