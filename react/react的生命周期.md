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

https://tsejx.github.io/react-guidebook/foundation/main-concepts/lifecycle/#constructor

 