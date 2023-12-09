# useContext

`useContext` is a React Hook that lets you read and subscribe to [context](https://react.dev/learn/passing-data-deeply-with-context) from your component.

```jsx
const value = useContext(SomeContext)
```

- Reference
  - [`useContext(SomeContext)`](https://react.dev/reference/react/useContext#usecontext)
- [Usage](https://react.dev/reference/react/useContext#usage)
  - [Passing data deeply into the tree](https://react.dev/reference/react/useContext#passing-data-deeply-into-the-tree)
  - [Updating data passed via(通过) context](https://react.dev/reference/react/useContext#updating-data-passed-via-context)
  - [Specifying a fallback default value](https://react.dev/reference/react/useContext#specifying-a-fallback-default-value)(指定一个备用的默认值)
  - [Overriding context for a part of the tree](https://react.dev/reference/react/useContext#overriding-context-for-a-part-of-the-tree)(树的一部分上下文重写)
  - [Optimizing re-renders when passing objects and functions](https://react.dev/reference/react/useContext#optimizing-re-renders-when-passing-objects-and-functions)

- Troubleshooting
  - [My component doesn’t see the value from my provider](https://react.dev/reference/react/useContext#my-component-doesnt-see-the-value-from-my-provider)
  - [I am always getting `undefined` from my context although the default value is different](https://react.dev/reference/react/useContext#i-am-always-getting-undefined-from-my-context-although-the-default-value-is-different)

---

## Reference 

### `useContext(SomeContext)` 

Call `useContext` at the top level of your component to read and subscribe to [context.](https://react.dev/learn/passing-data-deeply-with-context)

```jsx
import { useContext } from 'react';

function MyComponent() {
  const theme = useContext(ThemeContext);
  // ...
```

[See more examples below.](https://react.dev/reference/react/useContext#usage)

#### Parameters 

`SomeContext`: The context that you’ve previously created with [`createContext`](https://react.dev/reference/react/createContext). 

上下文本身并不包含信息，它只代表了您可以从组件中提供或读取的信息类型。

#### Returns 

`useContext` returns the context value for the calling component.(就是可以拿到provider提供的值)

It is determined as the `value` passed to the closest `SomeContext.Provider` above the calling component in the tree.(拿到最近的,因为可以重写,所以可能不同)

If there is no such provider, then the returned value will be the `defaultValue` you have passed to [`createContext`](https://react.dev/reference/react/createContext) for that context. 

The returned value is always up-to-date(始终是最新的).

React automatically re-renders components that read some context if it changes.

#### Caveats (警告)

- `useContext()` call in a component is not affected by providers returned from the *same* component. 

  相应的<Context.Provider>需要位于使用useContext()调用的组件之上。

- React **automatically re-renders** all the children that use a particular context starting from the provider that receives a different `value`.

  The previous and the next values are compared with the [`Object.is`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is) comparison.

  **Skipping re-renders with [`memo`](https://react.dev/reference/react/memo) does not prevent the children receiving fresh context values.**

- 如果您的构建系统在输出中产生重复的模块（这可能发生在符号链接中），这可能会破坏上下文。

  只有在使用提供上下文的SomeContext和读取它的SomeContext是完全相同的对象时，通过上下文传递某些内容才有效，这可以通过===比较来确定。

---

## Usage 

### Passing data deeply into the tree 

Call `useContext` at the top level of your component to read and subscribe to [context.](https://react.dev/learn/passing-data-deeply-with-context)

```jsx
import { useContext } from 'react';

function Button() {
  const theme = useContext(ThemeContext);
  // ...
```

`useContext` returns the context value for the context you passed.

To determine the context value, React searches the component tree and finds **the closest context provider above** for that particular context.

To pass context to a `Button`, wrap it or one of its parent components into the corresponding(相应的) context provider:

```jsx
function MyPage() {
  return (
    <ThemeContext.Provider value="dark">
      <Form />
    </ThemeContext.Provider>
  );
}

function Form() {
  // ... renders buttons inside ...
}
```

 It doesn’t matter how many layers of components there are between the provider and the `Button`.

When a `Button` *anywhere* inside of `Form` calls `useContext(ThemeContext)`, it will receive `"dark"` as the value.

>### Pitfall(隐患)
>
>`useContext()` always looks for the closest provider *above* the component that calls it. 
>
>它向上搜索，并且不考虑您调用useContext()的组件中的提供者。

---

