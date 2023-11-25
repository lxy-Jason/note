# useCallback

`useCallback` is a React Hook that lets you cache a function definition between re-renders.

```js
const cachedFn = useCallback(fn, dependencies)
```

- Reference
  - [`useCallback(fn, dependencies)`](https://react.dev/reference/react/useCallback#usecallback)
- Usage
  - [Skipping re-rendering of components](https://react.dev/reference/react/useCallback#skipping-re-rendering-of-components)
  - [Updating state from a memoized callback](https://react.dev/reference/react/useCallback#updating-state-from-a-memoized-callback)
  - [Preventing an Effect from firing too often](https://react.dev/reference/react/useCallback#preventing-an-effect-from-firing-too-often)(防止Effect过于频繁触发)
  - [Optimizing a custom Hook](https://react.dev/reference/react/useCallback#optimizing-a-custom-hook)
- Troubleshooting
  - [Every time my component renders, `useCallback` returns a different function](https://react.dev/reference/react/useCallback#every-time-my-component-renders-usecallback-returns-a-different-function)
  - [I need to call `useCallback` for each list item in a loop, but it’s not allowed](https://react.dev/reference/react/useCallback#i-need-to-call-usememo-for-each-list-item-in-a-loop-but-its-not-allowed)

---

## Reference 

### `useCallback(fn, dependencies)` 

Call `useCallback` at the top level of your component to cache a function definition between re-renders:

```jsx
import { useCallback } from 'react';

export default function ProductPage({ productId, referrer, theme }) {
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]);
```

[See more examples below.](https://react.dev/reference/react/useCallback#usage)

#### Parameters 

- `fn`: The function value that you want to cache. 

  It can take any arguments and return any values.

  React will return (not call!) your function back to you during the initial render.

   On next renders, React will give you the same function again if the `dependencies` have not changed since the last render.

  Otherwise, it will give you the function that you have passed during the current render, and store it in case it can be reused later. 

  React will not call your function.

  The function is returned to you so you can decide when and whether to call it.

- `dependencies`: The list of all reactive values referenced inside of the `fn` code.

  Reactive values include props, state, and all the variables and functions declared directly inside your component body. 

  If your linter(代码检查工具) is [configured for React](https://react.dev/learn/editor-setup#linting), it will verify that every reactive value is correctly specified as a dependency.

  The list of dependencies must have a constant number(确切数量) of items and be written inline like `[dep1, dep2, dep3]`. 

  React will compare each dependency with its previous value using the [`Object.is`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is) comparison algorithm.

#### Returns 

On the initial render, `useCallback` returns the `fn` function you have passed.

During subsequent renders, it will either return an already stored `fn`  function from the last render (if the dependencies haven’t changed), or return the `fn` function you have passed during this render.

#### Caveats (警告)

- `useCallback` is a Hook, so you can only call it **at the top level of your component** or your own Hooks.

  You can’t call it inside loops or conditions. If you need that, extract a new component and move the state into it.

- React **will not throw away the cached function unless there is a specific reason to do that.** 

  For example, in development, React throws away the cache when you edit the file of your component.

  Both in development and in production, React will throw away the cache if your component suspends(暂停) during the initial mount. 

  在未来，React 可能会增加更多利用了丢弃缓存机制的特性。例如，如果 React 未来内置了对虚拟列表的支持，那么在滚动超出虚拟化表视口的item时，抛弃缓存是有意义的。

  This should match your expectations if you rely on `useCallback` as a performance optimization. 

  Otherwise, a [state variable](https://react.dev/reference/react/useState#im-trying-to-set-state-to-a-function-but-it-gets-called-instead) or a [ref](https://react.dev/reference/react/useRef#avoiding-recreating-the-ref-contents) may be more appropriate.

---

## Usage 

### Skipping re-rendering of components 

When you optimize rendering performance, you will sometimes need to cache the functions that you pass to child components.

 Let’s first look at the syntax for how to do this, and then see in which cases it’s useful.

To cache a function between re-renders of your component, wrap its definition into the `useCallback` Hook:

```jsx
import { useCallback } from 'react';

function ProductPage({ productId, referrer, theme }) {
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]);
  // ...
```

You need to pass two things to `useCallback`:

1. A function definition that you want to cache between re-renders.
2. A list of dependencies including every value within your component that’s used inside your function.

On the initial render, the returned function you’ll get from `useCallback` will be the function you passed.

On the following renders, React will compare the dependencies with the dependencies you passed during the previous render. 

 If none of the dependencies have changed (compared with [`Object.is`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is)), `useCallback` will return the same function as before. 

Otherwise, `useCallback` will return the function you passed on *this* render.

In other words, `useCallback` caches a function between re-renders until its dependencies change.

**Let’s walk through an example to see when this is useful.**

Say you’re passing a `handleSubmit` function down from the `ProductPage` to the `ShippingForm` component:

```jsx
function ProductPage({ productId, referrer, theme }) {
  // ...
  return (
    <div className={theme}>
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
```

You’ve noticed that toggling the `theme` prop freezes(卡顿) the app for a moment, but if you remove `<ShippingForm />` from your JSX, it feels fast. 

This tells you that it’s worth trying to optimize the `ShippingForm` component.

**By default, when a component re-renders, React re-renders all of its children recursively(递归的).** 

This is why, when `ProductPage` re-renders with a different `theme`, the `ShippingForm` component *also* re-renders. 

This is fine for components that don’t require much calculation to re-render. 

But if you verified a re-render is slow, you can tell `ShippingForm` to skip re-rendering when its props are the same as on last render by **wrapping** it in [`memo`](https://react.dev/reference/react/memo):

```jsx
import { memo } from 'react';

const ShippingForm = memo(function ShippingForm({ onSubmit }) { //注意这里是包裹了整个组件
  // ...
});
```

**With this change, `ShippingForm` will skip re-rendering if all of its props are the \*same\* as on the last render.** 

This is when caching a function becomes important!(这就是在缓存函数变得重要的时候！)

 Let’s say you defined `handleSubmit` without `useCallback`:

```jsx
function ProductPage({ productId, referrer, theme }) {
  // Every time the theme changes, this will be a different function...
  function handleSubmit(orderDetails) {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }
  
  return (
    <div className={theme}>
      {/* ... so ShippingForm's props will never be the same, and it will re-render every time */}
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}
```

**In JavaScript, a `function () {}` or `() => {}` always creates a \*different\* function,** similar to how the `{}` object literal(字面量) always creates a new object. 

Normally, this wouldn’t be a problem, but it means that `ShippingForm` props will never be the same, and your [`memo`](https://react.dev/reference/react/memo) optimization won’t work. 

This is where `useCallback` comes in handy:(这就是useCallback派上用场的地方：)

```jsx
function ProductPage({ productId, referrer, theme }) {
  // Tell React to cache your function between re-renders...
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]); // ...so as long as these dependencies don't change...

  return (
    <div className={theme}>
      {/* ...ShippingForm will receive the same props and can skip re-rendering */}
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}
```

**By wrapping `handleSubmit` in `useCallback`, you ensure that it’s the \*same\* function between the re-renders** (until dependencies change). 

You don’t *have to* wrap a function in `useCallback` unless you do it for some specific reason. 

In this example, the reason is that you pass it to a component wrapped in [`memo`,](https://react.dev/reference/react/memo) and this lets it skip re-rendering. 

There are other reasons you might need `useCallback` which are described further on this page.

> ### Note
>
> **You should only rely on `useCallback` as a performance optimization.** If your code doesn’t work without it, find the underlying(潜在的) problem and fix it first. Then you may add `useCallback` back.

>##### DEEP DIVE
>
>#### How is useCallback related to useMemo? 
>
>---
>
>You will often see [`useMemo`](https://react.dev/reference/react/useMemo) alongside(一起使用) `useCallback`. 
>
>They are both useful when you’re trying to optimize a child component. 
>
>They let you [memoize](https://en.wikipedia.org/wiki/Memoization) (or, in other words, cache) something you’re passing down:
>
>```jsx
>import { useMemo, useCallback } from 'react';
>
>function ProductPage({ productId, referrer }) {
>  const product = useData('/product/' + productId);
>
>  const requirements = useMemo(() => { // Calls your function and caches its result
>    return computeRequirements(product);
>  }, [product]);
>
>  const handleSubmit = useCallback((orderDetails) => { // Caches your function itself
>    post('/product/' + productId + '/buy', {
>      referrer,
>      orderDetails,
>    });
>  }, [productId, referrer]);
>
>  return (
>    <div className={theme}>
>      <ShippingForm requirements={requirements} onSubmit={handleSubmit} />
>    </div>
>  );
>}
>```
>
>The difference is in *what* they’re letting you cache:
>
>- **[`useMemo`](https://react.dev/reference/react/useMemo) caches the \*result\* of calling your function.** 
>
>  In this example, it caches the result of calling `computeRequirements(product)` so that it doesn’t change unless `product` has changed. 
>
>  This lets you pass the `requirements` object down without unnecessarily re-rendering `ShippingForm`. 
>
>   When necessary, React will call the function you’ve passed during rendering to calculate the result.
>
>- **`useCallback` caches \*the function itself.\***
>
>  Unlike `useMemo`, it does not call the function you provide.
>
>  Instead, it caches the function you provided so that `handleSubmit` *itself* doesn’t change unless `productId` or `referrer` has changed. 
>
>   This lets you pass the `handleSubmit` function down without unnecessarily re-rendering `ShippingForm`.
>
>  Your code won’t run until the user submits the form.
>
>If you’re already familiar with [`useMemo`,](https://react.dev/reference/react/useMemo) you might find it helpful to think of `useCallback` as this:
>
>```jsx
>// Simplified implementation (inside React)
>function useCallback(fn, dependencies) {
>  return useMemo(() => fn, dependencies);
>}
>```
>
>[Read more about the difference between `useMemo` and `useCallback`.](https://react.dev/reference/react/useMemo#memoizing-a-function)

>##### DEEP DIVE
>
>#### Should you add useCallback everywhere? 
>
>---
>
>If your app is like this site, and most interactions are coarse(粗糙的) (like replacing a page or an entire section), memoization is usually unnecessary. 
>
>另一方面，如果您的应用程序更像是一个绘图编辑器，并且大多数交互都是粒度化的（比如移动形状），那么您可能会发现记忆化非常有帮助。
>
>Caching a function with `useCallback`  is only valuable in a few cases:
>
>- You pass it as a prop to a component wrapped in [`memo`.](https://react.dev/reference/react/memo) You want to skip re-rendering if the value hasn’t changed. Memoization lets your component re-render only if dependencies changed.
>- 你传递的函数后来被用作某个 Hook 的依赖。例如，另一个包裹在 useCallback 中的函数依赖于它，或者你从 useEffect 依赖于这个函数。
>
>There is no benefit to wrapping a function in `useCallback` in other cases. 
>
>There is no significant harm(坏处) to doing that either, so some teams choose to not think about individual(个别的) cases, and memoize as much as possible.
>
>The downside(缺点) is that code becomes less readable.(可读性降低)
>
>Also, not all memoization is effective: a single value that’s “always new” is enough to break memoization for an entire component.
>
>Note that `useCallback` does not prevent(阻止) *creating* the function.
>
>You’re always creating a function (and that’s fine!), but React ignores it and gives you back a cached function if nothing changed.
>
>**In practice, you can make a lot of memoization unnecessary by following a few principles:**
>
>1. When a component visually(视觉上) wraps other components, let it [accept JSX as children.](https://react.dev/learn/passing-props-to-a-component#passing-jsx-as-children) Then, if the wrapper component updates its own state, React knows that its children don’t need to re-render.
>2. 建议使用 state 并且不要 [提升状态](https://zh-hans.react.dev/learn/sharing-state-between-components) 超过必要的程度。不要将表单和项是否悬停等短暂状态保存在树的顶部或全局状态库中。
>3. Keep your [rendering logic pure.](https://react.dev/learn/keeping-components-pure)(逻辑纯粹) 如果重新渲染组件导致问题或产生明显的视觉瑕疵，那就是你的组件中存在的错误！Fix the bug instead of adding memoization.
>4. Avoid [unnecessary Effects that update state.](https://react.dev/learn/you-might-not-need-an-effect) Most performance problems in React apps are caused by chains of updates originating from Effects that cause your components to render over and over.
>5. Try to [remove unnecessary dependencies from your Effects.](https://react.dev/learn/removing-effect-dependencies) 例如，将某些对象或函数移动到副作用内部或组件外部通常更简单，而不是使用记忆化。
>
>If a specific interaction still feels laggy(卡顿), [use the React Developer Tools profiler](https://legacy.reactjs.org/blog/2018/09/10/introducing-the-react-profiler.html)(分析器) to see which components benefit the most from memoization, and add memoization where needed. 
>
>These principles(原则) make your components easier to debug and understand, so it’s good to follow them in any case. 
>
> In long term, we’re researching(研究) [doing memoization automatically](https://www.youtube.com/watch?v=lGEMwh32soc) to solve this once and for all(一劳永逸).

#### The difference between useCallback and declaring a function directly

#### Example 1 of 2: Skipping re-rendering with `useCallback` and `memo` 

在这个例子中，ShippingForm组件被人为地减慢了速度，以便您可以看到当您渲染的React组件真正变慢时会发生什么。

Try incrementing the counter and toggling the theme.

Incrementing the counter feels slow because it forces the slowed down `ShippingForm` to re-render. 

这是预料之中的，因为计数器已经改变了，所以你需要在屏幕上反映用户的新选择。

```jsx
import { memo, useState } from 'react';

const ShippingForm = memo(function ShippingForm({ onSubmit }) {
  const [count, setCount] = useState(1);

  console.log('[ARTIFICIALLY SLOW] Rendering <ShippingForm />');
  let startTime = performance.now();
  while (performance.now() - startTime < 500) {
    // Do nothing for 500 ms to emulate extremely slow code
  }

  function handleSubmit(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const orderDetails = {
      ...Object.fromEntries(formData),
      count
    };
    onSubmit(orderDetails);
  }

  return (
    <form onSubmit={handleSubmit}>
      <p><b>Note: <code>ShippingForm</code> is artificially slowed down!</b></p>
      <label>
        Number of items:
        <button type="button" onClick={() => setCount(count - 1)}>–</button>
        {count}
        <button type="button" onClick={() => setCount(count + 1)}>+</button>
      </label>
      <label>
        Street:
        <input name="street" />
      </label>
      <label>
        City:
        <input name="city" />
      </label>
      <label>
        Postal code:
        <input name="zipCode" />
      </label>
      <button type="submit">Submit</button>
    </form>
  );
});

export default ShippingForm;

```

Next, try toggling the theme. **Thanks to `useCallback` together with [`memo`](https://react.dev/reference/react/memo), it’s fast despite(即使) the artificial(人为的) slowdown!** `ShippingForm` skipped re-rendering because the `handleSubmit` function has not changed. The `handleSubmit` function has not changed because both `productId` and `referrer` (your `useCallback` dependencies) haven’t changed since last render.

```jsx
import { useCallback } from 'react';
import ShippingForm from './ShippingForm.js';

export default function ProductPage({ productId, referrer, theme }) {
  const handleSubmit = useCallback((orderDetails) => { //重点
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]);

  return (
    <div className={theme}>
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}

function post(url, data) {
  // Imagine this sends a request...
  console.log('POST /' + url);
  console.log(data);
}

```

#### Example 2 of 2: Always re-rendering a component 

In this example, the `ShippingForm` implementation is also **artificially slowed down** so that you can see what happens when some React component you’re rendering is genuinely slow. Try incrementing the counter and toggling the theme.

Unlike in the previous example, toggling the theme is also slow now! 

This is because **there is no `useCallback` call in this version,** so `handleSubmit` is always a new function, and the slowed down `ShippingForm` component can’t skip re-rendering.

```jsx
import ShippingForm from './ShippingForm.js';

export default function ProductPage({ productId, referrer, theme }) {
  function handleSubmit(orderDetails) { //重点
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }

  return (
    <div className={theme}>
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}

function post(url, data) {
  // Imagine this sends a request...
  console.log('POST /' + url);
  console.log(data);
}
```

Quite often(很多时候), code without memoization works fine. 

 If your interactions are fast enough, you don’t need memoization.

请记住，您需要在生产模式下运行React，禁用React开发者工具，并使用与您的应用程序用户相似的设备，以便真实地了解导致应用程序变慢的原因。

---

### Updating state from a memoized callback 

Sometimes, you might need to update state based on previous state from a memoized callback.

这个 handleAddTodo 函数将 todos 指定为一个依赖项，因为它从中计算出下一个 todos。

```jsx
function TodoList() {
  const [todos, setTodos] = useState([]);

  const handleAddTodo = useCallback((text) => {
    const newTodo = { id: nextId++, text };
    setTodos([...todos, newTodo]);
  }, [todos]);
```

通常情况下，您希望具有尽可能少的依赖关系的记忆化函数。

当你只需要读取某个状态来计算下一个状态时，可以通过传递一个更新函数来消除该依赖关系：

```jsx
function TodoList() {
  const [todos, setTodos] = useState([]);

  const handleAddTodo = useCallback((text) => {
    const newTodo = { id: nextId++, text };
    setTodos(todos => [...todos, newTodo]);
  }, []); // ✅ No need for the todos dependency
  // ...
```

在这里，不是将todos作为依赖项并在内部读取它，而是向React传递一个关于如何更新状态（todos => [...todos, newTodo]）的指令。 [Read more about updater functions.](https://react.dev/reference/react/useState#updating-state-based-on-the-previous-state)

---

### Preventing an Effect from firing too often 