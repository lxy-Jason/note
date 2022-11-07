	## 表单修饰符

主要用于input标签,指令用的最多的就是v-model

- lazy 光标离开标签之后才会把值赋给value,也就是change事件触发后才进行信息同步,一般v-model是input事件触发,每填入一个字符就会触发一次
- trim 过滤用户输入的首尾字符,中间的空格不受影响
- number 将用户输入转为数值型

## 事件修饰符

事件修饰符是对事件捕获以及目标进行了处理

- stop 阻止冒泡事件
- prevent 阻止默认事件
- self 只当`event.target`是自身元素时触发处理函数

​	注意顺序:用 `v-on:click.prevent.self` 会阻止**所有的点击**，而 `v-on:click.self.prevent` 只会阻止对元素自身的点击

- once 只触发一次
- capture 事件触发在捕获阶段,就是从外层开始触发事件

## 鼠标按钮修饰符

- letf 鼠标左键
- right 右键
- middle 中键

## 键盘修饰符

主要是对常用键提供别名

只有按下对应键才能触发事件

- 普通键（enter、tab、delete、space、esc、up...）
- 系统修饰键（ctrl、alt、meta、shift...

