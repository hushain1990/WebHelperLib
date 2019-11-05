//
//  ViewController.swift
//  WebHelperLibExamples
//
//  Created by Hushan on 11/4/19.
//  Copyright © 2019 Hushan M Khan. All rights reserved.
//

import UIKit
import WebHelperLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Get API
        WebHelperLib.shared.Request(.GET, urlString: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty", parameters: [],requestParam:["Auth":"121543545311","Auth2":"251546"], loading: true, complitionHandler: { (data, res) in
            print(data)
        }) { (error) in
            
        }
        
    }


    func postApi() {
        
        WebHelperLib.shared.Request(.POST, urlString: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty", parameters: [], loading: true, complitionHandler: { (obj, res) in
            
        }) { (error) in
            
        }
        
    }
    
    
}

