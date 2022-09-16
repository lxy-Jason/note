父组件

```vue
<template>
  <div>
    <button @click="changeShow">显示弹框</button>
    <DialogVue header="标题标题" text="内容内容" :dialogShow="dialogShow" @confirm="confirm" @cancel="cancel" @change-show="changeShow" />
  </div>
</template>

<script setup lang="ts">
import DialogVue from './components/Dialog.vue';
import { ref } from 'vue';
const dialogShow = ref(false)
const confirm = () => {
  console.log('confirm');
}
const cancel = () => {
  console.log('cancel');
}
const changeShow = () => {
  dialogShow.value = !dialogShow.value
}
</script>

<style lang="scss" scoped>

</style>
```

dialog组件

```vue
<template>
  <div>
    <div v-show="dialogShow">
      <div>{{ header }}</div>
      <div>{{ text }}</div>
      <div>
        <button @click="confirm">确定</button>
        <button @click="cancel">取消</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  header: {
    type:String,
    default:'标题'
  },
  text: {
    type:String,
    default:'文本'
  },
  dialogShow: {
    type: Boolean,
    default: false
  },
})
const emit = defineEmits(['confirm','cancel','change-show'])
const confirm = () => {
  emit('confirm')
  emit('change-show')
}
const cancel = () => {
  emit('cancel')
  emit('change-show')
}
</script>

<style scoped>

</style>
```

