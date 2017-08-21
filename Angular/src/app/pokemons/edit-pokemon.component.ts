import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Pokemon } from './pokemon';
import { PokemonsService } from './pokemons.service';

@Component({
  selector: 'app-edit-pokemon',
  templateUrl: '../templates/edit-pokemon.component.html'
})
export class EditPokemonComponent implements OnInit {
  pokemon: Pokemon = null;

  constructor(
    private route: ActivatedRoute,
    private pokemonsService: PokemonsService
  ) {}

  ngOnInit(): void {
    const id = +this.route.snapshot.params['id'];
    this.pokemonsService.getPokemon(id).then(pokemon => this.pokemon = pokemon);
  }
}
