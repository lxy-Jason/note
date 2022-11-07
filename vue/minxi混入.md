这个的功能就是把组件中相同的部分抽离出来,然后在不同的组件中使用

可以包含data,methods等选项和各种生命周期

### 注意事项

组件存在与minxi对象相同的选项时,组件的选项会覆盖minxi的选项

如果是生命周期的话,会合并成一个数组,先执行minxi中的钩子,再执行组件中的钩子

### 几种合并策略

- 替换型:props,methods,inject,computed同名时会被后来者代替
- 合并型:data
- 队列型:全部的生命周期和watch,合并成一个数组然后正序遍历一遍
- 叠加型:component,directives,filters,通过原型链进行层层叠加?

