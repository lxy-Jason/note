```js
Promise.myAllSettled = function(proms) {
  return new Promise((resolve,reject) => {
    let settledCount = 0; //状态确定的promise数
    let count = 0; //promise总数
    let result = [];
    
    for(const prom of proms){
      let index = count;
      count++
      Promise.resolve(prom).then(data => {
        settledCount++
        result[index] = {
          status:'fullfilled',
          value:data
        }
      }).catch(err => {
        settledCount++
        result[index] = {
          status:'rejected',
          value:err
        }
      }).finally(() => {
        if(settledCount === count){
          resolve(result)
        }
      })
    }
  }) 
}

const pro = new Promise((resolve, reject) => {
  setTimeout(() => {
    reject(3);
  }, 1000);
});

Promise.allSettled([pro, Promise.resolve(1), Promise.reject(2)]).then(
  (data) => {
    console.log(data);
  }
);

Promise.myAllSettled([pro, Promise.resolve(1), Promise.reject(2)]).then(
  (data) => {
    console.log(data);
  }
);

```

