import { InMemoryDbService } from 'angular-in-memory-web-api';
import { POKEMONS } from './pokemons/mocks-pokemons';

export class InMemoryDataService implements InMemoryDbService {
  createDb() {
    const pokemons = POKEMONS;
    return { pokemons };
  }
}
