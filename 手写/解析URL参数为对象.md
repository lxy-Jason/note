```js
function parseParam(url) {
  const paramsStr = /.+\?(.+)$/.exec(url)[1]; //将?后面的字符串取出 .+表示匹配任意多个字符
  const paramsArr = paramsStr.split("&");
  let paramsObj = {};
  //将params存入对象
  paramsArr.forEach((param) => {
    if (/=/.test(param)) {
      //处理有value的参数
      let [key, val] = param.split("=");
      val = decodeURIComponent(val); //解码
      val = /^\d+$/.test(val) ? parseFloat(val) : val; //判断是否转为数字

      if (paramsObj.hasOwnProperty(key)) {
        //如果对象有key,则添加一个值,value就是一个数组了
        paramsObj[key] = [].concat(paramsObj[key],val);
      }
      else{
        //没有就设置并赋值
        paramsObj[key] = val
      }
    }
    else{
        //没有value的情况
        paramsObj[param] = true
    }
  });
  return paramsObj
}
console.log(parseParam("https://www.bing.com/search?q=%E6%AD%A3%E5%88%99.%2B&form=ANSPH1&refig=11a81e739b784fd9aaa4654303ab72e0&pc=U531"));
```

