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
            print("call options")
            print(call.options)
            guard let pdfUrl = call.options["url"] as? String else {
                print("here, missing parameter url")
                call.error( "Missing parameter: url" )
                return
            }
            let storyboard = UIStoryboard(name: "PdfViewer", bundle: Bundle(for: type(of: self)))
            let controller: PdfViewController = (storyboard.instantiateViewController(withIdentifier: "PdfViewController") as? PdfViewController)!
            controller.setPdfUrl(url: pdfUrl)
            self.bridge.viewController.present(controller, animated: true, completion: nil)
            call.success()
        } else {
            call.error( "Plugin only available on iOS >= 11.0" )
        }
    }
    
    @available(iOS 11.0, *)
    func showPdf() {
        print("hehehe showPdf")
        
        if let path = Bundle.main.path(forResource: "geographic", ofType: "pdf") {
            print("path is: " + path)
            let url = URL(fileURLWithPath: path)
            print("1-url is: " + url.absoluteString)
            if let pdfDocument = PDFDocument(url: url) {
                print("1-here pdf document")
                DispatchQueue.main.async{
                 self.goPdfView(pdfDocument: pdfDocument);
                }
                //captureThumbnails(pdfDocument:pdfDocument)
            }
            else {
                print("could not create pdf document")
                let url = URL(string: "http://www.axmag.com/download/pdfurl-guide.pdf")
                print("2-url is: " + url!.absoluteString)
                if let pdfDocument = PDFDocument(url: url!) {
                    print("2-here pdf document")
                    DispatchQueue.main.async{
                        self.goPdfView(pdfDocument: pdfDocument);
                    }
                }
            }
        }
        else {
            print("path not found")
            let url = URL(string: "http://www.axmag.com/download/pdfurl-guide.pdf")
            print("3-url is: " + url!.absoluteString)
            if let pdfDocument = PDFDocument(url: url!) {
                print("3-here pdf document")
                DispatchQueue.main.async{
                    self.goPdfView(pdfDocument: pdfDocument);
                }
                //captureThumbnails(pdfDocument:pdfDocument)
            }
        }
    }
    
    @available(iOS 11.0, *)
    func goPdfView( pdfDocument: PDFDocument ) {
        let pdfView = PDFView()
        //let view = self.bridge.viewController.view as UIView;
        self.bridge.viewController.view.addSubview(pdfView)
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = pdfDocument
        //captureThumbnails(pdfDocument:pdfDocument)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        self.bridge.viewController.view.bringSubview(toFront: pdfView)
        /*pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true*/
        //self.view.addSubview(pdfView)
    }
}
