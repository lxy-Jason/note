```js
function asyncToGenerator(generatorFunc) {//传入一个生成器函数
  //返回一个新的函数
  return function () {
    //先调用generator函数生成<迭代器>
    const gen = generatorFunc.apply(this, arguments);
    //返回一个promise
    return new Promise((resolve, reject) => {
      //内部定义一个step函数来源 用来一步步跨过yield的阻碍
      //key有next和throw两种取值,分别对应了gen的next和throw方法
      //arg参数则是用来promise resolve得带的值交给下一个yield
      function step(key, arg) {
        let generatorResult;

        try {
          generatorResult = gen[key](arg);
        } catch (err) {
          return reject(err);
        }
        //gen.next()得到的结果是一个{value,done}的结构
        const { value, done } = generatorResult;
        if (done) {
          //已经完成
          return resolve(value);
        } else {
          return Promise.resolve( //对value不是promise的情况包裹一层
            value //这个value对应的是yield后面的promise
          ).then(res => {
            step("next",res)
          }).catch(err => {
            step("throw",err)
          })
        }
      }
      step("next"); //第一次调用next
    });
  };
}
function fn(nums) {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve(nums * 2)
      }, 1000)
    })
  }
function* gen() {
    const num1 = yield fn(1)
    console.log(num1) // 2
    const num2 = yield fn(num1)
    console.log(num2) // 4
    const num3 = yield fn(num2)
    console.log(num3) // 8
    return num3
  }
const testGAsync = asyncToGenerator(gen);
//返回的是一个函数,函数调用返回一个promise
testGAsync().then(res => {
    console.log(res);
});

//对应上面的gen()
async function asyncFn() {
  const num1 = await fn(1)
  console.log(num1) // 2
  const num2 = await fn(num1)
  console.log(num2) // 4
  const num3 = await fn(num2)
  console.log(num3) // 8
  return num3
}
asyncFn()

```

