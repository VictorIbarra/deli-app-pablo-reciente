//
//  JPCustomViewController.swift
//  deli
//
//  Created by iJPe on 3/1/17.
//  Copyright © 2017 star_kids_mexico. All rights reserved.
//

import Foundation
import UIKit

class JPCustomViewController: UIViewController {
    var toolbarDone: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toolbarDone = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closeKeyboard))
        
        var arr = [UIBarButtonItem]()
        arr.append(flexSpace)
        arr.append(doneBtn)
        
        self.toolbarDone.tintColor = UIColor.Deli.primaryRed
        self.toolbarDone.setItems(arr, animated: false)
        self.toolbarDone.sizeToFit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.closeKeyboard()
    }
    
    //MARK: Functions
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK: Actions
    @IBAction func goToBack(sender: Any) {
        self.view.endEditing(true)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismiss() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}
