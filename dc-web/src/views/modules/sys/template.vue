<template>
  <div class="mod-config">
    <el-row :gutter="24">
      <el-col :span="6">

      </el-col>
      <el-col :span="17">

      </el-col>
    </el-row>
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="searchList"></add-or-update>
  </div>
</template>

<script>
  export default {
    methods: {
      leftHeight () {
        return `${document.documentElement.clientHeight}` - 165
      }
    }
  }
</script>

<style scoped>

</style>
