// This file is not included in the Pokemon-app

import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';

@Component ({
  selector: 'app-exercise',
  template: '<h1></h1>'
})
export class Exercise implements OnInit {

  form: FormGroup;

  constructor(private formBuilder: FormBuilder) {}

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      name: this.formBuilder.group({
        firstname: ['', Validators.compose(
          [Validators.required,
            Validators.minLength(3),
            Validators.maxLength(25)])],

        lastname: ['', Validators.compose(
          [Validators.required,
            Validators.minLength(3),
            Validators.maxLength(25)])]

      }),
      email: ['', Validators.pattern('^[a-z0-9._-]+@[a-z0-9._-]{2,}\\.[a-z]{2,4}$')],

      verification: this.formBuilder.group({
        password: ['', Validators.compose(
          [Validators.required,
            Validators.minLength(8)])],

        passwordConfirm: ['', Validators.compose(
          [Validators.required,
            Validators.minLength(8)])]

      }, passwordMatchValidator())
    });
  }
}
