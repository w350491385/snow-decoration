<template>
  <el-popover
    ref="listPopover"
    placement="bottom-start"
    trigger="click">
    <el-tree
      clearable
      :data="dataList"
      :props="listTreeProps"
      :node-key="nodeKey"
      ref="listTree"
      @current-change="listTreeCurrentChangeHandle"
      :default-expand-all="true"
      :highlight-current="true"
      :expand-on-click-node="false">
    </el-tree>
  </el-popover>
  <el-input v-model="value" v-popover:listPopover :readonly="true" :placeholder="placeholder" @focus="focusHandler" class="menu-list__input"></el-input>
</template>

<script>
  import {treeDataTranslate} from '@/utils'

  export default {
    name: 'treeSelect',
    props: {
      currentChangeHandle: {
        type: Function
      },
      setCurrentNode: {
        type: Function
      },
      dataList: [],
      placeholder: {
        type: String,
        default: ''
      },
      value: {
        type: String,
        default: ''
      },
      nodeKey: {
        type: String,
        default: 'id'
      }
    },
    data () {
      return {
        listTreeProps: {
          label: 'typeName',
          children: 'child'
        }
      }
    },
    methods: {
      async focusHandler () {
        this.$nextTick(() => {
          this.dataList = treeDataTranslate(this.dataList, this.nodeKey)
        })
      },
      // 菜单树选中
      listTreeCurrentChangeHandle (data, node) {
        this.currentChangeHandle(data, node)
      },
      // 菜单树设置当前选中节点
      listTreeSetCurrentNode (key, labelName) {
        this.$refs.listTree.setCurrentKey(key)
        this.value = (this.$refs.listTree.getCurrentNode() || {})[labelName]
      }
    }
  }
</script>

<style scoped>

</style>
