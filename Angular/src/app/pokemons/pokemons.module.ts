import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { DetailPokemonComponent } from './detail-pokemon.component';
import { ListPokemonComponent } from './list-pokemon.component';
import { EditPokemonComponent } from './edit-pokemon.component';
import { PokemonFormComponent } from './pokemon-form.component';

import { PokemonsRoutingModule } from './pokemons-routing.module';
import { PokemonsService } from './pokemons.service';
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
    ShadowCardDirective,
    PokemonTypeColorPipe
  ],
  providers: [PokemonsService]
})
export class PokemonsModule {}
