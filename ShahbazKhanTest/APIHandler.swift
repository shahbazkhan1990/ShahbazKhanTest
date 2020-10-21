//
//  APIHandler.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 DemoApp. All rights reserved.
//

import Foundation

class APIHandler{
    
    func getDataFromApi(withUrl strUrl : String){
        
        if let unwrappedUrl = URL(string: strUrl){
            
            URLSession.shared.dataTask(with: unwrappedUrl, completionHandler: { (data, response, error) in
                
                if data != nil{
                    let jsonDecoder = JSONDecoder()
                    let userArray = try? jsonDecoder.decode( [parent].self , from: data!)
                    
                }
                
            }).resume()
        }
    }
        
}
