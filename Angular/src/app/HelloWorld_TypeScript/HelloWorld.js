function helloPeople(person) {
    return ("Hello " + person.name + ", you have " + person.money + "$!");
}
function createPeople(name, money) {
    var person = new Person();
    person.name = name;
    person.money = money;
    return person;
}
var Person = (function () {
    function Person() {
    }
    return Person;
}());
var person = createPeople('Jean-Michel', 155);
document.body.innerHTML = helloPeople(person);
