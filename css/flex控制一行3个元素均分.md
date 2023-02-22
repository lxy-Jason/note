```scss
ul {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start; // 替代原先的space-between布局方式
  li {
    flex: 1;
    margin: 0 16px 16px 0; // 间隙控制
    width: calc(
      (100% - 32px) / 3 //
    ); // 这里的32px = (分布个数3-1)*间隙宽度16, 可以根据实际的分布个数和间隙区调整
    min-width: calc((100% - 32px) / 3); // 加入这两个后每个item的宽度就生效了
    max-width: calc((100% - 32px) / 3); // 加入这两个后每个item的宽度就生效了
    &:nth-child(3n) {
      // 去除第3n个的margin-right
      margin-right: 0;
    }
  }
```

