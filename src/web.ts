import { WebPlugin } from '@capacitor/core';
import { PdfViewerPlugin } from './definitions';

export class PdfViewerWeb extends WebPlugin implements PdfViewerPlugin {
  constructor() {
    super({
      name: 'PdfViewer',
      platforms: ['web']
    });
  }

  async show( options: { url: string } ): Promise<{result: string}> {
    console.log('show, with options: ' + options);
    return Promise.reject('missing web implementation');
  }
}

const PdfViewer = new PdfViewerWeb();

export { PdfViewer };
