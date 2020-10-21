//
//  Structure.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct parent:Codable
{
    var createdAt:String?
    var content:String?
    var comments:Int?
    var likes:Int?
    var media:[media]?
    var user:[userStruct]?
    
}

struct media:Codable {
    var image: String?
    var title:String?
    var url:String?
}

struct userStruct:Codable {
    var name: String?
    var avatar:String?
    var designation:String?
}
