```js
/*
 * @Author: xiangyue_li
 * @Date: 2023-07-06 18:30:54
 * @LastEditors: xiangyue_li
 */
//检查是否用new调用
function _checkType(obj,constructor) {
    if(!(obj instanceof constructor)){
        throw  new TypeError("Connot call a class as function")
    }
}
//设置类内部所定义的的方法时不可枚举
function defineProperties(target, descriptors) {
    for(let descriptor of descriptors) {
        descriptor.enumerable = descriptor.enumerable || false  //原本存在的不动,

        descriptor.configurable = true
        if("value" in descriptors){
            descriptor.writable = true
        }
        Object.defineProperty(target,descriptor.key,descriptor)
    }
}
//构造class
/**
 *
 * @param constructor 构造函数
 * @param protoDesc 原型属性,加到原型对象上
 * @param staticDesc 静态属性,加到构造函数上
 * @private
 */
function _createClass(constructor,protoDesc,staticDesc){
    protoDesc && defineProperties(constructor.prototype,protoDesc)
    staticDesc && defineProperties(constructor,staticDesc)
    return constructor
}

const Foo = (function(){
    function Foo(name) {
        _checkType(this,Foo)

        this.name = name
    }
    _createClass(Foo,[
        //表示在class内部定义的方法
        {
            key:'say',
            value:function (){
                console.log(this.name)
            }
        }
    ],[
        //表示class内部定义的静态方法
        {
            key:'say',
            value:function () {
                console.log('static say')
                console.log(this.name)
            }
        }
    ])
    return Foo
})()
const foo = new Foo('aaa')
console.log(Object.getOwnPropertyNames(Foo.prototype))
function _inherits(subClass,superClass) {
    if(typeof superClass !== 'function' && superClass !== null) { //父类必须是函数或者null
        throw new TypeError('Super expression must either be null or a function,not' + typeof superClass)
    }
    subClass.prototype = Object.create(superClass && superClass.prototype,{
        constructor:{
            value:subClass,
            enumerable: false,
            writable:true,
            configurable:true
        }
    })
    if(superClass) {
        Object.setPrototypeOf ? Object.setPrototypeOf(subClass,superClass) : subClass.__proto__ = superClass
    }
}
//返回父类的this,若为null,则返回自身
function _possibleConstructorReturn(self,call) {
    if(!self){
        throw new ReferenceError("this has not been initialised - super() has not been called")
    }
    return call && (typeof call === 'object' || typeof call === 'function') ? call : self
}
const Child = function (_Parent) {
    _inherits(Child,_Parent)

    function Child(name, age) {
        _checkType(this, Child)

        //先使用父类实例对象this,再返回
        const _this = _possibleConstructorReturn(this,(Child.__proto__ || Object.getPrototypeOf(Child).call(this,name)))
        _this.age = age
        return _this
    }
    return Child
}(Foo)
console.log(Foo.say())
console.log(Child.say())

const Child1 = function (_Parent) {
    _inherits(Child,_Parent)

    function Child(name, age) {
        _checkType(this, Child)

        const _this = _possibleConstructorReturn(this, (Child.__proto__ || Object.getPrototypeOf(Child)).call(this, name))
        _this.age = age
        return _this
    }
    return Child
}(Array)
const c = new Child1('bbb', 12)
console.log(c)
```

https://segmentfault.com/a/1190000037740981

