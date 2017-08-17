import {Component, OnDestroy} from '@angular/core';

@Component({
  selector: 'app-pokemon',
  templateUrl: './templates/app.component.html',
})
export class AppComponent implements OnDestroy {
  ngOnDestroy() {
    alert('The component is destroyed!');
  }
}
