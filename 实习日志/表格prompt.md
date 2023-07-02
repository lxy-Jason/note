我需要完成一个表格组件,我会提供表格的配置信息,需要你按照我给出的规则,给出对应的代码

规则:

1. 按照我给出的模板代码仿写

```vue
<template>
<div>
<p-table
:total="total"
:currentPage.sync="currentPage"
:pageSize.sync="pageSize"
:tableTitleData="tableTitleData"
:tableData="tableData"
>
</p-table>
</div>
</template>

<script>
export default {
data() {
return {
tableData: [
{
date: '2016-05-02',
name: '王小虎',
address: '上海市普陀区金沙江路 1518 弄',
},
{
date: '2016-05-04',
name: '王小虎',
address: '上海市普陀区金沙江路 1517 弄',
},
],
tableTitleData: [
{ prop: 'date', label: '日期',width:111 },
{ prop: 'name', label: '姓名' },
{ prop: 'address', label: '地址' },
],
currentPage: 1,
pageSize: 10,
total: 12,
}
},
}
</script>
```

2. tableTitleData中都是表格的配置字段,label是字段名,prop是字段名对应的数据名,一般情况需要你根据字段名翻译成英文当做数据名,每一行输入代表一个字段的配置内容,例如:`字段名:日期,width:111`代表`{ prop: 'date', label: '日期',width:111 },`
3. 输出的代码必须严格按照我给出的配置信息来,如果配置信息中没有出现对应的文字就不需要给出代码
4. 如果我提供的配置信息中出现`插槽`,需要在tableTitleData中对应的对象中用`slotname`字段代替`prop`字段,例如字段名:`日期,width:111,插槽`代表`{ slotname: 'date', label: '日期',width:111 }`,并且需要给p-table元素添加一个子元素,例如:

```vue
 <template #date="{ scope }">
    <div>{{ scope.row.date }}</div>
 </template>
```

5. 你需要根据tableTitleData中提供的配置信息给出mock数据,放在tableData中
6. 配置信息中出现`排序`两个字时,需要在tableTitleData中对应的对象中添加`sortable: true`,例如`字段名:日期,width:111,排序`代表`{ prop: 'date', label: '日期',width:111,sortable: true }`,如果没有出现不需要添加,例如`字段名:日期,width:111`代表`{ prop: 'date', label: '日期',width:111}`
7. 配置信息中出现`自定义排序`时,需要在tableTitleData中对应的对象中添加`sortable: 'custom'`的同时,给p-table添加`sort-change`事件,并且在methods中添加`sortChange`方法但是不需要在方法中写任何代码,例如

```
{ prop: 'date', label: '日期',width:111,sortable: 'custom' }
<p-table :tableTitleData="tableTitleData" :tableData="tableData" @sort-change="sortChange"></p-table>
sortChange(val) {},
```

8. 配置中出现`筛选`时,需要在tableTitleData中对应的对象中添加`filter:true,filterList:[]`,例如,`字段名:性质,width:110,筛选`代表`    { prop: 'nature', label: '性质', width: 110 ,filter:true,filterList:[{ value: 1, label: 'test1' },{ value: 2, label: 'test2' }]},`,并且需要给p-table添加`filter-change`事件,并且在methods中添加`filterChange`方法,例如

```
 <p-table
      :tableTitleData="tableTitleData"
      :tableData="tableData"
      @filter-change="filterChange"
    ></p-table>
    filterChange(val,node) {
        console.log('选中值==', val)
        console.log('选中节点==', node)
      },
```

接下来我会在聊天框中提供表格的配置信息,请回复收到



