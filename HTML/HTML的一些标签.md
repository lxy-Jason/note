```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
 
<body>
</body>
  
</html>
```

### 每一行的作用

1. 声明文档规范为HTML5,按照HTML5的规范来解析文档,这个不算html标签
2. lang属性,表明网页是使用的什么语言,一般是给搜索引擎识别是什么语言的站点,如果语言和浏览器设置的语言不同,浏览器会提示翻译
3. head标签,存在一些网页页面的信息,不会显示在页面上
4. meta标签声明关于页面的一些信息,这里表示文档字符编码用的是UTF-8
5. viewport视口,这相当于一个虚拟的窗口,这个虚拟的窗口一般比屏幕宽,这样没进行移动端适配的网页就可以以pc端的布局展示其中的一部分,通过缩放展示其他部分的内容
6. 页面的标题,浏览器的tag处展示 

### Meta标签

1. charset：指定文档使用的字符编码。例如，`<meta charset="UTF-8">`表示文档使用UTF-8编码。
2. name和content：用于指定各种元数据的名称和值。常见的属性包括：
   - name="viewport"：用于控制页面在移动设备上的视口（viewport）大小和缩放行为。例如，`<meta name="viewport" content="width=device-width, initial-scale=1.0">`指定视口宽度与设备宽度一致，并且初始缩放比例为1.0。
   - name="keywords"：定义页面的关键字，用于搜索引擎优化（SEO）。
   - name="description"：描述页面内容的简短摘要，也用于SEO。
   - name="author"：指定页面的作者。
   - name="robots"：指定搜索引擎爬虫对页面的处理方式，如`<meta name="robots" content="index, follow">`表示允许爬虫索引并跟踪页面内容。
3. http-equiv和content：用于模拟HTTP响应头字段，常见的属性包括：
   - http-equiv="refresh"：指定页面自动刷新的时间间隔，例如`<meta http-equiv="refresh" content="5; URL=http://example.com">`表示5秒后自动刷新到指定URL。
   - http-equiv="X-UA-Compatible"：指定浏览器使用的渲染模式，例如`<meta http-equiv="X-UA-Compatible" content="IE=edge">`表示强制IE浏览器使用最新的渲染引擎。
4. property和content：用于指定Open Graph协议的元数据，用于在社交媒体上分享网页内容时显示预览信息。例如，`<meta property="og:title" content="Page Title">`指定分享时的标题。