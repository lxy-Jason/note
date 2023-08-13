实现一个sleep(t)方法，await该方法后等待指定时间t再执行后面的代码

```js
function sleep(t) {
  return new Promise(resolve => setTimeout(resolve, t));
}

async function main() {
  console.log('开始执行');
  await sleep(2000); // 等待2秒钟
  console.log('等待结束，继续执行');
}

main();

```

