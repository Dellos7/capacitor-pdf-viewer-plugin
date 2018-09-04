# capacitor-pdf-viewer-plugin

A [Capacitor](https://capacitor.ionicframework.com/) plugin in order to be able to see PDF files inside your app.

## Supported platforms

These are the supported platforms for the plugin at the moment:
* iOS 11.0+

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
import { PdfViewer } from 'capacitor-pdf-viewer-plugin';
import { Plugins } from '@capacitor/core';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor() {}

  showFromUrl() {
    const url = "https://www.adobe.com/content/dam/acom/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf";
    const { PdfViewer } = Plugins;
    PdfViewer.show( { url: this.url } )
    .then( res => {
      console.log(res);
    })
    .catch( err => {
      console.error(err);
    });
  }

  pickAndShow() {
    const { PdfViewer } = Plugins;
    PdfViewer.pickAndShow()
    .then(res => {
      console.log(res);
    })
    .catch(err => {
      console.error(err);
    });
  }

}
```