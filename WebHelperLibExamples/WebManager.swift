////  WebManager.swift
////  WaashApp
////
////  Created by HUSHAN MUBARIK KHAN on 30/01/17.
////  Copyright © 2017 HUSHAN MUBARIK KHAN. All rights reserved.
////
//
//import Foundation
//
//
//#if DEBUG
//let isDebug = true
//#else
//let isDebug = false
//#endif
//
//class WebManager : NSObject {
//
//    private enum RequestMathod {
//        case GET,POST,PUT,DELETE
//    }
//
////    var udid : String {
////        guard let udid_local : String = Device.current.identifierForVendor?.uuidString else {
////            print("UDID not found")
////            return ""
////        }
////        print(udid_local)
////        return udid_local
////    }
//
//
//
//    static let shared = WebManager()
//
//    private let session = URLSession.shared
//
//    var key : [String:Any]!
//
//    private func Request(_ method : RequestMathod ,
//                         urlString : String ,
//                         parameters : Any ,
//                         cookies : Bool ,
//                         loading : Bool,
//                         complitionHandler complition:@escaping (_ obj : Any , _ response :HTTPURLResponse) -> Void ,
//                         failureHandler failure:@escaping (Error) -> Void)
//    {
//
//        if !Utilities.isInternetReachable() {
//            return
//        }
//
//        if loading {
//          ProgressHUD.show("Loading...", interaction: true)
//        }
//
//        //Make URL
//        var url : URL?
//        switch method {
//        case .GET:
//            if let dict = parameters as? [String:Any] {
//                url = URL(string: "\(urlString)?\(self.stringFromDictionary(dict))".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)
//            }
//            else
//            {
//                url = URL(string: urlString)
//            }
//
//        case .POST,.PUT,.DELETE: url = URL(string: urlString)
//        }
//
//
//        //Make URLRequest
//        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30.0)
//
//        switch method {
//        case .GET: request.httpMethod = "GET"
//        case .POST:request.httpMethod = "POST";request.httpBody = self.getBodyData(body: parameters)
//        case .PUT:request.httpMethod = "PUT"//;request.httpBody = self.getBodyData(body: parameters)
//        case .DELETE:request.httpMethod = "DELETE";request.httpBody = self.getBodyData(body: parameters)
//
//        }
//        // request.httpBody = bodyData.data(using: String.Encoding.utf8)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        if cookies {
//           //token
//            request.setValue(self.currentUser.accessToken, forHTTPHeaderField: "token")
//        }
//
//        self.session.dataTask(with: request) { (data, response, error) in
//
//            let httpResponse = response as? HTTPURLResponse
//            //print(httpResponse?.allHeaderFields)
//            self.printRequest(method, url: url!, parameter: parameters, response:"\(String(describing: httpResponse?.statusCode))")
//            DispatchQueue.main.async {
//
//                ProgressHUD.dismiss()
//
//                guard error == nil else{
//                    print(error?.localizedDescription ?? "Error")
//                    failure(error!)
//                    return
//                }
//
//                guard data != nil else {
//                    complition([],response as! HTTPURLResponse)
//                    return
//                }
//
//                if httpResponse?.statusCode == 200 || httpResponse?.statusCode == 201{
//                    do {
//                        if let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) as? [String:Any] {
//
//                            print(json)
//
//                            complition(json,response as! HTTPURLResponse)
//                        }
//                    }
//                    catch let error {
//                        failure(error)
//                        print(error.localizedDescription)
//                        return
//                    }
//                }
//                else
//                {
//                    complition([],response as! HTTPURLResponse)
//                }
//            }
//            }.resume()
//
//    }
//
//    private func printRequest(_ mathod : RequestMathod, url : URL , parameter : Any , response : String)
//    {
//        print("----------API----------\nURL:\(url)\nMethod:\(mathod)\nParameters:\(parameter)\nResponse:\(response)\n----------END----------")
//    }
//
//    func getBodyData(body:Any) -> Data {
//        var data : Data?
//
//        do {
//            if let bodyData = body as? String {
//                data = bodyData.data(using: .utf8)
//            }
//            else
//            {
//                data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//            }
//
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
//
//        return data!
//    }
//
//    //Name=Hushain&Address=Bhopal,Gwalior,Morena
//    private func stringFromDictionary(_ dict : [String:Any])-> String {
//        var strQ = ""
//
//        if dict.count > 0 {
//            var arrKeys = Array(dict.keys)
//            for indexKey in 0..<arrKeys.count {
//                let key = arrKeys[indexKey]
//                if  arrKeys.count > 1{
//                    //var strTemp = ""
//                    if indexKey == 0 {
//                        if let arrT = dict[key] as? [String] {
//                            strQ = strQ.appending("\(key)=\(self.stringFromArray(arrT))")
//                        }
//                        else
//                        {
//                            strQ = strQ.appending("\(key)=\(dict[key]!)")
//                        }
//                    }
//                    else
//                    {
//                        if let arrT = dict[key] as? [String] {
//                            strQ = strQ.appending("&\(key)=\(self.stringFromArray(arrT))")
//                        }
//                        else
//                        {
//                            strQ = strQ.appending("&\(key)=\(dict[key]!)")
//                        }
//                    }
//                }
//                else
//                {
//                    if let arrT = dict[key] as? [String] {
//                        strQ = "\(key)=\(self.stringFromArray(arrT))"
//                    }
//                    else
//                    {
//                        strQ = "\(key)=\(dict[key]!)"
//                    }
//                }
//            }
//        }
//        return strQ
//    }
//
//    //Output: APPLE,ORANGE,BANANA
//    private func stringFromArray(_ arr : [String]) -> String {
//        var strQ = ""
//        if arr.count > 1 {
//            //let strTamp = strQ
//            for count in 0..<arr.count {
//                if count == 0 {
//                    strQ = strQ.appending(arr[count])
//                }
//                else
//                {
//                    strQ = strQ.appending(",\(arr[count])")
//                }
//            }
//        }
//        else
//        {
//            strQ = arr.first!
//        }
//
//        return strQ
//    }
//
//
//    //MARK: - TOKEN
//
////    func saveCurrentToken(_ token : String) {
////        self.api_token_id = token
////        UserDefaults.standard.set(token, forKey: "Token")
////        UserDefaults.standard.synchronize()
////    }
////
////    func loadCurrentToken() {
////        if UserDefaults.standard.object(forKey: "Token") != nil {
////            self.api_token_id = UserDefaults.standard.object(forKey: "Token") as? String
////        }
////    }
//

