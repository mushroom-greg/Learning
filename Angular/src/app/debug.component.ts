import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-debug',
  template: '<div style="background-color: red; text-align: center">This is the debug component.</div>'
})
export class DebugComponent implements OnInit {
  ngOnInit(): void {
    alert('The app is launched!');
  }
}
