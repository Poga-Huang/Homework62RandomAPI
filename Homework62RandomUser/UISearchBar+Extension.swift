//
//  UISearchBar+Extension.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/7.
//

import Foundation
import UIKit

extension RandomUserListTableViewController:UISearchBarDelegate{
    
    //按下搜尋後
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let users = users else{return}
        guard let keyWord = searchBar.text else{return}
        for index in 0..<users.results.count{
            if users.results[index].name.first.contains(keyWord) || users.results[index].name.last.contains(keyWord){
                searchResults.append(users.results[index])
            }
        }
        if searchResults.isEmpty{
            let alert = UIAlertController(title: "通知", message: "沒有搜尋到任何結果", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "關閉", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }else{
            tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        tableView.reloadData()
    }
}

