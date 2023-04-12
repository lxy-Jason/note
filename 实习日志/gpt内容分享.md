### 代码优化

优化前

```js
function quickSort (arr) {
if(arr.length <= 1) {
return arr
}
let pivotIndex = Math.floor(arr.length / 2);
let pivot = arr.splice(pivotIndex, 1)[0];
let left = []
let right = []

for(let i = 0; i < arr.length; i++){
    if(arr[i] < pivot) {
        left.push(arr[i])
    }
    else{
        right.push(arr[i])
    }
}
return quickSort(left).concat([pivot],quickSort(right))
}
```

对话过程

输入代码 -> 请帮我优化这段代码

**优化后**

```js
function quickSort(arr, leftIndex = 0, rightIndex = arr.length - 1) {
  if (leftIndex < rightIndex) { // 控制递归结束的条件
    const pivotIndex = partition(arr, leftIndex, rightIndex);
    quickSort(arr, leftIndex, pivotIndex - 1);
    quickSort(arr, pivotIndex + 1, rightIndex);
  }
  return arr;
}

function partition(arr, leftIndex, rightIndex) {
  const pivotIndex = Math.floor(Math.random() * (rightIndex - leftIndex + 1) + leftIndex); // 随机选择枢纽元素
  const pivot = arr[pivotIndex];
  swap(arr, pivotIndex, rightIndex); // 将枢纽元素交换到数组最后

  let i = leftIndex - 1;
  for (let j = leftIndex; j <= rightIndex - 1; j++) {
    if (arr[j] < pivot) {
      i++;
      swap(arr, i, j);
    }
  }
  swap(arr, i + 1, rightIndex); // 将枢纽元素放回正确的位置
  return i + 1; // 返回枢纽元素最终的位置
}

function swap(arr, i, j) {
  [arr[i], arr[j]] = [arr[j], arr[i]];
}

const arr = [3, 2, 1, 5, 4];
console.log(quickSort(arr)); // [1, 2, 3, 4, 5]

```

