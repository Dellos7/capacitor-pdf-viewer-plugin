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
        //let value = call.getString("value") ?? ""

        if #available(iOS 11.0, *) {
            //let pdfViewController = ViewController()
            //self.bridge.viewController.view = pdfViewController
            //self.showPdf();
            
            /*let pdfViewController = PdfViewController()
            self.bridge.viewController.present( pdfViewController, animated: true, completion: nil )*/
            let storyboard = UIStoryboard(name: "PdfViewer", bundle: Bundle(for: type(of: self)))
            let controller = storyboard.instantiateViewController(withIdentifier: "PdfViewController")
            self.bridge.viewController.present(controller, animated: true, completion: nil)
            
        } else {
            // Fallback on earlier versions
            print("Only available on iOS 11")
        }
        call.success([
            "result": "ok"
            ])
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
