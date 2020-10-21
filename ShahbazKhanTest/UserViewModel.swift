//
//  UserViewModel.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 DemoApp. All rights reserved.
//

import Foundation

class UserViewModel{
    
    var apiHandler = APIHandler()

   func getDataFromAPIHandlerClass(){
        let modUrl =  "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10"
        apiHandler.getDataFromApi(withUrl: modUrl)
    
    }
    
}


