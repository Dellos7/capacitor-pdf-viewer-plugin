# capacitor-pdf-viewer-plugin

A [Capacitor](https://capacitor.ionicframework.com/) plugin in order to be able to see PDF files inside your app.

## Supported platforms

These are the supported platforms for the plugin at the moment:
* **iOS** (>=11.0)

## Requirements

## Installation

```bash
npm install capacitor-pdf-viewer-plugin --save
npx cap update ios
```

## Usage

### Ionic/Angular
```typescript
import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { PdfViewer } from 'pdf-viewer'; // <--
import { Plugins } from '@capacitor/core'; // <--

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor(public navCtrl: NavController) {

  }

  showPdf() {
    const { PdfViewer } = Plugins;
    PdfViewer.show()
    .then( res => {
      console.log('pdf viewer plugin res');
      console.log(res);
    })
    .catch( err => {
      console.error(err);
    });
  }

}
```