```js
var dailyTemperatures = function(temperatures) {
    let result = new Array(temperatures.length).fill(0);
    let stack = [];
    for(let i = 0; i < temperatures.length; i++){
        while(stack.length && temperatures[i] > temperatures[stack[stack.length - 1]]){
            let prev = stack.pop()
            result[prev] = i - prev
        }
        stack.push(i)
    }
    return result
};
```

