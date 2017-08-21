import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs/Observable';
import { Subject } from 'rxjs/Subject';
import { PokemonSearchService } from './pokemon-search.service';
import { Pokemon } from './pokemon';

@Component({
  selector: 'app-pokemon-search',
  templateUrl: '../templates/pokemon-search.component.html',
  providers: [PokemonSearchService]
})
export class PokemonSearchComponent implements OnInit {

  private searchTerms = new Subject<string>();
  pokemons: Observable<Pokemon[]>;

  constructor(
    private pokemonSearchService: PokemonSearchService,
    private router: Router) {}

  search(term: string): void {
    this.searchTerms.next(term);
  }

  ngOnInit(): void {
    this.pokemons = this.searchTerms
      .debounceTime(300)
      .distinctUntilChanged()
      .switchMap(term => term
        ? this.pokemonSearchService.searchPokemon(term)
        : Observable.of<Pokemon[]>([]))
      .catch(error => {
        console.log(error);
        return Observable.of<Pokemon[]>([]);
      });
  }

  gotoDetail(pokemon: Pokemon): void {
    let link = ['/pokemon', pokemon.id];
    this.router.navigate(link);
  }

}
