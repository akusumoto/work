import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/auth';
import { auth } from 'firebase';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  user$ = this.afAuth.user;
  constructor(private afAuth: AngularFireAuth) {}
  login() {
    this.afAuth
      .signInWithPopup(new auth.GoogleAuthProvider())
      .then((result) => {
        console.log(result);
      });
  }
  logout() {
    this.afAuth.signOut();
  }
}
