//
//  UserListController.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/7.
//

import Foundation
import UIKit

class UserListController{
    
    static let shared = UserListController()
    
    //抓資料
    func fetchRandomUser(completion:@escaping (Result<RandomUser,Error>)->()){
        guard let url = URL(string: "https://randomuser.me/api/?results=50") else {return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            if let data = data {
                do{
                    let userResponse = try JSONDecoder().decode(RandomUser.self, from: data)
                    completion(.success(userResponse))
                }catch{
                    completion(.failure(error))
                }
            }else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    //下載圖片
    func fetchImage(url:URL,completion:@escaping(UIImage?)->()){
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }else{
                completion(nil)
            }
        }.resume()
    }
}
