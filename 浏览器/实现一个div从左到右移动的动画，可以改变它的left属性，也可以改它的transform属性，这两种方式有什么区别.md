**实现一个div从左到右移动的动画，可以改变它的left属性，也可以改它的transform属性，这两种方式有什么区别**

这个的重点在于`transform`会被浏览器提升为**复合层**

提升到复合层的好处是可以开启GPU加速,性能更好

其他会提升为复合层的条件是:

- 3d transforms: translate3d,translateZ

- video,canvas,iframe等元素

- 通过Element.animate()实现的opacity动画转换

- css实现的opacity动画转换

- position:fixed

- 具有will-change 属性

  