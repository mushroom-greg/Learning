import { Injectable } from '@angular/core';
import { Pokemon } from './pokemon';
import { POKEMONS } from './mocks-pokemons';

@Injectable()
export class PokemonsService {
  getPokemons(): Pokemon[] {
    return POKEMONS;
  }

  getPokemon(id: number): Pokemon {
    const pokemons = this.getPokemons();
    const len = pokemons.length;

    for (let i = 0; i < len; i++) {
      if (pokemons[i].id === id) {
        return pokemons[i];
      }
    }
  }

  getPokemonTypes(): Array<string> {
    return [
      'Plante', 'Feu', 'Eau', 'Insecte', 'Normal', 'Electrik',
      'Poison', 'Fée', 'Vol', 'Combat', 'Psy'
    ]
  }
}
