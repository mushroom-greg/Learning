import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { PokemonsService } from './pokemons.service';
import { Pokemon } from './pokemon';

@Component({
  selector: 'app-list-pokemon',
  templateUrl: '../templates/list-pokemon.component.html',
})
export class ListPokemonComponent implements OnInit {
  pokemons: Pokemon[];
  idValue: string = 'Survole un pokémon pour afficher son id.';

  constructor(
    private router: Router,
    private pokemonsService: PokemonsService
  ) {}

  ngOnInit(): void {
  this.getPokemons();
  }

  getPokemons(): void {
    this.pokemons = this.pokemonsService.getPokemons();
  }

  selectPokemon(pokemon: Pokemon) {
    console.log(`Vous avez sélectionné ${pokemon.name}.`);
    const link = ['/pokemon', pokemon.id];
    this.router.navigate(link);
  }

  showId(pokemon: Pokemon) {
    this.idValue = `L'id de ${pokemon.name} est: ${pokemon.id}.`;
  }

  hidId() {
    this.idValue = 'Survole un pokémon pour afficher son id.';
  }
}
