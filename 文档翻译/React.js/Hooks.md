# Built-in React Hooks

*Hooks* let you use different React features from your components.

You can either use the built-in Hooks or combine them to build your own.

This page lists all built-in Hooks in React.

---

## State Hooks 

*State* lets a component [“remember” information like user input.](https://react.dev/learn/state-a-components-memory)

For example, a form component can use state to store the input value, while an image gallery(图像库) component can use state to store the selected image index.

To add state to a component, use one of these Hooks:

- [`useState`](https://react.dev/reference/react/useState) declares a state variable that you can update directly.
- [`useReducer`](https://react.dev/reference/react/useReducer) declares a state variable with the update logic inside a [reducer function.](https://react.dev/learn/extracting-state-logic-into-a-reducer)

```tsx
function ImageGallery() {
  const [index, setIndex] = useState(0);
```

---

## Context Hooks 

*Context* lets a component [receive information from distant parents without passing it as props.](https://react.dev/learn/passing-props-to-a-component) 

 For example, your app’s top-level component can pass the current UI theme to all components below, no matter how deep.

- [`useContext`](https://react.dev/reference/react/useContext) reads and subscribes(订阅) to a context.

```jsx
function Button() {
  const theme = useContext(ThemeContext);
```

---

## Ref Hooks 

Refs允许组件保存一些不用于渲染的信息，例如DOM节点或超时ID。

Unlike with state, updating a ref does not re-render your component. 

ref 是从 React 范例中的“脱围机制”。

They are useful when you need to work with non-React systems, such as the built-in browser APIs.

- [`useRef`](https://react.dev/reference/react/useRef) declares a ref. You can hold any value in it, but most often it’s used to hold a DOM node.
- [`useImperativeHandle`](https://react.dev/reference/react/useImperativeHandle) lets you customize(自定义) the ref exposed by your component. This is rarely used.

```jsx
function Form() {
  const inputRef = useRef(null);
  // ...
```

---

## Effect Hooks 

*Effects* let a component [connect to and synchronize with external systems.](https://react.dev/learn/synchronizing-with-effects)

This includes dealing with **network, browser DOM, animations, widgets(小部件) written using a different UI library, and other non-React code**.

- [`useEffect`](https://react.dev/reference/react/useEffect) connects a component to an external system.

```jsx
function ChatRoom({ roomId }) {
  useEffect(() => {
    const connection = createConnection(roomId);
    connection.connect();
    return () => connection.disconnect();
  }, [roomId]);
  // ...
```

Effects are an “escape hatch”(脱围机制) from the React paradigm. 

Don’t use Effects to orchestrate(协调) the data flow of your application.

If you’re not interacting with an external system, [you might not need an Effect.](https://react.dev/learn/you-might-not-need-an-effect)

有两种很少使用的useEffect变体，其时间上存在差异：

- [`useLayoutEffect`](https://react.dev/reference/react/useLayoutEffect) 在浏览器重新绘制屏幕之前触发。You can measure layout here.
- [`useInsertionEffect`](https://react.dev/reference/react/useInsertionEffect) fires before React makes changes to the DOM. Libraries can insert dynamic CSS here.

---

## Performance Hooks 

A common way to optimize re-rendering performance is to skip unnecessary work.

For example, you can tell React to reuse a cached calculation(缓存计算) or to skip a re-render if the data has not changed since the previous render.

To skip calculations and unnecessary re-rendering, use one of these Hooks:

- [`useMemo`](https://react.dev/reference/react/useMemo) lets you cache the result of an expensive calculation.
- [`useCallback`](https://react.dev/reference/react/useCallback)  将函数传递给优化组件之前缓存函数定义。

```jsx
function TodoList({ todos, tab, theme }) {
  const visibleTodos = useMemo(() => filterTodos(todos, tab), [todos, tab]);
  // ...
}
```

Sometimes, you can’t skip re-rendering because the screen actually needs to update. 

在这种情况下，您可以通过将必须同步的阻塞更新（例如输入文本）与不需要阻塞用户界面的非阻塞更新（例如更新图表）分开来提高性能。

To prioritize(优先) rendering, use one of these Hooks:

- [`useTransition`](https://react.dev/reference/react/useTransition) 允许将状态转换标记为非阻塞，并允许其他更新中断它。
- [`useDeferredValue`](https://react.dev/reference/react/useDeferredValue) lets you defer(延迟) updating a non-critical(非关键) part of the UI and let other parts update first.

---

## Resource Hooks 

组件可以访问资源，而无需将其作为其状态的一部分。

For example, a component can read a message from a Promise or read styling information from a context.

To read a value from a resource, use this Hook:

- [`use`](https://react.dev/reference/react/use) lets you read the value of a resource like a [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) or [context](https://react.dev/learn/passing-data-deeply-with-context).

```jsx
function MessageComponent({ messagePromise }) {
  const message = use(messagePromise);
  const theme = use(ThemeContext);
  // ...
}
```

---

## Other Hooks 

这些 Hooks 主要对于库的作者来说非常有用，不常在应用代码中使用。

- [`useDebugValue`](https://react.dev/reference/react/useDebugValue) lets you customize the label React DevTools displays for your custom Hook.
- [`useId`](https://react.dev/reference/react/useId) lets a component associate(联系) a unique ID with itself. 其通常与可访问性 API 一起使用。
- [`useSyncExternalStore`](https://react.dev/reference/react/useSyncExternalStore) lets a component subscribe to an external store.

---

## Your own Hooks 

You can also [define your own custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks#extracting-your-own-custom-hook-from-a-component) as JavaScript functions.
