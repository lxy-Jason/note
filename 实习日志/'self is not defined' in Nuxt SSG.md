在nuxt中碰到这种xxx is not defined 这种情况

就是考虑在服务端渲染时拿不到这个变量的情况

所以使用

```js
if(process.browser){
    ...原本的内容
}
```

包括起来之后,只有在浏览器中才会运行

可以解决很多麻烦