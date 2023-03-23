1. `import` 是 ES6 中引入模块的语法，而 `require` 是 Node.js 中引入模块的语法。
2. `import` 是编译时引入，而 `require` 是运行时引入。也就是说，使用 `import` 时，模块会在编译时被解析和加载，而使用 `require` 时，模块会在代码运行时被加载。
3. `import` 引入的模块是静态的，而 `require` 引入的模块是动态的。在使用 `import` 时，模块的路径必须是静态的，不能使用变量；而在使用 `require` 时，模块的路径可以是动态的，可以使用变量。
4. `import` 引入的模块是只读的，而 `require` 引入的模块是可读可写的。在使用 `import` 时，引入的模块是只读的，不能修改其导出的变量；而在使用 `require` 时，引入的模块是可读可写的，可以修改其导出的变量。
5. `import` 可以按需加载模块，而 `require` 加载的是整个模块。 在使用 `import` 时，可以使用动态 `import` 的方式，按需加载模块；而在使用 `require` 时，会将整个模块加载到内存中。



### CommonJS 和 ES Module 的区别

- 加载方式不同：CommonJS 是运行时加载，ES Module 是编译时加载；
- 输出方式不同：CommonJS 输出的是一个值的拷贝，ES Module 输出的是值的引用；
- 声明方式不同：CommonJS 使用 module.exports 和 require 来导出和导入模块，ES Module 使用 export 和 import 来导出和导入模块。