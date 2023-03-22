```js
/**
 * @param {number[]} arr
 * @return {number}
 */
var peakIndexInMountainArray = function(arr) {
    let left = 0, right = arr.length - 1
    let ans = 0
    while(left <= right){
        const mid = (left + right) >> 1
        if(arr[mid] > arr[mid + 1]){
            ans = mid
            right = mid - 1
        }
        else{
            left = mid + 1
        }
    }
    return ans
};
```

