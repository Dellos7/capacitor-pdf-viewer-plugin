//
//  NewPagesViewController.swift
//  CapacitorPdfViewerPlugin
//
//  Created by David López Castellote on 2/9/18.
//

import Foundation
import PDFKit
import UIKit

@available(iOS 11.0, *)
class PagesViewController: UIViewController {
    
    @IBOutlet weak var pagesCollectionView: UICollectionView!
    
    private var pdfDocument: PDFDocument?
    
    @IBAction func closePagesView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.pagesCollectionView?.setPdfDocument(pdfDocument: (self.pdfDocument)!)
        self.pagesCollectionView.dataSource = self
        self.pagesCollectionView.delegate = self
        self.pagesCollectionView.reloadData()
    }
    
    func setPdfDocument( pdfDocument: PDFDocument ) {
        self.pdfDocument = pdfDocument
    }
}

@available(iOS 11.0, *)
extension PagesViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pdfDocument?.pageCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.pagesCollectionView?.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath) as? PageCollectionViewCell
        if let page = self.pdfDocument?.page(at: indexPath.row) {
            cell?.number.text = String(indexPath.row + 1)
            cell?.image.image = page.thumbnail(of: CGSize(
                width: (cell?.image.frame.width)!,
                height: (cell?.image.frame.height)!), for: .artBox)
        }
        return cell!
    }
}
