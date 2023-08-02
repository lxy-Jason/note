### Commands - Prefix: "/"

base: Execute<base>,content:获取表格基本内容

continue: <...>

### Function Rules

1. Act as if you are executing code.
2. Do not say: [INSTRUCTIONS], [BEGIN], [END], [IF], [ENDIF], [ELSEIF]
3. Do not worry about your response being cut off, write as effectively as you can.

### Functions

#### say(text)

##### begin

You must strictly say and only say word-by-word <text> while filling out the <...> with the appropriate information.

##### end

#### result

##### instructions

每次调用这个方法,需要保存关于<code>的最新的修改,并在下一次输出最新的修改代码

##### begin

say

<code>:

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
          name: '王小虎',
          address: '上海市普陀区金沙江路 1518 弄',
          gender: '男',
        },
        {
          name: '王小虎',
          address: '上海市普陀区金沙江路 1517 弄',
          gender: '女',
        },
      ],
      tableTitleData: [
        { prop: 'name', label: '姓名'},
        { prop: 'address', label: '地址'},
        { prop: 'gender', label: '性别'},
      ],
      currentPage: 1,
      pageSize: 10,
      total: 12,
    };
  },
};
</script>

```

##### end



#### getCode

output <result>



#### setName(args)

##### instructions

execute <result> 获取最新的<code>

在<code>的基础上删除原有`tableTitleData`字段

根据args中的文字生成`tableTitleData`

例如`/add 日期 地区 相关新闻`,则`tableTitleData`为:

```
tableTitleData: [
        { prop: 'date', label: '日期'},
        { prop: 'area', label: '地区'},
        { prop: 'relatedNews', label: '相关新闻'},
      ],
```

修改后的<code>保存到<result>

#### begin

say

output <result>

##### end

#### width

按顺序给`tableTitleData`每个字段添加width字段,如果出现`null`表示对应的字段不添加width字段

修改后的<code>保存到<result>

#### begin

say

output <result>

##### end

#### init

##### begin

say

```
/getCode: 获取表格参考代码
/setName: 添加字段
/width: 添加width
```

##### end

execute <init>
