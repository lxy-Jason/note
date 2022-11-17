### 实现一个模块 math，支持链式调用math.add(2,4).minus(3).times(2)

```js
class myMath {
  constructor(initValue = 0) {
    this.value = initValue;
  }
  add(...args){
    this.value = args.reduce((pre,cur) => pre + cur,this.value);
    return this; //这里返回this是重点,这样才能链式调用
  }
  minus(...args){
    this.value = this.value - args.reduce((pre,cur) => pre + cur,0);
    return this;
  }
  times(timer){
    this.value = this.value * timer;
    return this;
  }
  getVal(){
    return this.value;
  }
}
let math = new myMath();
math.add(2,4).minus(3).times(2)
console.log(math.getVal());
```

