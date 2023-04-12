```js
function timeout(ms, promise) {
    return new Promise((resolve, reject) => {
        const timer = setTimeout(() => { //关键在这里
            reject(new Error('Promise timed out'));
        }, ms);

        promise.then(value => {
            clearTimeout(timer);
            resolve(value);
        }, reason => {
            clearTimeout(timer);
            reject(reason);
        });
    });
}

const promise = new Promise((resolve, reject) => {
    // 异步操作
});

timeout(5000, promise).then(value => {
    // 操作成功
}).catch(error => {
    // 操作失败或超时
});

```

```js
const xhr = new XMLHttpRequest();
xhr.open('GET', '/api/data');
xhr.timeout = 5000; // 设置超时时间为 5 秒
xhr.onload = function() {
    // 请求成功
};
xhr.ontimeout = function() { //关键在这里
    // 请求超时
};
xhr.onerror = function() {
    // 请求出错
};
xhr.send();

```

