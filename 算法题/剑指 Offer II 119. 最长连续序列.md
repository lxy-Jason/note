```js
/**
 * @param {number[]} nums
 * @return {number}
 */
var longestConsecutive = function(nums) {
    if(!nums.length) return 0;
    nums.sort((a,b) => a-b);
    let max = 1;
    const n = nums.length;
    const dp = new Array(n).fill(1); //注意这里初始化为1

    for(let i = 1; i < nums.length; i++){
        if(nums[i] === nums[i-1] + 1){
            dp[i] = dp[i-1] + 1
        }
        else if(nums[i] === nums[i-1]){
            dp[i] = dp[i-1];
        }
        max = Math.max(max,dp[i]);
    }
    return max;
};
```

