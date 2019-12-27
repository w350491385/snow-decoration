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
      <el-col :span="5" :height="this.$store.state.common.documentClientHeight-162">
        <el-card :body-style="siteContentViewHeight">
          <div slot="header" class="clearfix">
            <span style="font-weight: 700">施工项分类</span>
            <el-button type="primary"  icon="el-icon-plus" circle plain @click="addHandle"></el-button>
          </div>
          <el-tree node-key="id" ref="projectTypeTree" highlight-current :data="this.dataList" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-card>
      </el-col>
      <el-col :span="19">
        <el-row style="background-color: #f1eff0;height: 36.2px;line-height: 36.2px">
          <el-col :span="20">
            <el-tag size="midle" type="info" style="margin-left: 20px;font-weight: 600" v-if="singleSelect.id != null">{{singleSelect.name}}</el-tag>
            <el-button style="margin-left: 15px"  v-if="isAuth('tx:projecttype:update') && singleSelect.id" @click="updateHandle()"
                       type="primary"
                       icon="el-icon-edit"
                       circle plain></el-button>
            <el-button  v-if="isAuth('tx:projecttype:delete') && singleSelect.id" type="primary" @click="deleteHandle()"
                       icon="el-icon-delete"
                       circle plain></el-button>
          </el-col>
        </el-row>
        <el-row style="margin-left: 10px;margin-top: 10px;">
          <project ref="projectList"></project>
        </el-row>
      </el-col>
    </el-row>
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import projecttype from '@/js/modules/tx/projecttype'
  import AddOrUpdate from './projecttype-add-or-update'
  import Project from './project'
  import TableTreeColumn from '@/components/table-tree-column/index'

  export default {
    ...projecttype,
    components: {
      AddOrUpdate,
      Project,
      TableTreeColumn
    },
    computed: {
      siteContentViewHeight () {
        var height = this.$store.state.common.documentClientHeight - 160
        return {height: height + 'px', 'overflow-y': 'scroll'}
      }
    }
  }
</script>
