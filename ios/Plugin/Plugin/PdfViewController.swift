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
    
    private var pdfDocument: PDFDocument?
    private var pdfUrl: String?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pdfView: PDFView!
    
    
    @IBOutlet weak var thumbsStackView: UIStackView!
    @IBOutlet weak var page1ImageView: UIImageView!
    @IBOutlet weak var page2ImageView: UIImageView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    @IBAction func closePdf(_ sender: Any) {
        self.dismiss( animated: true, completion: nil )
    }
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    @IBAction func showActions(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        
        if self.thumbsStackView.isHidden {
            alert.addAction(UIAlertAction(title: "Show pages", style: .default , handler:{ (UIAlertAction)in
                //self.captureThumbnails()
                self.showThumbnails()
            }))
        }
        else {
            alert.addAction(UIAlertAction(title: "Hide pages", style: .default , handler:{ (UIAlertAction)in
                self.hideThumbnails()
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            alert.dismiss( animated: true, completion: nil )
        }))
        
        self.present(alert, animated: true, completion: {
            print("action sheet completed")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPdfViewStoryBoard()
    }
    
    func loadPdfViewStoryBoard() {
        if let url = URL(string: self.pdfUrl!) {
            //self.pdfDocument = PDFDocument(url: url)
            do {
                let data = try Data(contentsOf: url)
                self.pdfDocument = PDFDocument( data: data )
                if  self.pdfDocument != nil {
                    self.pdfView.autoScales = true
                    self.pdfView.displayMode = .singlePageContinuous
                    self.pdfView.displayDirection = .vertical
                    self.pdfView.document = pdfDocument
                    //captureThumbnails()
                }
            }
            catch let err {
                print("pdf document was not created")
                print(err.localizedDescription)
            }
        }
        else {
            print("pdf url was not provided")
        }
    }
    
    func showThumbnails() {
        let storyboard = UIStoryboard(name: "PdfViewer", bundle: Bundle(for: type(of: self)))
        //let controller: PagesViewController = (storyboard.instantiateViewController(withIdentifier: "PagesViewController") as? PagesViewController)!
        let controller: PagesViewController = (storyboard.instantiateViewController(withIdentifier: "PagesViewController") as? PagesViewController)!
        controller.setPdfDocument(pdfDocument: self.pdfDocument!)
        self.present(controller, animated: true, completion: nil)
    }
    
    func captureThumbnails() {
        if let page1 = self.pdfDocument?.page(at: 0) {
            self.page1ImageView.image = page1.thumbnail(of: CGSize(
                width: self.page1ImageView.frame.width,
                height: self.page1ImageView.frame.height), for: .artBox)
            
        }
        
        if let page2 = self.pdfDocument?.page(at: 1) {
            self.page2ImageView.image = page2.thumbnail(of: CGSize(
                width: self.page2ImageView.frame.width,
                height: self.page2ImageView.frame.height), for: .artBox)
        }
        
        /*self.thumbsStackView.alpha = 0.0
        self.thumbsStackView.isHidden = false*/
        
        UIView.animate(withDuration: 2, delay: 1, options: .transitionCrossDissolve, animations: {
            //self.thumbsStackView.alpha = 1.0
            self.thumbsStackView.isHidden = false
        }) { (isCompleted) in
            self.thumbsStackView.isHidden = false
        }
    }
    
    func hideThumbnails() {
        UIView.animate(withDuration: 2, delay: 1, options: .transitionFlipFromTop, animations: {
            //self.thumbsStackView.alpha = 0.0
            self.thumbsStackView.isHidden = true
        }) { (isCompleted) in
            self.thumbsStackView.isHidden = true
        }
    }
    
    func setPdfUrl( url: String ) {
        self.pdfUrl = url
    }

}
