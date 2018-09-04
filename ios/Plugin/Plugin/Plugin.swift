import Foundation
import Capacitor
import UIKit
import PDFKit
import MobileCoreServices

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(PdfViewer)
public class PdfViewer: CAPPlugin {
    
    @objc func show(_ call: CAPPluginCall) {
        if #available(iOS 11.0, *) {
            DispatchQueue.main.async(execute: {
                print("call options")
                print(call.options)
                guard let pdfUrl = call.options["url"] as? String else {
                    call.error( "Missing parameter: url" )
                    return
                }
                let storyboard = UIStoryboard(name: "PdfViewer", bundle: Bundle(for: type(of: self)))
                let controller: PdfViewController = (storyboard.instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
                controller.setPdfUrl(url: pdfUrl)
                self.bridge.viewController.present(controller, animated: true, completion: nil)
                call.success()
            });
        }
        else {
            call.error( "Plugin only available on iOS >= 11.0" )
        }
        
    }
    
    @objc func pickAndShow(_ call: CAPPluginCall) {
        if #available(iOS 11.0, *) {
            DispatchQueue.main.async(execute: {
                //Use this to show a menu before loading the documents view
                //let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
                let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
                importMenu.delegate = self
                self.bridge.viewController.present(importMenu, animated: true, completion: nil)
            });
        }
        else {
            call.error( "Plugin only available on iOS >= 11.0" )
        }
    }
}

extension PdfViewer: UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate {
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        let storyboard = UIStoryboard(name: "PdfViewer", bundle: Bundle(for: type(of: self)))
        if #available(iOS 11.0, *) {
            let controller: PdfViewController = (storyboard.instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
            controller.setPdfUrl(url: myURL.absoluteString)
            self.bridge.viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.bridge.viewController.present(documentPicker, animated: true, completion: nil)
    }
    
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
    }
    
}
