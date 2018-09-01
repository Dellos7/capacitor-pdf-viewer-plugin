//
//  PdfViewController.swift
//  Capacitor
//
//  Created by David López Castellote on 31/8/18.
//

import Foundation

import UIKit
import PDFKit

@available(iOS 11.0, *)
class PdfViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var page1ImageView: UIImageView!
    @IBOutlet weak var page2ImageView: UIImageView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    @IBAction func closePdf(_ sender: Any) {
        self.dismiss( animated: true, completion: nil )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.loadPdfView()
        self.loadPdfViewStoryBoard()
    }
    
    func loadPdfViewStoryBoard() {
        if let url = URL(string: "http://www.axmag.com/download/pdfurl-guide.pdf") {
            /*self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.contentView.frame = self.bounds
            self.addSubview(self.contentView)*/
            
            if let pdfDocument = PDFDocument(url: url) {
                self.pdfView.autoScales = true
                self.pdfView.displayMode = .singlePageContinuous
                self.pdfView.displayDirection = .vertical
                self.pdfView.document = pdfDocument
                captureThumbnails(pdfDocument:pdfDocument)
            }
        }
        else {
            print("pdf url was not provided")
        }
    }
    
    func captureThumbnails(pdfDocument:PDFDocument) {
        if let page1 = pdfDocument.page(at: 1) {
            self.page1ImageView.image = page1.thumbnail(of: CGSize(
                width: self.page1ImageView.frame.width,
                height: self.page1ImageView.frame.height), for: .artBox)
            
        }
        
        if let page2 = pdfDocument.page(at: 1) {
            self.page2ImageView.image = page2.thumbnail(of: CGSize(
                width: self.page2ImageView.frame.width,
                height: self.page2ImageView.frame.height), for: .artBox)
        }
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear( animated )
        print("viewWillDisappear")
        self.dismiss(animated: animated, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear( animated )
        print("viewDidDisappear")
        self.dismiss(animated: animated, completion: nil)
    }*/

}
