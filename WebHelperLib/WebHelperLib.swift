//
//  WebHelperLib.swift
//  WebHelperLib
//
//  Created by Hushan on 11/4/19.
//  Copyright © 2019 Hushan M Khan. All rights reserved.

//  MIT License
//
//  Copyright (c) 2019 Hushain Mubarik Khan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation


public class WebHelperLib {
    
    public let name = "WebHelperLib"
    
    
    public static let shared = WebHelperLib()
    
    public init() { }
    
    public func add(a: Int, b:Int) -> Int {
        return a + b
    }
    
    public func multiply(a: Int, b: Int) -> Int {
        return a * a
    }
    
    private let session = URLSession.shared
    
    public func Request(_ method : RequestMathod ,
                         urlString : String ,
                         parameters : Any ,
                         requestParam : [String:Any] = [:],
                         loading : Bool,
                         complitionHandler complition:@escaping (_ obj : Any , _ response :HTTPURLResponse) -> Void ,
                         failureHandler failure:@escaping (Error) -> Void)
    {
        
//        if !Utilities.isInternetReachable() {
//            return
//        }
        
//        if loading {
//          ProgressHUD.show("Loading...", interaction: true)
//        }
        
        //Make URL
        var url : URL?
        switch method {
        case .GET:
            if let dict = parameters as? [String:Any] {
                url = URL(string: "\(urlString)?\(self.stringFromDictionary(dict))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)
            }
            else
            {
                url = URL(string: urlString)
            }
            
        case .POST,.PUT,.DELETE: url = URL(string: urlString)
        }
        
        
        //Make URLRequest
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30.0)
        
        switch method {
        case .GET: request.httpMethod = "GET"
        case .POST:request.httpMethod = "POST";request.httpBody = self.getBodyData(body: parameters)
        case .PUT:request.httpMethod = "PUT"
        case .DELETE:request.httpMethod = "DELETE";request.httpBody = self.getBodyData(body: parameters)
            
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Pass Additional Request
        for (_, key) in requestParam.keys.enumerated() {
            
            #if DEBUG
            print("\(key) -- \(requestParam[key]!)")
            #endif
            
            request.setValue("\(requestParam[key] ?? "")", forHTTPHeaderField: key)
        }
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
           
          #if DEBUG
            self.printRequest(method, url: url!, parameter: parameters, response:"\(String(describing: httpResponse?.statusCode))")
          #endif
            
            
            DispatchQueue.main.async {
                
//                ProgressHUD.dismiss()
                
                guard error == nil else{
                    print(error?.localizedDescription ?? "Error")
                    failure(error!)
                    return
                }
                
                guard data != nil else {
                    complition([],response as! HTTPURLResponse)
                    return
                }
                
//                if httpResponse?.statusCode == 200 || httpResponse?.statusCode == 201{
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers])
                        print(json)
                        complition(json,response as! HTTPURLResponse)
                        
                        
                    }
                    catch let error {
                        failure(error)
                        print(error.localizedDescription)
                        return
                    }
//                }
//                else
//                {
//                    complition([],response as! HTTPURLResponse)
//                }
            }
            }.resume()
        
    }
    
   
    
}

extension WebHelperLib {
    
    private func printRequest(_ mathod : RequestMathod, url : URL , parameter : Any , response : String)
       {
           print("----------API----------\nURL:\(url)\nMethod:\(mathod)\nParameters:\(parameter)\nResponse:\(response)\n----------END----------")
       }
       
      private func getBodyData(body:Any) -> Data {
           var data : Data?
           
           do {
               if let bodyData = body as? String {
                   data = bodyData.data(using: .utf8)
               }
               else
               {
                   data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
               }
               
           }
           catch let error {
               print(error.localizedDescription)
           }
           
           return data!
       }
       
       //Name=Hushain&Address=Bhopal,Gwalior,Morena
       private func stringFromDictionary(_ dict : [String:Any])-> String {
           var strQ = ""
           
           if dict.count > 0 {
               let arrKeys = Array(dict.keys)
               for indexKey in 0..<arrKeys.count {
                   let key = arrKeys[indexKey]
                   if  arrKeys.count > 1{
                       if indexKey == 0 {
                           if let arrT = dict[key] as? [String] {
                               strQ = strQ.appending("\(key)=\(self.stringFromArray(arrT))")
                           }
                           else
                           {
                               strQ = strQ.appending("\(key)=\(dict[key]!)")
                           }
                       }
                       else
                       {
                           if let arrT = dict[key] as? [String] {
                               strQ = strQ.appending("&\(key)=\(self.stringFromArray(arrT))")
                           }
                           else
                           {
                               strQ = strQ.appending("&\(key)=\(dict[key]!)")
                           }
                       }
                   }
                   else
                   {
                       if let arrT = dict[key] as? [String] {
                           strQ = "\(key)=\(self.stringFromArray(arrT))"
                       }
                       else
                       {
                           strQ = "\(key)=\(dict[key]!)"
                       }
                   }
               }
           }
           return strQ
       }
       
       //Output: APPLE,ORANGE,BANANA
       private func stringFromArray(_ arr : [String]) -> String {
           var strQ = ""
           if arr.count > 1 {
               //let strTamp = strQ
               for count in 0..<arr.count {
                   if count == 0 {
                       strQ = strQ.appending(arr[count])
                   }
                   else
                   {
                       strQ = strQ.appending(",\(arr[count])")
                   }
               }
           }
           else
           {
               strQ = arr.first!
           }
           
           return strQ
       }
    
}

