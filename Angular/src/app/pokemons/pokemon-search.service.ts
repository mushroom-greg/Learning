import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import { Pokemon } from './pokemon';

@Injectable()
export class PokemonSearchService {

  constructor(private http: Http) {}

  searchPokemon(term: string): Observable<Pokemon[]> {
    return this.http
      .get(`app/pokemons/?name=${term}`)
      .map((response: Response) => response.json().data as Pokemon[]);
  }
}
