# JSON

### Json basic 

![image-20240411194407686](https://p.ipic.vip/6g5exm.png)

一个简单的json对象：

```json
const data = {
    "name":"Mak",
    "gender":"male",
    "language":["Chinese","Cantonese","English"]
}
```



```json
//创建一个js对象并转化成json
const data = {
    name:"Mak",
    gender:"male",
    language:["Chinese","Cantonese","English"]
}
const myjson = JSON.stringify(data);
```

parse将json格式的字符串变为js对象，stringify将js对象变成json格式的字符串

```js
async function populate() {
  const requestURL =
    "https://mdn.github.io/learning-area/javascript/oojs/json/superheroes.json";
  const request = new Request(requestURL);

  const response = await fetch(request);
  const superHeroesText = await response.text();

  const superHeroes = JSON.parse(superHeroesText);
  populateHeader(superHeroes);
  populateHeroes(superHeroes);
}


let myObj = { name: "Chris", age: 38 };
myObj;
let myString = JSON.stringify(myObj);
myString;

```

