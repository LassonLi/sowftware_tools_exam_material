简单的callback

```js
function first(callback) {
    console.log("first");
    callback();
}
function second() {
    console.log("second");
}
first(second);
//first
//second
```

无聊的调用

```js
setTimeout(function () {
    console.log('I will come 5 secs late1');
    setTimeout(function () {
        console.log('I will come 5 secs late2');
        setTimeout(function () {
            console.log('I will come 5 secs late3');
        }, 5000)
    }, 5000)
}, 5000)
//I will come 5 secs late1
//I will come 5 secs late2
//I will come 5 secs late3
```

```js
//使用forEach可以调用callback然后打印下标和值
const arr = [23,45,67,89];
arr.forEach((value,index,abc)=>{
    console.log("index: " + index + " value: " + value);
});
```

## promise

```js
const link = "https://api.github.com/users/parthadc9";
const response = fetch(link);

response.then(function(data){
    console.log(data);
})

//then函数也会返回一个promise
response.then(function(response) {
    return response.json(); // 使用json()方法获取响应数据的JSON格式
}).then(function(data) {
    console.log(data); // 成功：输出获取到的响应数据
}).catch(function(error) {
    console.log(error); // 失败：处理请求失败的情况
});
```

## 错误捕获：

```js
const fetchPromise = fetch(
  "bad-scheme://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json",
);

//我们需要在尝试读取请求之前检查服务器是否接受并处理了该请求。我们将通过检查响应中的状态码来做到这一点，如果状态码不是“OK”，就抛出一个错误：
//Promise 对象提供了一个 catch() 方法来支持错误处理。这很像 then()：你调用它并传入一个处理函数。然后，当异步操作成功时，传递给 then() 的处理函数被调用，而当异步操作失败时，传递给 catch() 的处理函数被调用。
//如果将 catch() 添加到 Promise 链的末尾，它就可以在任何异步函数失败时被调用。于是，我们就可以将一个操作实现为几个连续的异步函数调用，并在一个地方处理所有错误。
fetchPromise
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP 请求错误：${response.status}`);
    }
    return response.json();
  })
  .then((json) => {
    console.log(json[0].name);
  })
  .catch((error) => {
    console.error(`无法获取产品列表：${error}`);
  });

```

# promise terminology

- **pending**: the promise has been created, and the asynchronous function it's associated with has not succeeded or failed yet. This is the state your promise is in when it's returned from a call to `fetch()`, and the request is still being made.
- **fulfilled**: the asynchronous function has succeeded. When a promise is fulfilled, its `then()` handler is called.
- **rejected**: the asynchronous function has failed. When a promise is rejected, its `catch()` handler is called.

## 合并使用多个promise：

- 

```js
const fetchPromise1 = fetch(
  "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json",
);
const fetchPromise2 = fetch(
  "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/not-found",
);
const fetchPromise3 = fetch(
  "https://mdn.github.io/learning-area/javascript/oojs/json/superheroes.json",
);

//由`Promise.all()`返回的 Promise：
//- 当且仅当数组中*所有*的 Promise 都被兑现时，才会通知 `then()` 处理函数并提供一个包含所有响应的数组，数组中响应的顺序与被传入 `all()` 的 Promise 的顺序相同。
//- 会被拒绝——如果数组中有*任何一个* Promise 被拒绝。此时，`catch()` 处理函数被调用，并提供被拒绝的 Promise 所抛出的错误。
Promise.all([fetchPromise1, fetchPromise2, fetchPromise3])
  .then((responses) => {
    for (const response of responses) {
      console.log(`${response.url}：${response.status}`);
    }
  })
  .catch((error) => {
    console.error(`获取失败：${error}`);
  });

//Promise.any()任意一个promise被兑现就会兑现，如果所有的 Promise 都被拒绝，它也会被拒绝。
Promise.any([fetchPromise1, fetchPromise2, fetchPromise3])
  .then((response) => {
    console.log(`${response.url}：${response.status}`);
  })
  .catch((error) => {
    console.error(`获取失败：${error}`);
  });

```

# await和async

在一个函数的开头添加 `async`，就可以使其成为一个异步函数。在异步函数中，你可以在调用一个返回 Promise 的函数之前使用 `await` 关键字。这使得代码在该点上等待，直到 Promise 被完成，这时 Promise 的响应被当作返回值，或者被拒绝的响应被作为错误抛出。

```js
async function fetchProducts() {
  try {
    // 在这一行之后，我们的函数将等待 `fetch()` 调用完成
    // 调用 `fetch()` 将返回一个“响应”或抛出一个错误
    const response = await fetch(
      "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json",
    );
    if (!response.ok) {
      throw new Error(`HTTP 请求错误：${response.status}`);
    }
    // 在这一行之后，我们的函数将等待 `response.json()` 的调用完成
    // `response.json()` 调用将返回 JSON 对象或抛出一个错误
    const json = await response.json();
    console.log(json[0].name);
  } catch (error) {
    console.error(`无法获取产品列表：${error}`);
  }
}

fetchProducts();

```

这里我们调用 `await fetch()`，我们的调用者得到的并不是 `Promise`，而是一个完整的 `Response` 对象，就好像 `fetch()` 是一个同步函数一样。

我们甚至可以使用 `try...catch` 块来处理错误，就像我们在写同步代码时一样。

但请注意，这个写法只在异步函数中起作用。异步函数总是返回一个 Pomise，所以要注意以下代码最后几行：

```js
async function fetchProducts() {
  try {
    const response = await fetch(
      "https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json",
    );
    if (!response.ok) {
      throw new Error(`HTTP 请求错误：${response.status}`);
    }
    const json = await response.json();
    return json;
  } catch (error) {
    console.error(`无法获取产品列表：${error}`);
  }
}

//用下面这两行
const jsonPromise = fetchProducts();
jsonPromise.then((json) => console.log(json[0].name));

//这是错的
const json = fetchProducts();
console.log(json[0].name); // json 是一个 Promise 对象，因此这句代码无法正常工作
```

### [Promise() 构造器](https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Asynchronous/Implementing_a_promise-based_API#promise_构造器)

我们的 `alarm()` 函数返回一个在定时器过期时才会被兑现的 `Promise`。它将会传递一个 "Wake up!" 消息到 `then()` 处理器中，也会在当调用者提供一个负延迟值时拒绝这个 promise。

这里的关键组件是 `Promise()` 构造器。`Promise()` 构造器使用单个函数作为参数。我们把这个函数称作`执行器`（executor）。当你创建一个新的 promise 的时候你需要实现这个执行器。

这个执行器本身采用两个参数，这两个参数都是函数，通常被称作 `resolve` 和 `reject`。在你的执行器实现里，你调用原始的异步函数。如果异步函数成功了，就调用 `resolve`，如果失败了，就调用 `reject`。如果执行器函数抛出了一个错误，`reject` 会被自动调用。你可以将任何类型的单个参数传递到 `resolve` 和 `reject` 中。

```js
function alarm(person, delay) {
  return new Promise((resolve, reject) => {
    if (delay < 0) {
      throw new Error("Alarm delay must not be negative");
    }
    window.setTimeout(() => {
      resolve(`Wake up, ${person}!`);
    }, delay);
  });
}

```

此函数创建并且返回一个新的 `Promise`。对于执行器中的 promise，我们：

- 检查 `delay`（延迟）是否为负数，如果是的话就抛出一个错误。
- 调用 `window.setTimeout()`，传递一个回调函数和 `delay`（延迟）。当计时器过期时回调会被调用，在回调函数内，我们调用了 `resolve`，并且传递了 `"Wake up!"` 消息。

## [使用 alarm() API](https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Asynchronous/Implementing_a_promise-based_API#使用_alarm_api)

这一部分同上一篇文章是相当相似的。我们可以调用 `alarm()`，在返回的 promise 中调用 `then()` 和 `catch()` 来设置 promise 兑现和拒绝状态的处理器。

```js
const name = document.querySelector("#name");
const delay = document.querySelector("#delay");
const button = document.querySelector("#set-alarm");
const output = document.querySelector("#output");

function alarm(person, delay) {
  return new Promise((resolve, reject) => {
    if (delay < 0) {
      throw new Error("Alarm delay must not be negative");
    }
    window.setTimeout(() => {
      resolve(`Wake up, ${person}!`);
    }, delay);
  });
}

button.addEventListener("click", () => {
  alarm(name.value, delay.value)
    .then((message) => (output.textContent = message))
    .catch((error) => (output.textContent = `Couldn't set alarm: ${error}`));
});

```

## [在 alarm() API 上使用 async 和 await](https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Asynchronous/Implementing_a_promise-based_API#在_alarm_api_上使用_async_和_await)

自从 `alarm()` 返回了一个 `Promise`，我们可以对它做任何我们可以对其他任何 promise 做的事情：`Promise.all()`，和 `async` / `await`：

```js
const name = document.querySelector("#name");
const delay = document.querySelector("#delay");
const button = document.querySelector("#set-alarm");
const output = document.querySelector("#output");

function alarm(person, delay) {
  return new Promise((resolve, reject) => {
    if (delay < 0) {
      throw new Error("Alarm delay must not be negative");
    }
    window.setTimeout(() => {
      resolve(`Wake up, ${person}!`);
    }, delay);
  });
}

button.addEventListener("click", async () => {
  try {
    const message = await alarm(name.value, delay.value);
    output.textContent = message;
  } catch (error) {
    output.textContent = `Couldn't set alarm: ${error}`;
  }
});

```

