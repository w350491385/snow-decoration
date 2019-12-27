<style scoped>
  .el-card__header {
    padding: 5px 20px;
    border-bottom: 1px solid #ebeef5;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    background-color: #f1eff0;
    line-height: 24px;
  }

  .el-button.is-circle {
    border-radius: 50%;
    padding: 6px;
  }
</style>
<template>
  <div class="mod-config">
    <el-row>
      <el-col :span="5">
        <el-card :body-style="siteContentViewHeight">
          <div slot="header" class="clearfix">
            <span style="font-weight: 700">材料分类</span>
            <el-button type="primary"  icon="el-icon-plus" circle plain @click="addHandle"></el-button>
          </div>
          <el-tree ref="materialTypeTree" highlight-current :data="this.dataList" node-key="id" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-card>
      </el-col>
      <el-col :span="19">
        <el-row style="background-color: #f1eff0;height: 36.2px;line-height: 36.2px">
          <el-col :span="20">
            <el-tag  size="midle" type="info" style="margin-left: 20px;font-weight: 600" v-if="singleSelect.id">{{singleSelect.typeName}}</el-tag>
            <el-button style="margin-left: 15px"  v-if="isAuth('tx:materialtype:update') && singleSelect.id" @click="updateHandle()"
                       type="primary"
                       icon="el-icon-edit"
                       circle plain></el-button>
            <el-button  v-if="isAuth('tx:materialtype:delete') && singleSelect.id" type="primary" @click="deleteHandle()"
                       icon="el-icon-delete"
                       circle plain></el-button>
          </el-col>
        </el-row>
        <el-row style="margin-left: 10px;margin-top: 10px;">
          <material ref="materiallist"></material>
        </el-row>
      </el-col>
    </el-row>

    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import materialtype from '@/js/modules/tx/materialtype'
  import Material from '@/views/modules/tx/material/material'
  import AddOrUpdate from '@/views/modules/tx/material/materialtype-add-or-update'
  import TableTreeColumn from '@/components/table-tree-column/index'

  export default {
    ...materialtype,
    components: {
      AddOrUpdate,
      Material,
      TableTreeColumn
    },
    computed: {
      siteContentViewHeight () {
        var height = this.$store.state.common.documentClientHeight - 150
        return {height: height + 'px', 'overflow-y': 'scroll'}
      }
    }
  }
</script>
