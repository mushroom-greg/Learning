import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { PokemonsService} from './pokemons.service';
import { Pokemon } from './pokemon';

@Component({
  selector: 'app-pokemon-form',
  templateUrl: '../templates/pokemon-form.component.html',
  styleUrls: ['../stylesheets/pokemon-form.component.css']
})
export class PokemonFormComponent implements OnInit {

  @Input() pokemon: Pokemon;
  types: Array<string>;

  constructor(
    private pokemonsService: PokemonsService,
    private router: Router
  ) {}

  ngOnInit() {
    this.types = this.pokemonsService.getPokemonTypes();
  }

  hasType(type: string): boolean {
    const index = this.pokemon.types.indexOf(type);
    if (~index)
      return true;
    return false;
  }

  selectType($event: any, type: string): void {
    const checked = $event.target.checked;
    if ( checked ) {
      this.pokemon.types.push(type);
    }
    else {
      const index = this.pokemon.types.indexOf(type);
      if (~index)
        this.pokemon.types.splice(index, 1);
    }
  }

  isTypeValid(type: string): boolean {
    if (this.pokemon.types.length >= 3 && !this.hasType(type))
      return false;
    return true;
  }

  onSubmit(): void {
    console.log('Submit form !');
    const link = ['/pokemon', this.pokemon.id];
    this.router.navigate(link);
  }

}
