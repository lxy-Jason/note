```js
/**
 * @param {number} n
 * @return {number}
 */
var fib = function(n) {
    if(n < 2) return n
    let n1 = 0, n2 = 1, sum;
    for(let i = 2; i <= n; i++){
        sum = (n1 + n2) % 1000000007;
        n1 = n2;
        n2 = sum;
    }
    return sum
};
```

