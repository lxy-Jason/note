```html
<!--
 * @Author: xiangyue_li
 * @Date: 2023-07-07 11:33:43
 * @LastEditors: xiangyue_li
-->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <style>

  </style>
</head>

<body>
  <div >
    <input type="checkbox" class="all">全选</input>
    <ul>
      <li><input type="checkbox">1</li>
      <li><input type="checkbox">1</li>
      <li><input type="checkbox">1</li>
      <li><input type="checkbox">1</li>
      <li><input type="checkbox">1</li>
    </ul>
  </div>
    <script>
      let allCheck = document.querySelector('.all')
      let ul = document.querySelector('ul')
      let checkboxs = Array.from(ul.querySelectorAll('input'))
      console.log(allCheck);
      console.log(checkboxs);
      allCheck.addEventListener('change',(e) => {
        console.log(e);
       
        checkboxs.forEach(item => {
          item.checked = e.target.checked
        })
        console.log(checkboxs)
      })
      ul.addEventListener('click',(e) => {
        console.log(checkboxs)
        allCheck.checked = checkboxs.every(item => item.checked === true)
      })
    </script>
</body>

</html>
```

