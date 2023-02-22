### 虽然是文本提示框,但是可以用插槽放元素

```vue
<el-tooltip
              v-if="scope.row.standardType === '电子信息领域标准'"
              placement="top"
              effect="light tooltip" //两种默认主题,如果不行,在这里添加class也可以生效
            >
              <el-tag
                class="tag"
                :type="typeChoice(scope.row.standardType)"
                :class="
                  scope.row.standardType === '电子信息领域标准'
                    ? 'tagColor'
                    : ''
                "
                size="medium"
              >
                {{ scope.row.standardType }}
              </el-tag>
              <div slot="content"> //这里
                <el-tag
                  :type="typeChoice(scope.row.standardType)"
                  :class="
                    scope.row.standardType === '电子信息领域标准'
                      ? 'tagColor'
                      : ''
                  "
                  size="medium"
                >
                  {{ scope.row.standardType }}
                </el-tag>
              </div>
            </el-tooltip>
```

**修改样式的最重要的一点是style里面不要加`scoped`**

```vue
<style>
.tooltip {
  border: 0 !important;
  box-shadow: 0 4px 10px 0 rgba(26, 28, 36, 0.1);
}
.tooltip.is-light[x-placement^='top'] .popper__arrow {
  border-top-color: #fff !important;
}
.tooltip.is-light[x-placement^='bottom'] .popper__arrow {
  border-bottom-color: #fff !important;
}
</style>
```

默认样式中小三角有两层,第一层是`.popper__arrow`

第二层是`.popper__arrow`的affer伪元素

两者是层叠的状态,light主题下有个黑边框就是`.popper__arrow`的border的color

