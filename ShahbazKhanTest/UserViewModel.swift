//
//  UserViewModel.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 DemoApp. All rights reserved.
//

import Foundation

class UserViewModel{
    
    typealias completionBlock = ([parent]) -> ()
    var apiHandler = APIHandler()
    var datasourceArray = [parent]()

   func getDataFromAPIHandlerClass(pagenumber: String,completionBlock : @escaping completionBlock){
        let modUrl =  "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(pagenumber)&limit=10"
        
            apiHandler.getDataFromApi(withUrl: modUrl) { [weak self] (arrUser) in
                if(self?.datasourceArray.count != 0){
                    self?.datasourceArray.append(contentsOf: arrUser)
                }else{
                    self?.datasourceArray = arrUser
                }
                completionBlock(arrUser)
            }
    }
    
    func getNumberOfRowsInSection() -> Int{
        
        return datasourceArray.count
    }
    
    func getUserAtIndex(index : Int) -> parent{
        
        let user = datasourceArray[index]
        return user
    }
    
    func checkEveryTenthRow(index:Int) -> Bool
    {
        if (index % 10 == 0) {
            return true
        }
        else
        {
            return false
        }
    }
    
    func getCreatedDate(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        
        if let username = user.createdAt
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            //dateFormatter.dateStyle = .short
            if let date = dateFormatter.date(from: username) as NSDate?{
                if let diffInDays = Calendar.current.dateComponents([.day], from: date as Date, to: Date()).day{
                    return  "\(String(diffInDays)) Days";
                }else{
                    return ""
                }
               // let myStringafd = dateFormatter.string(from: date as Date)
                
            }else{
                return ""
            }
            
        }else{
            return  "";
        }
    }
    
    func getContent(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        
        if let username = user.content
        {
            return  username;
        }else{
            return  "";
        }
        
    }
    
    func getComments(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        
        if let username = user.comments
        {
            let val = String(username)
            return  String(val + " Comments");
        }else{
            return  "";
        }
    }
    
    func getLikes(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        
        if let username = user.likes
        {
            let val = String(username)
            return  String(val + " Likes");
        }else{
            return  "";
        }
    }
    
    // Media Details --->
    
    func getMediaImage(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        if ((user.media?.count) != 0){
        if let username = user.media?[0].image
        {
            return  username;
        }else{
            return  "";
        }
        }else{
            return "";
        }
    }
    
    func getMediaTitle(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        
        if ((user.media?.count) != 0){
        if let username = user.media?[0].title
        {
            return  username;
        }else{
            return  "";
        }
        }else{
            return  "";
        }
    }
    
    func getMediaUrl(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        if ((user.media?.count) != 0){
        if let username = user.media?[0].url
        {
            return  username;
        }else{
            return  "";
        }
        }else{
            return  "";
        }
    }
    
    
    // User Details ---->
    
    func getUserName(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
        if ((user.user?.count) != 0){
        if let username = user.user?[0].name
        {
            return  username;
        }else{
            return  "";
        }
        }else{
          return  "";
        }
    }
    
    func getUserAvatar(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
         if ((user.user?.count) != 0){
        if let username = user.user?[0].avatar
        {
            return  username;
        }else{
            return  "";
        }
         }else{
            return ""
        }
    }
    
    func getUserDesig(index : Int) -> String
    {
        
        let user = self.getUserAtIndex(index: index)
         if ((user.user?.count) != 0){
        if let username = user.user?[0].designation
        {
            return  username;
        }else{
            return  "";
        }
         }else{
            return ""
        }
        
    }
    
}


