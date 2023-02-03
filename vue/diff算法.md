### 为什么需要diff算法

渲染真实DOM的开销大,如果没有diff算法,那么我们更新数据时,就会导致整个DOM树的重排和重绘

使用diff算法,将DOM的更新具体到使用这个数据的DOM元素,这样可以减少很多渲染

### virtual DOM和真实DOM的区别

virtual DOM是将真实DOM的数据抽取出来,以对象的形式模拟树型结构

diff的过程就是调用名为`patch`的函数,比较新旧节点,一边比较一边给真实DOM打补丁

### diff比较的方式

diff算法比较新旧节点时,比较只会在同层级进行,不会跨层级比较

### 具体分析

```js
function patch (oldVnode, vnode) {
    // some code
    if (sameVnode(oldVnode, vnode)) {
    	patchVnode(oldVnode, vnode)
    } else {
    	const oEl = oldVnode.el // 当前oldVnode对应的真实元素节点
    	let parentEle = api.parentNode(oEl)  // 父元素
    	createEle(vnode)  // 根据Vnode生成新元素
    	if (parentEle !== null) {
            api.insertBefore(parentEle, vnode.el, api.nextSibling(oEl)) // 将新元素添加进父元素
            api.removeChild(parentEle, oldVnode.el)  // 移除以前的旧元素节点
            oldVnode = null
    	}
    }
    // some code 
    return vnode
}
function sameVnode (a, b) {
  return (
    a.key === b.key &&  // key值
    a.tag === b.tag &&  // 标签名
    a.isComment === b.isComment &&  // 是否为注释节点
    // 是否都定义了data，data包含一些具体信息，例如onclick , style
    isDef(a.data) === isDef(b.data) &&  
    sameInputType(a, b) // 当标签是<input>的时候，type必须相同
  )
}
```

patch函数接收两个参数oldVnode和Vnode

首先sameVnode()方法判断这两个是不是同一节点,这里要判断**`key`值,标签名,是否是注释节点,是否定义了data,如果是input标签,type必须相同**

满足这些要求就进行子节点的比较

如果不满足,直接用Vnode替换oldVnode

#### patchVnode

```js
patchVnode (oldVnode, vnode) {
    const el = vnode.el = oldVnode.el //真实dom
    let i, oldCh = oldVnode.children, ch = vnode.children
    if (oldVnode === vnode) return 
    if (oldVnode.text !== null && vnode.text !== null && oldVnode.text !== vnode.text) {
        api.setTextContent(el, vnode.text)
    }else {
        updateEle(el, vnode, oldVnode)
    	if (oldCh && ch && oldCh !== ch) {
            updateChildren(el, oldCh, ch)
    	}else if (ch){
            createEle(vnode) //create el's children dom
    	}else if (oldCh){
            api.removeChildren(el)
    	}
    }
}
```

- 找到真实DOM,就是el
- 判断Vnode和oldVnode是否指向同一个对象,如果是,直接return
- 如果是文本节点并且不相等,直接替换
- 如果两者都有子节点,执行updateChildren函数比较子节点
- 如果Vnode有子节点,oldVnode没有,将其子节点真实化之后添加到el
- 如果oldVnode有子节点,vNode没有,直接删除el的子节点

#### updateChildren

这里就是进行子节点比较,目的是尽可能复用之前的DOM

这里采用双指针的方式进行四种方式的比较,如果有key值,就会根据key进行比较