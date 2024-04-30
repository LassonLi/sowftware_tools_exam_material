1、与css类似，js可以嵌在html文件中，也可以单独写出来，嵌在html中可以放在body或head内。

2、嵌套在html文件中的js代码放在<script>标签中

3、用var和let声明变量的区别：

先使用一个变量在var，会报undifined，先使用一个变量再let，会报ReferenceError: Cannot access 'y' before initialization。var可以变量提升，let不可以。

将一个变量赋值为null，表示该变量被赋为空，打印出来就是null，let或var一个变量不赋值该变量打印就是undifined（应该理解为未赋值）

```js
// 使用 var 声明变量
function varExample() {
    console.log(x); // undefined，变量提升，但尚未赋值
    var x = 10; // 变量声明和赋值
    console.log(x); // 10
    if (true) {
        var x = 20; // 变量重复声明
        console.log(x); // 20，覆盖了外部变量
    }
    console.log(x); // 20，覆盖了外部变量
}
varExample();

// 使用 let 声明变量
function letExample() {
    // console.log(y); // ReferenceError: Cannot access 'y' before initialization，因为没有变量提升
    let y = 10; // 变量声明和赋值
    console.log(y); // 10
    if (true) {
        let y = 20; // 不同作用域内的不同变量
        console.log(y); // 20，不同作用域内的变量，不会影响外部变量
    }
    console.log(y); // 10，不同作用域内的变量，不会影响外部变量
}
letExample();

```

优先使用let，更安全

![image-20240411155303889](/Users/maijianzhao/Library/Application Support/typora-user-images/image-20240411155303889.png)

左图会把var a = 10提升到函数声明之前，这就是变量提升，a是全局变量，所以first可以调用。右图没有声明变量直接用，会直接报错。同时也能看出first能接触到自己和比自己更高级的变量，但是接触不到自己的子函数的变量。

# ==和===

==会进行类型转换再比较数值，===不会做类型转换，即==只比较数值，===先比较类型后比较数值(还会比较对象地址)

```js
console.log(5 == "5"); // true，类型转换后值相等
console.log(5 === "5"); // false，类型不同
console.log(0 == false); // true，类型转换后值相等
console.log(0 === false); // false，类型不同
console.log(null == undefined); // true，特殊情况下相等
console.log(null === undefined); // false，类型不同
console.log(3.0===3); //true
console.log(3.0==3); //true
```

## 数组与for循环

```js
var myname = ['John', 'Doe', 'OpenAI'];

// 使用 for...in 遍历数组索引
for (var index in myname) {
    console.log(index); // 输出数组索引 0, 1, 2
}

// 使用 for...of 遍历数组元素
for (var element of myname) {
    console.log(element); // 输出数组元素 John, Doe, OpenAI
}

```

## map函数及匿名函数

```js
//这个函数实现数组内每个元素+120的功能，map会遍历数组，对每个元素执行(function (any) {return any + 120;})
var myname = [100, 1, 5];        
myname = myname.map(function (any) {
    return any + 120;
})

//这个函数会打印myname
(function(){console.log(myname);})();

//这个函数会让john变成“John120”
var myname = [100, "john", 5];        
myname = myname.map(function (any) {
    return any + 120;
})

```

## arrow function

```js
// 标准箭头函数
const sum = (a, b) => {
    return a + b;
};

// 简化形式，只有一个参数和一个返回值时可以省略括号和大括号
const double = num => num * 2;

// 箭头函数作为回调函数
const numbers = [1, 2, 3];
const doubledNumbers = numbers.map(num => num * 2);

// 箭头函数在对象方法中的应用
const person = {
    name: "John",
    sayHi: () => {
        console.log("Hi, I'm " + this.name); // 这里的 this 指向全局对象，而不是 person 对象
    },
    sayHello() {
        console.log("Hello, I'm " + this.name); // 正常函数声明方式中的 this 指向 person 对象
    }
};

```

# event事件

![image-20240411163907785](https://p.ipic.vip/55qwvi.png)

+号后面的内容就是button的内容，所以会分别输出you clicked on button1/you clicked on button2

