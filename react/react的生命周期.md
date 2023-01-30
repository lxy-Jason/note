生命周期指react组件从装载至卸载的全过程,这个过程内置多个函数供开发者在组件的不同阶段执行需要的逻辑

状态组件主要通过 3 个生命周期阶段来管理，分别是 装载阶段（`MOUNTING`），更新阶段（`UPDATING`）和卸载阶段（`UNMOUNT`）。

- 装载阶段 Mounting
  - [`constructor`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#constructor)
  - [`static getDerivedStateFromProps`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#static-getderivedstatefromprops)
  - ⚠️ [`UNSAFE_componentWillMount`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#unsafe_componentwillmount)
  - [`render`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#render)
  - [`componentDidMount`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#componentdidmount)
- 更新阶段 Updating
  - ⚠️ [`UNSAFE_componentWillReceiveProps`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#unsafe_componentwillreceiveprops)
  - [`static getDerivedStateFromProps`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#unsafe_componentwillreceivepropsnextprops)
  - [`shouldComponentUpdate`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#shouldcomponentupdate)
  - ⚠️ [`UNSAFE_componentWillUpdate`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#unsafe_componentwillupdate)
  - `render`
  - [`getSnapshotBeforeUpdate`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#getsnapshotbeforeupdate)
  - [`componentDidUpdate`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#componentdidupdate)
- 卸载阶段 Unmounting
  - [`componentWillUnmount`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#componentwillunmount)
- 捕捉错误 Error Handling
  - [`static getDerivedStateFromError`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#static-getderivedstatefromerror)
  - [`componentDidCatch`](https://tsejx.github.io/react-guidebook//foundation/main-concepts/lifecycle#componentdidcatch)

从纵向划分，可以划分为 Render 阶段和 Commit 阶段。

- Render阶段: 纯净且不包含副作用,可能会被React暂停,中止或重新启动
- Commit阶段: 可以使用DOM,运行副作用,安排更新

![React Lifecycle Methods Diagram](image/react-lifecycle-methods-diagram.ae211f59-16748194291463.jpg)

 ### 装载阶段

组件的渲染并且构造DOM元素插入到页面的过程称为组件的装载

装载阶段执行的函数会在组件实例被创建和插入DOM中时被触发,这个过程主要实现组件状态的初始化

### constructor

**语法**：`constructor(props, context, updater)`

- props : 继承React.Component的属性和方法,它是不可变的read-only
- context : 全局上下文
- updater : 包含一些更新方法的对象
  - `this.setState` 最终调用的是 `this.updater.enqueueSetState`
  - `this.forceUpdate` 最终调用的是 `this.updater.enqueueForceUpdate` 方法，所以这些 API 更多是 React 调用使用，暴露出来以备开发者不时之需。

**触发时机 : 组件初始化时触发一次**

**使用场景** : 

- 设置初始化状态,因为这个是第一个调用的,所以在这里初始化之后,其他地方都能用
- 绑定成员函数上下文引用: 
  - 在ES6语法下,类的每个成员函数在执行时的`this`并不是和类实例自动绑定的
  - 而在构造函数中的`this`就是当前组件实例,所以,为了方便将来调用,往往在构造函数中将这个实例的特定函数绑定`this`为当前类实例
  - 建议定义函数方法时直接使用箭头函数,就无需在构造函数中进行函数的bind操作

在 ES6 中，在构造函数中通过 `this.state` 赋值完成状态初始化；通过给类属性（注意是类属性，而不是类实例对象的属性）`defaultProps` 赋值指定的 `props` 初始值。

```react  
class Sample extends React.Component {
  constructor(props, context, updater) {
    super(props);
    this.state = {
      foo: 'InitailValue',
    };
  }
}

Sample.defaultProps = {
  bar: 'InitialValue',
};
```

### 更新阶段

### shouldComponentupdate

语法: `shouldComponentUpdate(nextProps, nextState)`

触发时机: 每次组件因为`state`和`props`变化而更新时,在重新渲染前该生命周期函数都会触发,让React知道当前state或者props的改变是否影响组件的渲染

返回一个布尔值,true继续渲染组件,false不渲染,默认是true

#### 使用建议:

- 可以用来优化渲染效率,提高性能
- 使用 `React.PureComponent` 组件基类能自动实现一个 `shouldComponentUpdate` 生命周期钩子，可以默认为组件更新校验，但是只会对更新数据进行浅层对照；
- 在对 `this.props` 和 `nextProps` 以及 `this.state` 和 `nextState` 进行比较时需要注意引用类型的坑；
- 通常用于条件渲染，优化渲染的性能。

#### 注意事项

- 此钩子函数在初始化渲染和使用了 `forceUpdate` 方法的情况下不会被触发，使用 `forceUpdate` 会强制更新
- 请勿在此函数中使用 `setState` 方法，会导致循环调用。

https://tsejx.github.io/react-guidebook/foundation/main-concepts/lifecycle/#constructor













