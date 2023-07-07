```js
function ajax(options){
  //创建XMLHttpRequest对象
  const xhr = new XMLHttpRequest()
  
  //初始化参数
  options = options || {};
  options.type = (options.type || "get").toUpperCase()
  options.dataType = options.dataType || "json"
  const params = options.data

  //发送请求
  if(options.type === "GET"){
    xhr.open("GET",options.url + '?' + params,true) //true表示异步执行
    xhr.send(null)
  }
  else if(options.tyep === "POST"){
    xhr.open('POST',options.url,true)
    xhr.send(params)
  }

  //接收请求
  xhr.onreadystatechange = function() {
    if(xhr.readyState === 4){
      let status = xhr.status
      if(status >= 200 && status < 300) {
        options.success && options.success(xhr.responseText,xhr.responseXML)
      }
      else{
        options.fail && options.fail(status)
      }
    }
  }
}
//使用
ajax({
  type:'get',
  dataType:'json',
  data:{},
  url:'',
  success:function(text,xml){
    //请求成功的回调
    console.log(text);
  },
  fail:function(status){
    //失败回调
    console.log(status);
  }
})
```

