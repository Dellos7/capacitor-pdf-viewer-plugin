declare global {
  interface PluginRegistry {
    PdfViewer?: PdfViewerPlugin;
  }
}

export interface PdfViewerPlugin {
  show(): Promise<{result: string}>;
}
