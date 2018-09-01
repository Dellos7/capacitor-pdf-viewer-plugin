declare global {
  interface PluginRegistry {
    PdfViewer?: PdfViewerPlugin;
  }
}

export interface PdfViewerPlugin {
  show( options: { url: string } ): Promise<{result: string}>;
}
