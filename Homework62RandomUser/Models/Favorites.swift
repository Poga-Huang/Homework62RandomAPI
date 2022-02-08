//
//  FavoritesUser.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/8.
//

import Foundation


struct Favorites:Codable{
    var users:RandomUser.Results
    
    //生成文件目錄路徑
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //儲存
    static func save(_ data:[Self]){
        guard let data = try? JSONEncoder().encode(data)else{return}
        let url = documentsDirectory.appendingPathComponent("Favorites")
        try? data.write(to: url)
    }
    //讀檔
    static func load()->[Self]?{
        let url = documentsDirectory.appendingPathComponent("Favorites")
        guard let data = try? Data(contentsOf: url) else{return nil}
        return try? JSONDecoder().decode([Self].self, from: data)
    }
    
}
