```javascript
<template>
  <div>
    <el-select v-model="value" class="autoWidth" placeholder="集成电路">
      <template slot="prefix">
        {{ (industrys.find(item => item.emergingIndustryName === value) || {}).emergingIndustryName }}
      </template>
      <el-option
        v-for="item in industrys"
        :key="item.emergingIndustryCode"
        :value="item.emergingIndustryName"
      />
    </el-select>
  </div>
</template>

<script>
export default {
  props: {
    industrys: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      value: '集成电路'
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep {
  .el-input__inner {
    border: none;
    font-size: 32px;
    font-weight: 500;
    color: #333333;
  }
  .autoWidth {
    min-width: 120px; //设置最小的宽度
    text-align: start; // 这里是个坑，由于我是在vue中挂载的页面，如果给app的样式设置了text-align：center后，这里是需要重新设置start 否则选择框内的内容是默认居中，会造成未选择内容和选择内容时样式不对
  }
  .autoWidth .el-input__prefix {
    // 这里直接时复制原来的input的样式，给.el-input__prefix加上
    position: relative;
    box-sizing: border-box;
    height: 40px;
    left: 0;
    font-size: 32px;
    font-weight: 500;
    color: #333333;
    padding-right:30px;
  }
  .autoWidth .el-input__inner {
    position: absolute; //这里一定需要给，给内容进行定位
    padding-left: 0;
    visibility: hidden;

  }
}
</style>

```
