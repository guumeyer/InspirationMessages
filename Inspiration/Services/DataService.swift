//
//  DataService.swift
//  Inspiration
//
//  Created by gustavo r meyer on 1/22/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class DataService: NSObject {
    func getQuoteData(completion: @escaping (_ quote: String,_ author:String) -> (),fail: @escaping () -> () ){
        
        let quoteEndPoint = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
        
        guard let url = URL(string: quoteEndPoint) else {
            print("Error: cannot create URL")
            return
        }

    
        // make the request
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error ?? "")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject] {
                    print(json)
                    
                    let aQuota = (json["quoteText"] as! String) 
                    let aAuthor = (json["quoteAuthor"] as! String)

                    DispatchQueue.main.sync {
                        completion(aQuota,aAuthor)
                    }
                }
            } catch {
               
                DispatchQueue.main.sync {
                    fail()
                }
                print("Error to parse")
            }
            
        }
        
        task.resume()
        

        
    }

}
