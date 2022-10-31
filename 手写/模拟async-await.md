```js
function generatorToAsync(generatorFn){
  return function() {
    const gen = generatorFn.apply(this,arguments) //有可能传参

    //返回一个promise
    return new Promise((resolve,reject) => {
      function go(key,arg){
        let res;
        try{
          res = gen[key](arg) //这里有可能执行返回reject状态的Promise
        }
        catch(err){
          return reject(err)
        } 

        //解构获得value和done
        const {value,done} = res
        if(done){ //执行完毕
          return resolve(value) 
        }
        else{
          //还没完成
          //value可能是常量,promise
          return Promise.resolve(value).then(val => go("next",val),err => go("throw",err))
        }
      }
      go("next") //第一次执行
    })
  }
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
const genToAsync = generatorToAsync(gen)
const asyncRes = genToAsync()
console.log(asyncRes) // Promise
asyncRes.then(res => console.log(res)) // 8

async function asyncFn() {
  const num1 = await fn(1)
  console.log(num1) // 2
  const num2 = await fn(num1)
  console.log(num2) // 4
  const num3 = await fn(num2)
  console.log(num3) // 8
  return num3
}


```

