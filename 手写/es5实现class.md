```js
//检查是否用new调用
function _checkType(obj,constructor){
  if(!(obj instanceof constructor)){
    throw new TypeError("Connot call a class as function")
  }
}
//设置类内部所定义的方法时不可枚举的
function defineProperties (target,descriptors){
  for(let descriptor of descriptors){
    descriptor.enumerable = descriptor.enumerable || false; //原先存在的不动,自己定义的方法没有设置过所以走的false?

    descriptor.configuarable = true;
    if("value" in descriptor){
      descriptor.writable = true;
    }
    Object.defineProperty(target,descriptors.key,descriptor)
  }
}
//构造class
/**
 * 
 * @param {*} constructor 构造函数
 * @param {*} protoDesc  原型属性,加到原型对象上
 * @param {*} staticDesc  静态属性,加到到构造函数上
 */
function _createClass(constructor,protoDesc,staticDesc) {
  protoDesc && defineProperties(constructor.prototype,protoDesc)
  staticDesc && defineProperties(constructor,staticDesc)
  return constructor
}

//真正创建class
const Foo = (function(){
  function Foo(name) {
    _checkType(this,Foo);//先检查是不是new调用的

    this.name = name
  }
  _createClass(Foo,[//表示在class内部定义的方法
    {
      key:'say',
      value:function(){
        console.log(this.name);
      }
    }
  ],[//表示在class内部定义的静态方法
    {
      key:'say',
      value:function(){
        console.log('static say');
        console.log(this.name);
      }
    }
  ])
  return Foo
})();//自调用

const foo = new Foo('aaa')




```

https://segmentfault.com/a/1190000037740981

没学完整