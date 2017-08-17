import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, Params } from '@angular/router';
import { PokemonsService } from './pokemons.service';
import { Pokemon } from './pokemon';

@Component({
  selector: 'app-detail-component',
  templateUrl: '../templates/detail-pokemon.component.html',
})
export class DetailPokemonComponent implements OnInit {
  pokemon: Pokemon = null;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private pokemonsService: PokemonsService
  ) {}

  ngOnInit(): void {
    this.route.params.forEach((params: Params) => {
      const id = +params['id'];
      this.pokemon = this.pokemonsService.getPokemon(id);
    });
  }

  goBack(): void {
    this.router.navigate(['/pokemons']);
  }

  goEdit(pokemon: Pokemon): void {
    const link = ['/pokemon/edit', pokemon.id];
    this.router.navigate(link);
    console.log(link);
  }
}
