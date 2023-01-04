```javascript
<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <el-radio-group
    v-model="isCollapse"
    size="mini"
    text-color="#0569FF"
    fill="#FFFFFF"
  >
    <el-radio-button :label="false">
      优势环节
    </el-radio-button>
    <el-radio-button :label="true">
      缺失环节
    </el-radio-button>
  </el-radio-group>
</template>

<script>
export default {
  data() {
    return {
      isCollapse: false
    }
  },
  watch: {
    isCollapse() {
      this.$emit('switch', this.isCollapse)
    }
  }
}
</script>

<style lang="scss" scoped>
.el-radio-group {
  position: absolute;
  right: 40px;
  top: 5px;
  padding: 4px;
  background-color: #e6e7eb;
  border-radius: 4px;

  /deep/ .el-radio-button--mini .el-radio-button__inner {
    padding: 4px 8px;
    background-color: #e6e7eb;
    border: none;
    border-radius: 0;
  }
  .el-radio-button__inner {
    background-color: #e6e7eb;
  }
}
</style>

```
