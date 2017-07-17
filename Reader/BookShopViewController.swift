//
//  BookShopViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/17.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit
import PDFReader

class BookShopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func haha(_ sender: Any) {
        
        let pdfDocumentName = "sheet"
        if let doc = document(pdfDocumentName) {
            showDocument(doc)
        } else {
            print("Document named \(pdfDocumentName) not found in the file system")
        }

    }
    
    fileprivate func document(_ name: String) -> PDFDocument? {
        guard let documentURL = Bundle.main.url(forResource: name, withExtension: ".pdf") else {
            return nil
        }
        return PDFDocument(url: documentURL)
    }
    
    fileprivate func showDocument(_ document: PDFDocument) {
        let image = UIImage(named: "tee")
        let controller = PDFViewController.createNew(with: document, title: "git", actionButtonImage: image, actionStyle: .activitySheet)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
