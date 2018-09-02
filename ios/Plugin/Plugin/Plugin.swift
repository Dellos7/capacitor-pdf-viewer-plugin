import Foundation
import Capacitor
import UIKit
import PDFKit

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
}
