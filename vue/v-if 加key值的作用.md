在diff算法比较新老vnode时,用来判断dom是否可以复用

在sameVnode()中会比较两者的key值,如果key值相同才有可能继续比较子节点

如果key值不同,说明不是同一DOM了,直接用新的替换老的

还有就是子节点比较时,有key时,是以key值来做比较

根据oldChild的key生成一张hash表,用新的key来做比较匹配

如果匹配上再判断是不是sameVnode,是的,就可以直接复用

如果没有key值,就得用双指针做四次匹配