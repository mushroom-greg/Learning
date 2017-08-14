function helloPeople(person) {
  return (`Hello ${person.name}, you have ${person.money}$!`);
}

class People {
  constructor(public name: string, public money: number) {};
}

function createPeople(name: string, money: number): People {
  let person = new People();

  return person;
}

let person = createPeople('Jean-Michel', 155);

document.body.innerHTML = helloPeople(person);
