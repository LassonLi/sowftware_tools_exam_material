```js
class Animal{
    species;
    constructor(species){
        this.species = species;
    }
    speak(){console.log("I'm animal");}
}
class Dog extends Animal{
    name;
    constructor(species,name){
        super(species);
        this.name = name;
    }
    speak(){console.log(this.name +": I'm dog");}
}
class Cat extends Animal{
    name;
    constructor(species,name){
        super(species);
        this.name = name;
    }
    speak(){console.log(this.name +": I'm cat");}
}
//这个可以给父类增加属性，且子类都会拥有
Animal.prototype.position = "China";

const joe = new Dog('dog',"bandian");
const bob = new Cat('cat',"kimi");
console.log(joe.position);		//输出China
console.log(bob.position);		//输出China

//这是js的对象，直接访问
const data = {
    name:"Mak",
    gender:"male"
}
console.log(data.gender);		//输出male

//还可以用函数构造对象
function Catt(name){
    this.name = name;
}
var cat = new Catt("kitty");
console.log(cat.name);
```

