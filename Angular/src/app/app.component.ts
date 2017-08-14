import { Component, OnInit } from '@angular/core';
import { Pokemon } from './pokemon';
import { POKEMONS } from './mocks-pokemons';

@Component({
  selector: 'app-pkmn',
  templateUrl: '../templates/app.component.html',
})
export class AppComponent implements OnInit {

  pokemons: Pokemon[];
  idValue: string = 'Survole un pokémon pour afficher son id.';

  ngOnInit() {
    this.pokemons = POKEMONS;
  }

  selectPokemon(pokemon: Pokemon) {
    console.log(`Vous avez sélectionné ${pokemon.name}.`);
  }

  showId(pokemon: Pokemon) {
    this.idValue = `L'id de ${pokemon.name} est: ${pokemon.id}.`;
  }

  hidId() {
    this.idValue = 'Survole un pokémon pour afficher son id.';
  }

}
