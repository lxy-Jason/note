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

### Updating data passed via context 

Often, you’ll want the context to change over time. 

To update context, combine it with [state.](https://react.dev/reference/react/useState) 

Declare a state variable in the parent component, and pass the current state down as the context value to the provider.

```jsx
function MyPage() {
  const [theme, setTheme] = useState('dark');
  return (
    <ThemeContext.Provider value={theme}>
      <Form />
      <Button onClick={() => {
        setTheme('light');
      }}>
        Switch to light theme
      </Button>
    </ThemeContext.Provider>
  );
}
```

Now any `Button` inside of the provider will receive the current `theme` value. 

If you call `setTheme` to update the `theme` value that you pass to the provider, all `Button` components will re-render with the new `'light'` value.

#### Examples of updating context

#### Example 1 of 5: Updating a value via context 

In this example, the `MyApp` component holds a state variable which is then passed to the `ThemeContext` provider. 

Checking the “Dark mode” checkbox updates the state.

Changing the provided value re-renders all the components using that context.

```jsx
import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext(null);

export default function MyApp() {
  const [theme, setTheme] = useState('light');
  return (
    <ThemeContext.Provider value={theme}>
      <Form />
      <label>
        <input
          type="checkbox"
          checked={theme === 'dark'}
          onChange={(e) => {
            setTheme(e.target.checked ? 'dark' : 'light')
          }}
        />
        Use dark mode
      </label>
    </ThemeContext.Provider>
  )
}

function Form({ children }) {
  return (
    <Panel title="Welcome">
      <Button>Sign up</Button>
      <Button>Log in</Button>
    </Panel>
  );
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  const className = 'panel-' + theme;
  return (
    <section className={className}>
      <h1>{title}</h1>
      {children}
    </section>
  )
}

function Button({ children }) {
  const theme = useContext(ThemeContext);
  const className = 'button-' + theme;
  return (
    <button className={className}>
      {children}
    </button>
  );
}

```

#### Example 2 of 5: Updating an object via context 

In this example, there is a `currentUser` state variable which holds an object.

You combine `{ currentUser, setCurrentUser }` into a single object and pass it down through the context inside the `value={}`. 

This lets any component below, such as `LoginButton`, read both `currentUser` and `setCurrentUser`, and then call `setCurrentUser` when needed.

```jsx
import { createContext, useContext, useState } from 'react';

const CurrentUserContext = createContext(null);

export default function MyApp() {
  const [currentUser, setCurrentUser] = useState(null);
  return (
    <CurrentUserContext.Provider
      value={{
        currentUser,
        setCurrentUser
      }}
    >
      <Form />
    </CurrentUserContext.Provider>
  );
}

function Form({ children }) {
  return (
    <Panel title="Welcome">
      <LoginButton />
    </Panel>
  );
}

function LoginButton() {
  const {
    currentUser,
    setCurrentUser
  } = useContext(CurrentUserContext);

  if (currentUser !== null) {
    return <p>You logged in as {currentUser.name}.</p>;
  }

  return (
    <Button onClick={() => {
      setCurrentUser({ name: 'Advika' })
    }}>Log in as Advika</Button>
  );
}

function Panel({ title, children }) {
  return (
    <section className="panel">
      <h1>{title}</h1>
      {children}
    </section>
  )
}

function Button({ children, onClick }) {
  return (
    <button className="button" onClick={onClick}>
      {children}
    </button>
  );
}

```

#### Example 3 of 5: Multiple contexts 

In this example, there are two independent contexts. 

`ThemeContext` provides the current theme, which is a string, while `CurrentUserContext` holds the object representing(表示) the current user.

```jsx
import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext(null);
const CurrentUserContext = createContext(null);

export default function MyApp() {
  const [theme, setTheme] = useState('light');
  const [currentUser, setCurrentUser] = useState(null);
  return (
    <ThemeContext.Provider value={theme}>
      <CurrentUserContext.Provider
        value={{
          currentUser,
          setCurrentUser
        }}
      >
        <WelcomePanel />
        <label>
          <input
            type="checkbox"
            checked={theme === 'dark'}
            onChange={(e) => {
              setTheme(e.target.checked ? 'dark' : 'light')
            }}
          />
          Use dark mode
        </label>
      </CurrentUserContext.Provider>
    </ThemeContext.Provider>
  )
}

function WelcomePanel({ children }) {
  const {currentUser} = useContext(CurrentUserContext);
  return (
    <Panel title="Welcome">
      {currentUser !== null ?
        <Greeting /> :
        <LoginForm />
      }
    </Panel>
  );
}

function Greeting() {
  const {currentUser} = useContext(CurrentUserContext);
  return (
    <p>You logged in as {currentUser.name}.</p>
  )
}

function LoginForm() {
  const {setCurrentUser} = useContext(CurrentUserContext);
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const canLogin = firstName !== '' && lastName !== '';
  return (
    <>
      <label>
        First name{': '}
        <input
          required
          value={firstName}
          onChange={e => setFirstName(e.target.value)}
        />
      </label>
      <label>
        Last name{': '}
        <input
        required
          value={lastName}
          onChange={e => setLastName(e.target.value)}
        />
      </label>
      <Button
        disabled={!canLogin}
        onClick={() => {
          setCurrentUser({
            name: firstName + ' ' + lastName
          });
        }}
      >
        Log in
      </Button>
      {!canLogin && <i>Fill in both fields.</i>}
    </>
  );
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  const className = 'panel-' + theme;
  return (
    <section className={className}>
      <h1>{title}</h1>
      {children}
    </section>
  )
}

function Button({ children, disabled, onClick }) {
  const theme = useContext(ThemeContext);
  const className = 'button-' + theme;
  return (
    <button
      className={className}
      disabled={disabled}
      onClick={onClick}
    >
      {children}
    </button>
  );
}

```

#### Example 4 of 5: Extracting(提取) providers to a component 

As your app grows, it is expected that you’ll have a “pyramid(金字塔)” of contexts closer to the root of your app. 

There is nothing wrong with that. However, if you dislike the nesting aesthetically(审美上), you can extract the providers into a single component. 

In this example, `MyProviders` hides the “plumbing(管道)” and renders the children passed to it inside the necessary providers. 

 Note that the `theme` and `setTheme` state is needed in `MyApp` itself, so `MyApp` still owns that piece of the state.

```jsx
import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext(null);
const CurrentUserContext = createContext(null);

export default function MyApp() {
  const [theme, setTheme] = useState('light');
  return (
    <MyProviders theme={theme} setTheme={setTheme}>
      <WelcomePanel />
      <label>
        <input
          type="checkbox"
          checked={theme === 'dark'}
          onChange={(e) => {
            setTheme(e.target.checked ? 'dark' : 'light')
          }}
        />
        Use dark mode
      </label>
    </MyProviders>
  );
}

function MyProviders({ children, theme, setTheme }) {
  const [currentUser, setCurrentUser] = useState(null);
  return (
    <ThemeContext.Provider value={theme}>
      <CurrentUserContext.Provider
        value={{
          currentUser,
          setCurrentUser
        }}
      >
        {children}
      </CurrentUserContext.Provider>
    </ThemeContext.Provider>
  );
}

function WelcomePanel({ children }) {
  const {currentUser} = useContext(CurrentUserContext);
  return (
    <Panel title="Welcome">
      {currentUser !== null ?
        <Greeting /> :
        <LoginForm />
      }
    </Panel>
  );
}

function Greeting() {
  const {currentUser} = useContext(CurrentUserContext);
  return (
    <p>You logged in as {currentUser.name}.</p>
  )
}

function LoginForm() {
  const {setCurrentUser} = useContext(CurrentUserContext);
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const canLogin = firstName !== '' && lastName !== '';
  return (
    <>
      <label>
        First name{': '}
        <input
          required
          value={firstName}
          onChange={e => setFirstName(e.target.value)}
        />
      </label>
      <label>
        Last name{': '}
        <input
        required
          value={lastName}
          onChange={e => setLastName(e.target.value)}
        />
      </label>
      <Button
        disabled={!canLogin}
        onClick={() => {
          setCurrentUser({
            name: firstName + ' ' + lastName
          });
        }}
      >
        Log in
      </Button>
      {!canLogin && <i>Fill in both fields.</i>}
    </>
  );
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  const className = 'panel-' + theme;
  return (
    <section className={className}>
      <h1>{title}</h1>
      {children}
    </section>
  )
}

function Button({ children, disabled, onClick }) {
  const theme = useContext(ThemeContext);
  const className = 'button-' + theme;
  return (
    <button
      className={className}
      disabled={disabled}
      onClick={onClick}
    >
      {children}
    </button>
  );
}

```

#### Example 5 of 5: Scaling up(扩展) with context and a reducer 

In larger apps, it is common to combine context with a [reducer](https://react.dev/reference/react/useReducer) to extract the logic related to some state out of components. 

In this example, all the “wiring(连接?)” is hidden in the `TasksContext.js`, which contains a reducer and two separate(独立的) contexts.

Read a [full walkthrough](https://react.dev/learn/scaling-up-with-reducer-and-context)(完整步骤) of this example.

---

### Specifying(指定) a fallback(备用的) default value 

If React can’t find any providers of that particular context in the parent tree, the context value returned by `useContext()` will be equal to the default value that you specified when you [created that context](https://react.dev/reference/react/createContext):

```jsx
const ThemeContext = createContext(null);
```

The default value **never changes**. If you want to update context, use it with state as [described above.](https://react.dev/reference/react/useContext#updating-data-passed-via-context)(上述说明)

Often, instead of `null`, there is some more meaningful value you can use as a default, for example:

```jsx
const ThemeContext = createContext('light');
```

This way, if you accidentally render some component without a corresponding(相应的) provider, it won’t break(出错).

This also helps your components work well in a test environment without setting up a lot of providers in the tests.

In the example below, the “Toggle theme” button is always light because it’s **outside any theme context provider** and the default context theme value is `'light'`. Try editing the default theme to be `'dark'`.

```jsx
import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext('light');

export default function MyApp() {
  const [theme, setTheme] = useState('light');
  return (
    <>
      <ThemeContext.Provider value={theme}>
        <Form />
      </ThemeContext.Provider>
      <Button onClick={() => { //这里没包裹进去
        setTheme(theme === 'dark' ? 'light' : 'dark');
      }}>
        Toggle theme
      </Button>
    </>
  )
}

function Form({ children }) {
  return (
    <Panel title="Welcome">
      <Button>Sign up</Button>
      <Button>Log in</Button>
    </Panel>
  );
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  const className = 'panel-' + theme;
  return (
    <section className={className}>
      <h1>{title}</h1>
      {children}
    </section>
  )
}

function Button({ children, onClick }) {
  const theme = useContext(ThemeContext); //但是这里用了context,所以一直是light
  const className = 'button-' + theme;
  return (
    <button className={className} onClick={onClick}>
      {children}
    </button>
  );
}

```

---

### Overriding context for a part of the tree 

You can override the context for a part of the tree by wrapping that part in a provider with a different value.

```jsx
<ThemeContext.Provider value="dark">
  ...
  <ThemeContext.Provider value="light">
    <Footer />
  </ThemeContext.Provider>
  ...
</ThemeContext.Provider>
```

You can nest and override providers as many times as you need.

#### Examples of overriding context

#### Example 1 of 2: Overriding a theme 

Here, the button *inside* the `Footer` receives a different context value (`"light"`) than the buttons outside (`"dark"`).

```jsx
import { createContext, useContext } from 'react';

const ThemeContext = createContext(null);

export default function MyApp() {
  return (
    <ThemeContext.Provider value="dark"> //这里是dark
      <Form />
    </ThemeContext.Provider>
  )
}

function Form() {
  return (
    <Panel title="Welcome">
      <Button>Sign up</Button>
      <Button>Log in</Button>
      <ThemeContext.Provider value="light"> //这里是light
        <Footer />
      </ThemeContext.Provider>
    </Panel>
  );
}

function Footer() {
  return (
    <footer>
      <Button>Settings</Button>
    </footer>
  );
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  const className = 'panel-' + theme;
  return (
    <section className={className}>
      {title && <h1>{title}</h1>}
      {children}
    </section>
  )
}

function Button({ children }) {
  const theme = useContext(ThemeContext);
  const className = 'button-' + theme;
  return (
    <button className={className}>
      {children}
    </button>
  );
}

```

#### Example 2 of 2: Automatically nested headings (标题)

You can “accumulate(堆积)” information when you nest context providers. 

在这个例子中，Section组件跟踪LevelContext，该上下文指定了部分嵌套的深度。

It reads the LevelContext from the parent section, and provides the LevelContext number increased by one(数字加一) to its children.

As a result, the `Heading` component can automatically decide which of the `<h1>`, `<h2>`, `<h3>`, …, tags to use based on how many `Section` components it is nested inside of.

Read a [detailed walkthrough](https://react.dev/learn/passing-data-deeply-with-context) of this example.

---

### Optimizing re-renders when passing objects and functions 

You can pass any values via context, including objects and functions.

```jsx
function MyApp() {
  const [currentUser, setCurrentUser] = useState(null);

  function login(response) {
    storeCredentials(response.credentials);
    setCurrentUser(response.user);
  }

  return (
    <AuthContext.Provider value={{ currentUser, login }}>
      <Page />
    </AuthContext.Provider>
  );
}
```

Here, the context value is a JavaScript object with two properties, one of which is a function. 

Whenever `MyApp` re-renders (for example, on a route update), this will be a *different* object pointing at a *different* function, so React will also have to re-render all components deep in the tree that call `useContext(AuthContext)`.

In smaller apps, this is not a problem. However, there is no need to re-render them if the underlying(底层) data, like `currentUser`, has not changed. 

To help React take advantage of(充分利用) that fact, you may wrap the `login` function with [`useCallback`](https://react.dev/reference/react/useCallback) and wrap the object creation into [`useMemo`](https://react.dev/reference/react/useMemo). 

This is a performance optimization:

```jsx
import { useCallback, useMemo } from 'react';

function MyApp() {
  const [currentUser, setCurrentUser] = useState(null);

  const login = useCallback((response) => {
    storeCredentials(response.credentials);
    setCurrentUser(response.user);
  }, []);

  const contextValue = useMemo(() => ({
    currentUser,
    login
  }), [currentUser, login]);

  return (
    <AuthContext.Provider value={contextValue}>
      <Page />
    </AuthContext.Provider>
  );
}
```

As a result of this change, even if `MyApp` needs to re-render, the components calling `useContext(AuthContext)` won’t need to re-render unless `currentUser` has changed.

Read more about [`useMemo`](https://react.dev/reference/react/useMemo#skipping-re-rendering-of-components) and [`useCallback`.](https://react.dev/reference/react/useCallback#skipping-re-rendering-of-components)

---

## Troubleshooting 

### My component doesn’t see the value from my provider 

There are a few common ways that this can happen:

1. You’re rendering `<SomeContext.Provider>` in the same component (or below) as where you’re calling `useContext()`. Move `<SomeContext.Provider>` *above and outside* the component calling `useContext()`.

2. You may have forgotten to wrap your component with `<SomeContext.Provider>`, or you might have put it in a different part of the tree than you thought. Check whether the hierarchy(结构层次) is right using [React DevTools.](https://react.dev/learn/react-developer-tools)

3. 您可能在工具设置方面遇到了一些构建问题，导致提供组件看到的SomeContext和读取组件看到的SomeContext是两个不同的对象。

   这可能发生在你使用符号链接的情况下，例如.You can verify this by assigning them to globals like `window.SomeContext1` and `window.SomeContext2` and then checking whether `window.SomeContext1 === window.SomeContext2` in the console. If they’re not the same, fix that issue on the build tool level.

### I am always getting `undefined` from my context although the default value is different 

You might have a provider without a `value` in the tree:

```jsx
// 🚩 Doesn't work: no value prop
<ThemeContext.Provider>
   <Button />
</ThemeContext.Provider>
```

If you forget to specify `value`, it’s like passing `value={undefined}`.

You may have also mistakingly used a different prop name by mistake:

```jsx
// 🚩 Doesn't work: prop should be called "value"
<ThemeContext.Provider theme={theme}>
   <Button />
</ThemeContext.Provider>
```

In both of these cases you should see a warning from React in the console. To fix them, call the prop `value`:

```jsx
// ✅ Passing the value prop
<ThemeContext.Provider value={theme}>
   <Button />
</ThemeContext.Provider>
```

Note that the [default value from your `createContext(defaultValue)` call](https://react.dev/reference/react/useContext#specifying-a-fallback-default-value) is only used **if there is no matching provider above at all.**

If there is a `<SomeContext.Provider value={undefined}>` component somewhere in the parent tree, the component calling `useContext(SomeContext)` *will* receive `undefined` as the context value.
