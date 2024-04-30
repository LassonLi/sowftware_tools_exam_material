```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>js_dom</title>
</head>

<body>
    <div id="box1">这是一个ID选择器标签</div>
    <div class="box2">这是一个类选择器标签</div>
    <div>普通div标签</div>
    <button>点击按钮</button>

    <script>
        //只有这个返回单个
        var element_id = document.getElementById("box1");
        console.log(element_id);
        //返回数组
        var element_class = document.getElementsByClassName("box2")[0];
        console.log((element_class));
        //返回数组
        var element = document.getElementsByTagName("div");
        console.log(element);
        //修改标签内容及样式
        //下面这两行代码可以修改前两个div的内容
        //innerHTML、innerText不同之处在于html会做语义分析，下面这个会替换成百度超链接
        element_id.innerHTML = '<a href="www.baidu.com">百度</a>';
        //这个会输出<a href="www.baidu.com">百度</a>的文本
        element_class.innerText = '<a href="www.baidu.com">百度</a>';
        element_class.style.fontSize = "50px"

        //DOM属性绑定事件
        var button_element = document.getElementsByTagName('button')[0];
        console.log(button_element);
      	
      	// 以下两种写法效果相同
        button_element.onclick = function () {
            alert("按钮被点击");
        }
        
        button_element.addEventListener("click",function(){alert("button is click")})
    </script>
</body>

</html>
```

一个dom详解：

```html
<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple DOM example</title>
</head>

<body>
    <section>
        <img src="dinosaur.png"
            alt="A red Tyrannosaurus Rex: A two legged dinosaur standing upright like a human, with small arms, and a large head with lots of sharp teeth.">
        <p>Here we will add a link to the <a href="https://www.mozilla.org/">Mozilla homepage</a></p>
    </section>
    <script>
        //选择一个元素并用变量存储
        const link = document.querySelector("a");
        //修改该元素的文本内容
        link.textContent = "Mozilla Developer Network";
        //修改该元素的链接
        link.href = "https://developer.mozilla.org";
        //选择sec这个元素，默认选择第一个， Document.querySelectorAll()会返回一个选择器数组，需要自己加下标
        const sect = document.querySelector("section");
        //创建一个新的节点
        const para = document.createElement("p");
        //赋予文本
        para.textContent = "We hope you enjoyed the ride.";
        //将新段落追加到sec
        sect.appendChild(para);
        //创建一个文本节点
        const text = document.createTextNode(
            " — the premier source for web development knowledge.",
        );
        //获取内部链接的段落，会获取script上面的，不是里面的
        const linkPara = document.querySelector("p");
        //把文本节点加上去
        linkPara.appendChild(text);
      	
      	//把下面这行代码用起来，就会有图二的效果
        //sect.appendChild(linkPara);
      	
      
      	//在执行了sect.appendChild(linkPara)后，这两行效果相同，linkPara.remove()可以在
      	//sect.appendChild(linkPara)之前执行
      	//linkPara.remove();
        //sect.removeChild(linkPara);

    </script>
</body>

</html>
```

![image-20240412114614293](https://p.ipic.vip/jvgepn.png)

![image-20240412114713327](https://p.ipic.vip/3g3u58.png)