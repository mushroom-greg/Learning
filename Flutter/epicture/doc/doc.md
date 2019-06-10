# [APP DEV] Epicture Promo 2021

---

#### This documentation describe the architecture of the "Epicture Project", an "Imgur like" Android app based on the Imgur API.

---

##### We had the choice to use on of the following language :
* ###### [Java](https://www.java.com/en/)
* ###### [Kotlin](https://kotlinlang.org/)
* ###### [C#](https://docs.microsoft.com/en-us/dotnet/csharp/)
* ###### [React Native](https://facebook.github.io/react-native/)

---

#### We asked if we can use [Dart](https://www.dartlang.org/) with the [Flutter](https://flutter.io/) SDK for the following reasons :

* ###### Cross-platform compilation.
* ###### Generation of native [Swift](https://developer.apple.com/swift/) code on [IOS](https://developer.apple.com/ios/).
* ###### Generation of native [Android](https://www.android.com/) code.
* ###### Next generation phone compatibility of [Fuchsia OS](https://en.wikipedia.org/wiki/Google_Fuchsia).
* ###### Native access of Android and IOS phone component like Camera, Microphone, etc...
* ###### Natively optimised Widget and Components for [IOS](https://developer.apple.com/ios/) and [Android](https://www.android.com/).

---

#### Mandatory part's implementation across the App.
##### The mandatory part of the 
- [x] Imgur API implementation.
- [ ] Authentication to the Imgur platform.
- [ ] Display the photos put online by the user connected.
- [x] Search for photos on the platform.
- [x] Upload photos to the platform.
- [ ] Manage your favorites.
- [x] Filter the displayed photos.

Knowing we used a cutting edge new language by Google, there is still many bugs and error, without speaking of the lack of implementation of common and standard library.
We tried many different library for the OAuth2 authentication without success.
* ###### [oauth 2 V1.2.3](https://pub.dartlang.org/packages/oauth2) : The official Flutter package for the Oauth2 implementation.
* ###### [FlutterOAuth](https://github.com/hitherejoe/FlutterOAuth) : A custom implementation of OAuth2.
* ###### [oauth2-imgur](https://github.com/adam-paterson/oauth2-imgur) : Another custom implementation of OAuth2 for the Imgur API.
* ###### [Simple Auth Flutter](https://pub.dartlang.org/packages/simple_auth_flutter) : Another custom implementation of OAuth2.
* ###### [Awesome-Flutter](https://github.com/Solido/awesome-flutter/) : We even try different lib and package of the Awesome-Flutter Github repository, still without success.

During our search, we found many threads / posts regarding the implementation's quality of the Flutter OAuth 2.0 package. Here is one of the following:
* ###### [Oauth on Flutter really sucks ! Whats the easiest way ?](https://www.reddit.com/r/FlutterDev/comments/9i5kzu/oauth_on_flutter_really_sucks_whats_the_easiest/)

We even get an error response from the Official Google OAuth2 package regarding the validity of the response of the Imgur API, saying it's not a valid OAuth2 answer.

---

#### The architecture of the project is set as follow :

* ###### /android : The folder containing all the resource used by [Dart](https://www.dartlang.org/) and the [Flutter SDK](https://flutter.io/) for compiling the Android SDK.
* ###### /assets : The folder containing all the assets of the Epicture's UX. As a icon, the logo, etc...
* ###### /doc : The current documentation folder.
* ###### /ios : The folder containing all the resource used by [Swift](https://developer.apple.com/swift/) for compiling the [IOS](https://developer.apple.com/ios/) image.
* ###### /lib : The folder containing all the Dart / Flutter source code.
* ###### /lib/*.dart : Describe the main UI and behaviours of all the page in the App.
* ###### /lib/imgur_api : The folder containing all the getter of the Imgur API endpoint.

---

###/lib Folder description :
* ###### /home.dart : Describe the behaviors of the [Home] application page.
* ###### /image-detail.dart : Describe the behaviors of the Image Widget in the [Home] application page.
* ###### /logged_main.dart : Describe and manage the logged user across the App. 
* ###### /login.dart : Describe and manage the authentication across the App.
* ###### /main.dart : Describe the main Widget of the Application and contain Splashscreen.
* ###### /profile.dart : Describe the behaviors of the [Profile] page of the App.
* ###### /profile_dab.dart : Describe and manage the behaviors of the UI in the [Profile] page of the App.
* ###### /upload_info.dart : Describe the behaviors of the [Upload] page of the App.
* ###### /lib/imgur_api/util : Describe and build the HTTP header sent to the Imgur API.

---

### /lib/src/ Folder description :

#### /lib/imgur_api/src/Objects folder description : 
* ###### /lib/imgur_api/src/objects/ImgurAlbum.dart : Contain the getter for the answer of the Imgur API call for the [Album].
```
Get information about an image in an album.
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : /album/${this.id}/image/$id
    - $albumHash all of the images in the album.
    - $imageHash is the unique identifier of an image in the gallery.
```

---

* ###### /lib/imgur_api/src/objects/ImgurComment.dart : Contain the getter for the answer of the Imgur API call.
```
Get information about a specific comment.
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : /gallery/$galleryHash/comments/$commentSort
    - $galleryHash is the unique identifier of an album or image in the gallery.
    - $commentSort is one of [best] | [top] | [new] (-defaults to best).
```

---

* ###### /lib/imgur_api/src/objects/ImgurGallery.dart : Contain the getter for the answer of the Imgur API call.
```
Returns list of comments attached to this Gallery
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : /gallery/${this.id}/comments/$commentSort
    - ${this.id} is the unique identifier of an album or image in the gallery.
    - $commentSort is one of [best] | [top] | [new] (-defaults to best).
```

---

* ###### /lib/imgur_api/src/objects/ImgurImage.dart : Contain the getter for the answer of the Imgur API call.
```
Get comments of image
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : /gallery/${this.id}/comments/$commentSort
    - $id is the unique identifier of an album or image in the gallery.
    - $commentSort is one of [best] | [top] | [new] (-defaults to best).
```

---

* ######/lib/imgur_api/ImgurApi.dart : Contain all the routes of the Imgure API call.
* ###### [Album](https://apidocs.imgur.com/#5369b915-ad8b-47b1-b44b-8e2561e41cee)
```
Get comments of image.
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : "/album/$id"
    - $id is the unique identifier of an album or image in the gallery.
```

---

* ###### [Galleries](https://apidocs.imgur.com/#eff60e84-5781-4c12-926a-208dc4c7cc94)
```
Return a list of all gallerie.
- Method : GET
- API URK : https://api.imgur.com/3/
- Endpoint : /gallery/$section/$sort/$window/$page
    - $section is the section to search for.
    - $sort is the filter used in the request. (The "viral" tag is used by default.)
    - $window is the time frame of the requested images. (The default value is 24h.) 
    - $page is the number of the page to get.
```

---

* ######  [Gallery](https://apidocs.imgur.com/#5369b915-ad8b-47b1-b44b-8e2561e41cee)
```
Gets gallery based on given id.
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : "/gallery/album/$id"
    - $id is the unique identifier of an album or image in the gallery.
```

---

* ###### [Subreddit](https://apidocs.imgur.com/#10456589-7167-4b5c-acd3-a1e4eb6a95ed)
```
Gets subreddit list of images.
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : "/gallery/r/$id/$sort/$window/$page"
    - $id is the unique identifier of an album or image in the gallery.
    - $sort is the filter used in the request. (The "viral" tag is used by default.)
    - $window is the time frame of the requested images. (The default value is 24h.) 
    - $page is the number of the page to get.
```

---

* ###### [Search Gallery](https://apidocs.imgur.com/#3c981acf-47aa-488f-b068-269f65aee3ce)
```
Search within Imagur for galley using [query].
- Method : GET
- API URL : https://api.imgur.com/3/
- Endpoint : "/gallery/search/$sort/$window/$page"
    - $sort is the filter used in the request. (The "viral" tag is used by default.)
    - $page is the number of the page to get.
```
