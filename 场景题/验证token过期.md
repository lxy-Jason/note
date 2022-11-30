```js
const axios = require("axios");
const request = axios.create({
  baseURL: "",
  timeout: 1000,
});

request.interceptors.request.use((config) => {
  let token = localStorage.getItem("token"); //去拿token
  if (!token) {
    console.log("未登录");
  }
  config.headers.token = token;
  return config;
});
request.interceptors.response.use(
  (res) => {
    return res;
  },
  (err) => {
    if(err.response.code === 401){ //返回401表示未授权,就说明token过期
      console.log("未授权");
    }
  }
);
async function getData() {
  const res = await request.get("http://api.test.com");
}
getData();

```

