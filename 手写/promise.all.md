```js
function promiseAll (args) { //输入不限定于Array 但是得有iterable
    return new Promise((resolve,reject) => {
        const promiseResults = []
        let iteratorIndex = 0;

        //已经完成的数量,用于最终返回
        let fullCount = 0;

        for(const item of args){
            let resultIndex = iteratorIndex;
            iteratorIndex++
            //包一层,用来兼容非promise的情况
            Promise.resolve(item).then(res => {
                promiseResults[resultIndex] = res
                fullCount++

                if(fullCount === iteratorIndex){
                    // 全部完成
                    resolve(promiseResults)
                }
            }).catch(err => {
                reject(err)
            })
        }
        //处理空 iterator 的情况
        if(iteratorIndex === 0){
            resolve(promiseResults)
        }
    })
}
```

测试

```js
let p1 = new Promise(resolve => {
    resolve(1)
})
let p2 = new Promise(resolve => {
    resolve(2)
})
let p3 = new Promise((resolve,reject) => {
    reject(3)
})

promiseAll([p1,p2,p3]).then(res => {
    console.log(res);
}).catch(err => {
    console.log(err);
})
```



