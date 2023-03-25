loader接收源代码，然后根据需要将其转化为另一种代码，因此loader通常需要处理AST。 loader使用AST来分析语言结构，查询变量、函数、类、循环等，以进行必要的转换。

webpack使用内置的 acorn 解析器将源代码转换为AST，然后将AST对象作为参数传递给各个loader，以便loader可以直接操作和修改AST对象。

在使用babel转码器时，babel会将源码先转换成AST（使用Babel的parse方法），再利用AST对代码进行转换，最终生成转换后的代码。