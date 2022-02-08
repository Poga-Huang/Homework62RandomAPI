//
//  User.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/7.
//

import Foundation
struct RandomUser:Codable{
    var results:[Results]
    struct Results:Codable{
        var gender:String
        var name:Name
        struct Name:Codable{
            var title:String
            var first:String
            var last:String
        }
        var location:Location
        struct Location:Codable{
            var street:Street
            struct Street:Codable{
                var number:Int
                var name:String
            }
            var city:String
            var country:String
            var coordinates:Coordinates
            struct Coordinates:Codable{
                var latitude:String
                var longitude:String
            }
        }
        var email:String
        var phone:String
        var picture:Picture
        struct Picture:Codable{
            var large:URL
            var medium:URL
            var thumbnail:URL
        }
    }
}


struct UserItem:Codable{
    var gender:String
    var name:RandomUser.Results.Name
    var location:RandomUser.Results.Location
    var email:String
    var phone:String
    var picture:RandomUser.Results.Picture
}
