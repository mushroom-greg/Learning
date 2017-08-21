import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { DetailPokemonComponent } from './detail-pokemon.component';
import { ListPokemonComponent } from './list-pokemon.component';
import { EditPokemonComponent } from './edit-pokemon.component';
import { PokemonFormComponent } from './pokemon-form.component';
import { PokemonSearchComponent } from './pokemon-search.component';
import { LoaderComponent } from './loader.component';

import { AuthGuard } from '../auth-guard.service';
import { PokemonsRoutingModule } from './pokemons-routing.module';
import { PokemonsService } from './pokemons.service';
import { PokemonSearchService } from './pokemon-search.service';
import { ShadowCardDirective } from './shadow-card.directive';
import { PokemonTypeColorPipe } from './pokemon-type-color.pipe';


@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    PokemonsRoutingModule
  ],
  declarations: [
    DetailPokemonComponent,
    ListPokemonComponent,
    EditPokemonComponent,
    PokemonFormComponent,
    PokemonSearchComponent,
    LoaderComponent,
    ShadowCardDirective,
    PokemonTypeColorPipe
  ],
  providers: [
    PokemonsService,
    PokemonSearchService,
    AuthGuard
  ]
})
export class PokemonsModule {}
