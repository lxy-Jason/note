这个主要是为了更好的复用组件,比如一个组件整体上内容是一样的,但是内部存在某个区域使用了不同的内容

这个时候就可以通过插槽去使用不同的组件

### 默认插槽

子组件中放在`<slot></slot>`标签,父组件中使用子组件,并且在文本区域放置内容时

该内容会显示在子组件slot标签所在的位置

slot标签的文本位置也可放置内容,当父组件没用传递内容时,该内容会显示出来

子组件child.vue

```vue
<template>
    <slot>
      <p>插槽后备的内容</p>
    </slot>
</template>
```

父组件

```vue
<Child>
  <div>默认插槽</div>  
</Child>
```

### 具名插槽

slot标签使用时添加name属性

在父组件中使用子组件并且使用插槽时,在文本区域使用`template`标签并添加`v-slot:<name>`

指定使用哪个slot标签

```vue
<child>
    <template v-slot:default>具名插槽</template>
    <!-- 具名插槽⽤插槽名做参数 -->
    <template v-slot:content>内容...</template>
</child>
```

**注意v-slot属性只能在template标签上使用**

### 作用域插槽

通过slot标签可以自定义属性传递数据

在父组件使用子组件时可以通过v-slot属性值接受数据

```vue
<template> 
  <slot name="footer" testProps="子组件的值">
          <h3>没传footer插槽</h3>
    </slot>
</template>
```

```vue
<child> 
    <!-- 把v-slot的值指定为作⽤域上下⽂对象 -->
    <template v-slot:default="slotProps"> //这里的slotProps可以任取
      来⾃⼦组件数据：{{slotProps.testProps}}
    </template>
    <template #default="slotProps">
      来⾃⼦组件数据：{{slotProps.testProps}}
    </template>
</child>
```

这玩意的应用场景是数据放在父组件中,但通过子组件才知道需要啥数据

通过这个方式,父组件可以拿到数据,并根据数据在slot中渲染指定的内容

### 小结

- `v-slot`属性只能在`<template>`上使用，但在只有默认插槽时可以在组件标签上使用
- 默认插槽名为`default`，可以省略default直接写`v-slot`
- 缩写为`#`时不能不写参数，写成`#default`
- 可以通过解构获取`v-slot={user}`，还可以重命名`v-slot="{user: newName}"`和定义默认值`v-slot="{user = '默认值'}"`