1. `type`可以用来定义任意类型，包括基本类型、联合类型、交叉类型等，而`interface`主要用来定义**对象类型**。

2. `type`可以使用**类型别名**，可以给一个类型起一个新的名字，使代码更加可读。而`interface`不能使用类型别名。

3. `type`支持联合类型和交叉类型的**操作符**，例如`|`和`&`，可以将多个类型组合起来。而`interface`不支持这些操作符。

4. `interface`可以被**类实现（`implements`）**，类可以实现多个接口，从而实现接口的多重继承。而`type`不支持类实现。

5. 当你需要扩展或合并现有的类型时，`interface`是更好的选择。你可以使用`extends`关键字来扩展其他接口。而`type`不支持扩展其他类型，但可以使用交叉类型来合并多个类型。

