An **arrow function expression** is a compact alternative to a traditional [function expression](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/function), with some semantic differences and deliberate limitations in usage:

- Arrow functions don't have their own [bindings](https://developer.mozilla.org/en-US/docs/Glossary/Binding) to [`this`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this), [`arguments`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments), or [`super`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/super), and should not be used as [methods](https://developer.mozilla.org/en-US/docs/Glossary/Method).
- Arrow functions cannot be used as [constructors](https://developer.mozilla.org/en-US/docs/Glossary/Constructor). Calling them with [`new`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new) throws a [`TypeError`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypeError). They also don't have access to the [`new.target`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new.target) keyword.
- Arrow functions cannot use [`yield`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/yield) within their body and cannot be created as generator functions.

箭头函数语法：

```js
() => expression

param => expression

(param) => expression

(param1, paramN) => expression

() => {
  statements
}

//只有一个参数才能省略括号，有多个参数、无参数、默认参数、重组参数或其余参数，则需要在参数列表周围加上括号
param => {
  statements
}

(param1, paramN) => {
  statements
}

//箭头函数可以是 async 的，方法是在表达式前加上 async 关键字。
async param => expression
async (param1, param2, ...paramN) => {
  statements
}

//Rest parameters（剩余参数，就是任意数量参数）, default parameters（默认参数）, and destructuring（解构赋值） within params are supported, and always require parentheses:
//剩余参数（Rest parameters）：
//箭头函数中可以使用剩余参数语法，即通过在函数参数列表中使用三个点 ... 来表示，后面跟着一个参数名，用于捕获函数调用时传递的多余的参数，并将其转换成一个数组。剩余参数通常在函数参数列表的末尾出现，并且只能出现一次。
const sum = (...args) => {
    return args.reduce((acc, curr) => acc + curr, 0);
};

console.log(sum(1, 2, 3, 4)); // 输出：10

//默认参数（Default parameters）：
//箭头函数中可以使用默认参数语法，在参数列表中为参数提供默认值，以防止在调用函数时未提供相应参数而导致错误。默认参数通常在函数参数列表的末尾出现，如果函数调用时未传递相应的参数，则会使用默认值。
const greet = (name = "World") => {
    return `Hello, ${name}!`;
};

console.log(greet()); // 输出：Hello, World!
console.log(greet("Alice")); // 输出：Hello, Alice!

//解构赋值（Destructuring assignment）：
//箭头函数中可以使用解构赋值语法，用于从函数参数中提取对象的属性或数组的元素，并将其赋值给变量。解构赋值可以使代码更简洁，同时提高可读性。
const printPerson = ({ name, age }) => {
    console.log(`Name: ${name}, Age: ${age}`);
};

const person = { name: "Alice", age: 30 };
printPerson(person); // 输出：Name: Alice, Age: 30

```

一个函数示例：

```js
//普通函数
function add(a){
		return a + 100;
}

//匿名函数
function(a){
  	return a + 100;
}

//箭头函数
(a)=>{return a + 100;}
```

# function body

箭头函数既可以使用*表达式体*（expression body），也可以使用通常的*块体*（block body）。

在表达式体中，只需指定一个表达式，它将成为隐式返回值。在块体中，必须使用显式的 `return` 语句。

```js
const func = (x) => x * x;
// 表达式体语法，隐含返回值

const func2 = (x, y) => {
  return x + y;
};
// 块体语法，需要明确返回值

```

使用表达式体语法 `(params) => { object: literal }` 返回对象字面量时，不能按预期工作。

```js
const func = () => { foo: 1 };
// 调用 func() 会返回 undefined！

const func2 = () => { foo: function () {} };
// SyntaxError: function statement requires a name

const func3 = () => { foo() {} };
// SyntaxError: Unexpected token '{'
```

这是因为只有当箭头后面的标记不是左括号时，JavaScript 才会将箭头函数视为表达式体，因此括号（{}）内的代码会被解析为一系列语句，其中 `foo` 是[标签](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/label)，而不是对象文字中的键。

要解决这个问题，可以用括号将对象字面量包装起来：

```js
const func = () => ({ foo: 1 });
```

箭头函数不能用作对象的方法，因为他们没有自己的this

```js
"use strict";

const obj = {
  i: 10,
  b: () => console.log(this.i, this),
  c() {
    console.log(this.i, this);
  },
};

obj.b(); // logs undefined, Window { /* … */ } (or the global object)
obj.c(); // logs 10, Object { /* … */ }
```


以下这段代码展示了在一个类中使用箭头函数的情况，并说明了箭头函数与普通函数在绑定 this 上的不同之处。

1. **类 `C` 的定义：**
   - 类 `C` 包含了一个属性 `a` 和一个箭头函数 `autoBoundMethod`。
   - 属性 `a` 被赋值为 `1`。
   - 箭头函数 `autoBoundMethod` 中使用了箭头函数语法，并且在函数体内部使用了 `this.a` 来访问类的属性 `a`。
2. **创建类的实例 `c`：**
   - 使用 `new` 关键字创建了类 `C` 的一个实例，并将其赋值给变量 `c`。
3. **调用实例方法 `autoBoundMethod`：**
   - 通过 `c.autoBoundMethod()` 调用了实例方法 `autoBoundMethod`，这时箭头函数中的 `this` 指向了实例 `c`，因此能够正确地输出属性 `a` 的值 `1`。
4. **解构赋值获取实例方法 `autoBoundMethod`：**
   - 使用解构赋值从实例 `c` 中获取了箭头函数 `autoBoundMethod`，并将其赋值给变量 `autoBoundMethod`。
   - 在这种情况下，箭头函数 `autoBoundMethod` 仍然能够正确地访问实例的属性 `a`，因为箭头函数的 `this` 始终指向它所在的词法作用域，而在这个例子中，箭头函数被定义在类 `C` 的作用域内，因此 `this` 始终指向类的实例。
5. **调用解构赋值得到的箭头函数 `autoBoundMethod`：**
   - 通过 `autoBoundMethod()` 调用了解构赋值得到的箭头函数 `autoBoundMethod`。
   - 和之前一样，箭头函数中的 `this` 仍然指向了类的实例 `c`，因此能够正确地输出属性 `a` 的值 `1`。

总的来说，箭头函数具有词法作用域的特性，其 `this` 始终指向函数定义时所在的词法作用域，而不受调用方式的影响。因此，在类的定义中使用箭头函数作为类的方法时，无论是直接调用还是通过解构赋值获取方法后调用，箭头函数中的 `this` 都会正确地指向类的实例。

```js
class C {
  a = 1;
  autoBoundMethod = () => {
    console.log(this.a);
  };
}

const c = new C();
c.autoBoundMethod(); // 1
const { autoBoundMethod } = c;
autoBoundMethod(); // 1
// If it were a normal method, it should be undefined in this case

```

### [没有参数绑定](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions#没有参数绑定)

箭头函数没有自己的 [`arguments`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments) 对象。因此，在本例中，`arguments` 是对外层作用域参数的引用：

```js
function foo(n,a) {
    const f = () => arguments[1] + n; // foo 的隐式参数绑定。arguments[0] 为 n,1为a
    return f();
  }
console.log(foo(4,5));//输出9
```

在大多数情况下，使用[剩余参数](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/rest_parameters)是比使用 `arguments` 对象更好的选择。

```js
function foo(n) {
  const f = (...args) => args[0] + n;
  return f(10);
}

foo(1); // 11

```

### [不能用作构造函数](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions#不能用作构造函数)

箭头函数不能用作构造函数，当使用 [`new`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/new) 调用时会出错。它们也没有 [`prototype`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/prototype) 属性。

```js
const Foo = () => {};
const foo = new Foo(); // TypeError: Foo is not a constructor
console.log("prototype" in Foo); // false

```

### [箭头前换行](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions#箭头前换行)

箭头函数的参数和箭头之间不能换行。

```js
const func = (a, b, c)
  => 1;
// SyntaxError: Unexpected token '=>'

//为便于格式化，可在箭头后换行，或在函数体周围使用括号/花括号，如下图所示。也可以在参数之间换行。
const func = (a, b, c) =>
  1;

const func2 = (a, b, c) => (
  1
);

const func3 = (a, b, c) => {
  return 1;
};

const func4 = (
  a,
  b,
  c,
) => 1;
```

### [箭头的优先级](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions#箭头的优先级)

虽然箭头函数中的箭头不是运算符，但与普通函数相比，箭头函数具有特殊的解析规则，与[运算符优先级](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Operator_precedence)的交互方式不同。

```js
let callback;

callback = callback || () => {};
// SyntaxError: invalid arrow-function arguments
```

由于 `=>` 的优先级低于大多数运算符，因此需要使用括号来避免 `callback || ()` 被解析为箭头函数的参数列表。

```js
callback = callback || (() => {});
```

一些使用示例

```js
// 空的箭头函数返回 undefined
const empty = () => {};

(() => "foobar")();
// 返回 "foobar"
// 这是一个立即执行函数表达式

const simple = (a) => (a > 15 ? 15 : a);
simple(16); // 15
simple(10); // 10

const max = (a, b) => (a > b ? a : b);

// 更方便进行数组的过滤、映射等工作
const arr = [5, 6, 13, 0, 1, 18, 23];

const sum = arr.reduce((a, b) => a + b);
// 66

const even = arr.filter((v) => v % 2 === 0);
// [6, 0, 18]

const double = arr.map((v) => v * 2);
// [10, 12, 26, 0, 2, 36, 46]

// 更简明的 promise 链
promise
  .then((a) => {
    // …
  })
  .then((b) => {
    // …
  });

// 无参数箭头函数在视觉上容易分析
setTimeout(() => {
  console.log("我发生更早");
  setTimeout(() => {
    // 深层次代码
    console.log("我发生更晚");
  }, 1);
}, 1);
```

### [使用 call、bind 和 apply](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions#使用_call、bind_和_apply)

[`call()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/call)、[`apply()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/apply) 和 [`bind()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Function/bind)方法与传统函数一样按照预期工作，因为我们为每个方法建立了作用域：

```js
const obj = {
  num: 100,
};

// 在 globalThis 上设置“num”，以显示它如何没有被使用到。
globalThis.num = 42;

// 对“this”进行操作的简单传统函数
const add = function (a, b, c) {
  return this.num + a + b + c;
};

console.log(add.call(obj, 1, 2, 3)); // 106
console.log(add.apply(obj, [1, 2, 3])); // 106
const boundAdd = add.bind(obj);
console.log(boundAdd(1, 2, 3)); // 106

//对于箭头函数，由于我们的 add 函数基本上是在 globalThis（全局）作用域上创建的，因此它会假定 this 就是 globalThis。
const obj = {
  num: 100,
};

// 在 globalThis 上设置“num”，以显示它是如何被接收到的。
globalThis.num = 42;

// 箭头函数
const add = (a, b, c) => this.num + a + b + c;

console.log(add.call(obj, 1, 2, 3)); // 48
console.log(add.apply(obj, [1, 2, 3])); // 48
const boundAdd = add.bind(obj);
console.log(boundAdd(1, 2, 3)); // 48

```

