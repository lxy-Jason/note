# use

> Canary
>
> Canary 渠道是一个预发布渠道，追踪 React 仓库的主分支。我们将 Canary 渠道中的预发布版本用作 Latest 渠道的候选发布版本。你可以将 Canary 视为比 Latest 更频繁更新的超集。
>
> The `use` Hook is currently only available in React’s canary and experimental channels. 
>
>  Learn more about [React’s release channels here](https://react.dev/community/versioning-policy#all-release-channels).

`use` is a React Hook that lets you read the value of a resource like a [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) or [context](https://react.dev/learn/passing-data-deeply-with-context).

```jsx
const value = use(resource);
```

- Reference
  - [`use(resource)`](https://react.dev/reference/react/use#use)
- Usage
  - [Reading context with `use`](https://react.dev/reference/react/use#reading-context-with-use)
  - [Streaming data from the server to the client](https://react.dev/reference/react/use#streaming-data-from-server-to-client)
  - [Dealing with rejected Promises](https://react.dev/reference/react/use#dealing-with-rejected-promises)

- [疑难解答](https://zh-hans.react.dev/reference/react/use#troubleshooting)
  - [“Suspense Exception(悬念异常?): This is not a real error!”](https://react.dev/reference/react/use#suspense-exception-error)

---

## Reference 

### `use(resource)` 

Call `use` in your component to read the value of a resource like a [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) or [context](https://react.dev/learn/passing-data-deeply-with-context).

```jsx
function MessageComponent({ messagePromise }) {
  const message = use(messagePromise);
  const theme = use(ThemeContext);
  // ...
```

Unlike all other React Hooks, `use` can be called within loops and conditional statements like `if`. 

与其他React Hooks一样，**调用use的函数必须是组件或Hook。**

When called with a Promise, the `use` Hook integrates(集成) with [`Suspense`](https://react.dev/reference/react/Suspense)(这是一个组件) and [error boundaries](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary)(边界).

 组件在调用use时会挂起，直到传递给use的Promise完成。

如果调用use的组件被包裹在Suspense边界中，将显示fallback(后备 UI)。

一旦 Promise 被解决，Suspense 后备方案将被使用 Hook 返回的数据替换为渲染组件。

If the Promise passed to `use` is rejected, the fallback of the nearest Error Boundary will be displayed.

[See more examples below.](https://react.dev/reference/react/use#usage)

#### Parameters 

- `resource`: this is the source of the data you want to read a value from. A resource can be a [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) or a [context](https://react.dev/learn/passing-data-deeply-with-context).

#### Returns 

The `use` Hook returns the value that was read from the resource like the resolved value of a [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) or [context](https://react.dev/learn/passing-data-deeply-with-context).

#### Caveats (警告)

- The `use` Hook must be called inside a Component or a Hook.

- When fetching data in a [Server Component](https://react.dev/reference/react/use-server), prefer `async` and `await` over `use`.

  async和await从调用await的地方开始渲染，而use在数据解析后重新渲染组件。

- Prefer creating Promises in [Server Components](https://react.dev/reference/react/use-server) and passing them to [Client Components](https://react.dev/reference/react/use-client) over creating Promises in Client Components. 

   **Promises created in Client Components are recreated on every render.**

  Promises passed from a Server Component to a Client Component are stable across(跳过) re-renders. [See this example](https://react.dev/reference/react/use#streaming-data-from-server-to-client).

---

## Usage 

### Reading context with `use` 

When a [context](https://react.dev/learn/passing-data-deeply-with-context) is passed to `use`, it works similarly to [`useContext`](https://react.dev/reference/react/useContext). 

While `useContext` must be called at the top level of your component, `use` can be called inside conditionals like `if` and loops like `for`. 

`use` is preferred over `useContext` because it is more flexible.

```jsx
import { use } from 'react';

function Button() {
  const theme = use(ThemeContext);
  // ...
```

`use` returns the context value for the context you passed.

To determine the context value, React searches the component tree and finds **the closest context provider above** for that particular context.

将上下文传递给按钮，将其或其父组件之一包装到相应的上下文提供程序(context provider)中。

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

When a `Button` *anywhere* inside of `Form` calls `use(ThemeContext)`, it will receive `"dark"` as the value.

Unlike [`useContext`](https://react.dev/reference/react/useContext), `use` can be called in conditionals and loops like `if`.

```jsx
function HorizontalRule({ show }) {
  if (show) {
    const theme = use(ThemeContext);
    return <hr className={theme} />;
  }
  return false;
}
```

`use` is called from inside a `if` statement, allowing you to conditionally read values from a Context.

> Pitfall(隐患)
>
> Like `useContext`, `use(context)` always looks for the **closest context** provider *above* the component that calls it.
>
> 它向上搜索，并且不考虑从中调用use(context)的组件中的上下文提供者。

### Streaming data from the server to the client 

Data can be streamed from the server to the client by passing a Promise as a prop from a Server Component to a Client Component.

```jsx
import { fetchMessage } from './lib.js';
import { Message } from './message.js';

export default function App() {
  const messagePromise = fetchMessage();
  return (
    <Suspense fallback={<p>waiting for message...</p>}>
      <Message messagePromise={messagePromise} />
    </Suspense>
  );
}
```

The Client Component then takes the Promise it received as a prop and passes it to the `use` Hook. 

This allows the Client Component to read the value from the Promise that was initially created by the Server Component.

```jsx
// message.js
'use client';

import { use } from 'react';

export function Message({ messagePromise }) {
  const messageContent = use(messagePromise);
  return <p>Here is the message: {messageContent}</p>;
}
```

Because `Message` is wrapped in [`Suspense`](https://react.dev/reference/react/Suspense), the fallback will be displayed until the Promise is resolved.

When the Promise is resolved, the value will be read by the `use` Hook and the `Message` component will replace the Suspense fallback.

> ### Note
>
> When passing a Promise from a Server Component to a Client Component, its resolved value must be serializable(串行?可序列化?) to pass between server and client. 
>
> 像函数这样的数据类型不可序列化，不能成为这种 Promise 的解析值。

>##### DEEP DIVE(探讨)
>
>#### Should I resolve a Promise in a Server or Client Component? 
>
>---
>
>A Promise can be passed from a Server Component to a Client Component and resolved in the Client Component with the `use` Hook.
>
>You can also resolve the Promise in a Server Component with `await` and pass the required data to the Client Component as a prop.
>
>```jsx
>export default function App() {
>  const messageContent = await fetchMessage();
>  return <Message messageContent={messageContent} />
>}
>```
>
>But using `await` in a [Server Component](https://react.dev/reference/react/components#server-components) will block(阻塞) its rendering until the `await` statement is finished. 
>
>Passing a Promise from a Server Component to a Client Component prevents the Promise from blocking the rendering of the Server Component.

### Dealing with rejected Promises 

In some cases a Promise passed to `use` could be rejected.

You can handle rejected Promises by either:

1. [Displaying an error to users with error boundary.](https://react.dev/reference/react/use#displaying-an-error-to-users-with-error-boundary)
2. [Providing an alternative(替代) value with `Promise.catch`](https://react.dev/reference/react/use#providing-an-alternative-value-with-promise-catch)

> ### Pitfall
>
> `use` cannot be called in a try-catch block. 
>
>  Instead of a try-catch block [wrap your component in an Error Boundary](https://react.dev/reference/react/use#displaying-an-error-to-users-with-error-boundary), or [provide an alternative value to use with the Promise’s `.catch` method](https://react.dev/reference/react/use#providing-an-alternative-value-with-promise-catch).

#### Displaying an error to users with a error boundary 

If you’d like to display an error to your users when a Promise is rejected, you can use an [error boundary](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary).

To use an error boundary, wrap the component where you are calling the `use` Hook in an error boundary.

If the Promise passed to `use` is rejected the fallback for the error boundary will be displayed.

```jsx
export function MessageContainer({ messagePromise }) {
  return (
    <ErrorBoundary fallback={<p>⚠️Something went wrong</p>}>
      <Suspense fallback={<p>⌛Downloading message...</p>}>
        <Message messagePromise={messagePromise} />
      </Suspense>
    </ErrorBoundary>
  );
}

function Message({ messagePromise }) {
  const content = use(messagePromise);
  return <p>Here is the message: {content}</p>;
}
```

#### Providing an alternative value with `Promise.catch` 

If you’d like to provide an alternative value when the Promise passed to `use` is rejected you can use the Promise’s [`catch`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/catch) method.

```jsx
import { Message } from './message.js';

export default function App() {
  const messagePromise = new Promise((resolve, reject) => {
    reject();
  }).catch(() => {
    return "no new message found.";
  });

  return (
    <Suspense fallback={<p>waiting for message...</p>}>
      <Message messagePromise={messagePromise} />
    </Suspense>
  );
}
```

To use the Promise’s `catch` method, call `catch` on the Promise object.

`catch` takes a single argument(一个参数): a function that takes an error message as an argument(一个以错误消息为参数的函数。). 

Whatever is returned by the function passed to `catch` will be used as the resolved value of the Promise.

---

## Troubleshooting (疑难解答)

### “Suspense Exception: This is not a real error!” 

You are either(要么) calling `use` outside of a React component or Hook function, or(要么) calling `use` in a try–catch block. 

If you are calling `use` inside a try–catch block, wrap your component in an error boundary, or call the Promise’s `catch` to catch the error and resolve the Promise with another value. [See these examples](https://react.dev/reference/react/use#dealing-with-rejected-promises).

If you are calling `use` outside a React component or Hook function, move the `use` call to a React component or Hook function.

```jsx
function MessageComponent({messagePromise}) {
  function download() {
    // ❌ the function calling `use` is not a Component or Hook
    const message = use(messagePromise);
    // ...
```

相反，请在任何组件封闭区域之外调用 `use`，而调用 `use` 的函数本身应为组件或 Hook。

```jsx
function MessageComponent({messagePromise}) {
  // ✅ `use` is being called from a component. 
  const message = use(messagePromise);
  // ...
```

