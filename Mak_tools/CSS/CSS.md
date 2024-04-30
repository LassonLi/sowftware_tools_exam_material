链接CSS文件：

```css
    <link rel="stylesheet" href="style.css">

```

普通的类用 .important{key1:value1;key2:value2}然后在标签中<p class="important"> test</p>就会显示对应属性

Id用 #开头，其余和上述保持一致

多个选择器用同一个规则，选择器之间用,分隔，如：

```css
h1,.test1{
	color:red
}
```

选择器列表某一个选择器失效时（如语法错误）则该列表所有选择器失效。

## 关系选择器：

```CSS
<!DOCTYPE html>
<head>
    <style>
        /* 样式注释：选择后代元素Descendant combinator 可以匹配嵌套的*/
        .container p {
            color: blue;
            /* 将所有 p 元素的文本颜色设置为蓝色 */
        }
        /* 样式注释：选择直接子元素 Child combinator 不可以匹配嵌套的*/
        .container>div {
            border: 2px solid black;
            /* 将直接子元素 div 元素的边框样式设置为实线黑色 */
            margin-bottom: 20px;
            /* 设置直接子元素 div 元素的下外边距为 20 像素 */
        }
        /* 样式注释：选择紧邻的兄弟元素  Next-sibling combinator*/
        p+div {
            background-color: yellow;
            /* 将紧邻 p 元素后的 div 元素的背景颜色设置为黄色 */
        }
        /* 样式注释：选择通用兄弟元素  Subsequent-sibling combinator*/
        h2~p {
            font-style: italic;
            /* 将 h2 元素后的所有 p 元素的文本样式设置为斜体 */
        }
    </style>
</head>
<div class="container">
    <div>
      <p>Paragraph 1</p>
      <div>
        <p>Paragraph 2</p>
        <span>Span 1</span>
      </div>
      <span>Span 2</span>
    </div>
    <div>
      <p>Paragraph 3</p>
      <div>
        <p>Paragraph 4</p>
        <span>Span 3</span>
      </div>
      <span>Span 4</span>
    </div>
  </div>
  
/*总结：.container p 所有后代可以嵌套 Descendant combinator
			 .container > p 所有子代，就只是次一级，不能嵌套 Child combinator
			 .container + p 同级紧跟的下一个，所以是 Next-sibling combinator
			 .container ~ p 同级以后的所有 Subsequent-sibling combinator

```

![image-20240409222957643](/Users/maijianzhao/Library/Application Support/typora-user-images/image-20240409222957643.png)

![image-20240409224550261](https://p.ipic.vip/46a2c5.png)

最后一个是不透明度

### Box model:

![image-20240409224721710](https://p.ipic.vip/7t968z.png)

box model各层的宽度如果统一设计，顺序是上右下左,宽度填一个参数表示全部，两个分别表示上下、左右，三个分别表示上、右左、下

# units of measurement

html默认字体大小16px

常用的绝对长度单位：

| 单位 | 名称         | 等价换算                 |
| :--- | :----------- | :----------------------- |
| `cm` | 厘米         | 1cm = 37.8px = 25.2/64in |
| `mm` | 毫米         | 1mm = 1/10th of 1cm      |
| `Q`  | 四分之一毫米 | 1Q = 1/40th of 1cm       |
| `in` | 英寸         | 1in = 2.54cm = 96px      |
| `pc` | 派卡         | 1pc = 1/6th of 1in       |
| `pt` | 点           | 1pt = 1/72th of 1in      |
| `px` | 像素         | 1px = 1/96th of 1in      |

相对长度单位

| 单位         | 相对于                                                       |
| :----------- | :----------------------------------------------------------- |
| `em`         | 在 `font-size` 中使用是相对于父元素的字体大小，在其他属性中使用是相对于自身的字体大小，如 `width`。 |
| `ex`         | 字符“x”的高度。                                              |
| `ch`         | 数字“0”的宽度。                                              |
| `rem`        | 相对根元素的字体大小，以html元素为对照，通常是16px。         |
| `lh`         | 元素的行高。                                                 |
| `rlh`        | 根元素的行高。当用于根元素的 `font-size` 或 `line-height` 属性时，它指的是这些属性的初始值。 |
| `vw`         | 视口宽度的 1%。                                              |
| `vh`         | 视口高度的 1%。                                              |
| `vmin`       | 视口较小尺寸的 1%。                                          |
| `vmax`       | 视口大尺寸的 1%。                                            |
| `vb`         | 在根元素的[块向](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_logical_properties_and_values#块向与行向)上，初始包含块的尺寸的 1%。 |
| `vi`         | 在根元素的[行向](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_logical_properties_and_values#块向与行向)上，初始包含块的尺寸的 1%。 |
| `svw`、`svh` | 分别为[视口较小尺寸](https://developer.mozilla.org/zh-CN/docs/Web/CSS/length#基于视口的相对长度单位)的宽度和高度的 1%。 |
| `lvw`、`lvh` | 分别为[视口大尺寸](https://developer.mozilla.org/zh-CN/docs/Web/CSS/length#基于视口的相对长度单位)的宽度和高度的 1%。 |
| `dvw`、`dvh` | 分别为[动态视口](https://developer.mozilla.org/zh-CN/docs/Web/CSS/length#基于视口的相对长度单位)的宽度和高度的 1%。 |

%百分比的问题在于，它们总是相对于其他值设置的。例如，如果将元素的字体大小设置为百分比，那么它将是元素父元素字体大小的百分比。如果使用百分比作为宽度值，那么它将是父值宽度的百分比。

虽然许多值接受长度或百分比，但也有一些值只接受长度。如果允许的值包括 <length-percentage>，则可以使用长度或百分比。如果允许的值只包含 `<length>`，则不可能使用百分比。

Opacity:不透明度 1完全不透明，0完全透明

```CSS
.one {
  background-color: rgb(2 121 139 / .3);
  background-color: rgba(2 121 139 0.3);
  /*二者效果相同*/

}
```

`hsl()` 函数不接受红、绿、蓝值，而是接受色相、饱和度和亮度值。

- **色调**：颜色的底色。这个值在 0 和 360 之间，表示 [color wheel (en-US)](https://developer.mozilla.org/en-US/docs/Glossary/Color_wheel) 周围的角度。
- **饱和度**：颜色有多饱和？它的值为 0–100%，其中 0 为无颜色（它将显示为灰色阴影），100% 为全色饱和度
- **亮度**：颜色有多亮？它从 0–100% 中获取一个值，其中 0 表示没有光（它将完全显示为黑色），100% 表示完全亮（它将完全显示为白色）
- hsl函数同样可以用来传递不透明度，用法与rgb相同

```css
.gradient {
  background-image: linear-gradient(0deg, rgb(219 0 255 / 100%), rgb(0 212 255 / 10%));
  /*这是一个渐变图形，linear-gradient是一个渐变函数，第一个参数是渐变开始的角度，0是正下方，90左，180上，270右，360与0相同，第二个参数是开始的颜色，第三个参数是结束的颜色*/
}
```

# Grid

```css
.container {
  display: grid;
  grid-template-columns: 200px 200px 200px;
  /*创建三列，每列宽度200px，这里可以用任何长度单位*/
}
.container {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
}

.container {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  /*创建三列，fr表示可用空间，这里会让第一列占一半，二、三列占25%*/
  gap: 20px;
  /*column-gap for gaps between columns
	row-gap for gaps between rows
	gap as a shorthand for both，gap可以用任何长度单位包括百分比来表示，但不能使用fr单位*/
  
}


```

可以使用`repeat`来重复构建具有某些宽度配置的某些列。举个例子，如果要创建多个等宽轨道，可以用下面的方法。

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 20px;
}
repeat(2, 2fr 1fr)等于 2fr 1fr 2fr 1fr
```

```css
grid-template-columns 和grid-template-rows创建显式网格
grid-auto-rows和grid-auto-columns创建隐式网格
```

[`minmax()`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/minmax) 函数为一个行/列的尺寸设置了取值范围。比如设定为 `minmax(100px, auto)`，那么尺寸就至少为 100 像素，并且如果内容尺寸大于 100 像素则会根据内容自动调整。在这里试一下把 `grid-auto-rows` 属性设置为`minmax`函数

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-auto-rows: minmax(100px, auto);
  grid-gap: 20px;
}

```

```CSS
.container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  grid-auto-rows: minmax(100px, auto);
  grid-gap: 20px;
}
/*自动多列填充，这里使用repeat+minmax，minmax表示每列至少200px，最大1fr，然后列数用auto-fill表示根据网页大小动态调整*/

```

Line-base placement

- [`grid-column-start`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-column-start)
- [`grid-column-end`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-column-end)
- [`grid-row-start`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-row-start)
- [`grid-row-end`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-row-end)

These properties accept line numbers as their values, so we can specify that an item should start on line 1 and end on line 3, for example. Alternatively, you can also use shorthand properties that let you specify the start and end lines simultaneously, separated by a forward slash `/`:

- [`grid-column`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-column) shorthand for `grid-column-start` and `grid-column-end`
- [`grid-row`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-row) shorthand for `grid-row-start` and `grid-row-end`

```css
header {
  /*等同于grid-column-start:1+grid-column-end:3 意义：第一行开始第二行结束，或者说在分成三行以后有4条线，header在第一条线和第三条线之间，即1-2行*/
  /*用span n表示横跨多少行/列，这种方式更灵活，可用于grid的通用属性，用分号指定位置更具体*/
  grid-column: 1 / 3;
  grid-row: 1;
}

article {
  grid-column: 2;   只写一个就代表在哪一列
  grid-row: 2;
}

aside {
  grid-column: 1;
  grid-row: 2;
}

footer {
  grid-column: 1 / 3;
  grid-row: 3;
}

```

## [使用 grid-template-areas 属性放置元素](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/CSS_layout/Grids#使用_grid-template-areas_属性放置元素)

另一种往网格放元素的方式是用[`grid-template-areas`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/grid-template-areas)属性，并且你要命名一些元素并在属性中使用这些名字作为一个区域。

```css
.container {
  display: grid;
  grid-template-areas:
    "header header"
    "sidebar content"
    "footer footer";
  grid-template-columns: 1fr 3fr;
  gap: 20px;
}

header {
  grid-area: header;
}

article {
  grid-area: content;
}

aside {
  grid-area: sidebar;
}

footer {
  grid-area: footer;
}
效果与line-base placement相同
/*grid-template-areas属性的使用规则如下：

你需要填满网格的每个格子
对于某个横跨多个格子的元素，重复写上那个元素grid-area属性定义的区域名字
所有名字只能出现在一个连续的区域，不能在不同的位置出现
一个连续的区域必须是一个矩形
使用.符号，让一个格子留空
*/
```

关于grid-area的补充：

```css
.item {
  grid-area: 1 / 2 / 3 / 4; /* 网格项跨越第1行到第2行，第2列到第3列 */
}

.item {
  grid-area: 2 / 1 / span 2 / span 3; /* 从第2行开始，跨越2行，从第1列开始，跨越3列 */
}

```

Media query：这个就是根据你设置的条件，当满足条件时，网页呈现的布局、样式会发生变化,简单例子：

```css
/*当窗口宽度至少为1000px时，字体为蓝色*/
@media screen and (min-width: 1000px) {
      body {
        color: red;
        font-size: 20px;
      }
    }
/*当窗口宽度至多为800px时，字体为红色*/
@media screen and (max-width: 800px) {
      body {
        color: blue;
        font-size: 25px;
      }
    }
800-1000px时如下，多条件链接用and
@media screen and (min-width:800px) and (max-width:1000px) {
      body{
        color: green;
        font-family: 'Courier New', Courier, monospace;
      }
    }
/*或逻辑用，分开*/
@media screen and (max-width: 600px) , screen and (min-width: 1000px){
      body {
        color: blue;
        font-size: 25px;
      }
    }
/*非逻辑，用not*/
@media screen and not (max-width: 600px) {
      body {
        color: blue;
        font-size: 25px;
      }
    }
```

orientation：朝向

```css
/*landscape横向，portrait竖向*/
@media (orientation: landscape) {
  body {
    color: rebeccapurple;
  }
}

```

