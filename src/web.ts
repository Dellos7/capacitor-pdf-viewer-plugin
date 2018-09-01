import { WebPlugin } from '@capacitor/core';
import { PdfViewerPlugin } from './definitions';

export class PdfViewerWeb extends WebPlugin implements PdfViewerPlugin {
  constructor() {
    super({
      name: 'PdfViewer',
      platforms: ['web']
    });
  }

  async show(): Promise<{result: string}> {
    console.log('SHOW');
    return Promise.resolve({ result: 'missing web implementation' });
  }
}

const PdfViewer = new PdfViewerWeb();

export { PdfViewer };
