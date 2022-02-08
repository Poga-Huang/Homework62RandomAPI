//
//  RandomUserListTVC+Extension.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/7.
//

import Foundation
import UIKit

extension RandomUserListTableViewController{
    
    
    func addRefreshControl(){
        let refreshControl = UIRefreshControl()
        let atrributtes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "重新載入...", attributes: atrributtes)
        refreshControl.tintColor = .black
        refreshControl.backgroundColor = .white
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action:#selector(refreshData), for: UIControl.Event.valueChanged)
    }
    
    func sortByLetter(){
        //
        for letter in self.letters.reversed() {
            for index in 0..<self.users!.results.count{
                if letter.first == self.users!.results[index].name.first.first{
                    self.usersSort.insert(self.users!.results[index], at: 0)
                }
            }
        }
        for index in 0..<self.users!.results.count{
            var firstLetterIsNormalLetter = true
            //檢查是否有開頭不是A~Z的
            for letter in self.letters {
                guard self.users!.results[index].name.first.first != letter.first else{
                    firstLetterIsNormalLetter = true
                    break
                }
                firstLetterIsNormalLetter = false
            }
            if firstLetterIsNormalLetter == false{
                self.usersSort.append(self.users!.results[index])
            }
        }
    }
    
    func configure(_ cell:RandomUserItemTableViewCell,forRowAt indexPath:IndexPath){
//從排序好的地方取得資料
        let userData = usersSort[indexPath.row]
        cell.loadingActivityIndicator.stopAnimating()
        cell.userNameLabel.text = userData.name.first + "," + userData.name.last
        UserListController.shared.fetchImage(url: userData.picture.medium) { image in
            DispatchQueue.main.async {
                if indexPath == self.tableView.indexPath(for: cell){
                    if let image = image {
                        cell.userPhotoImageView.image = image
                    }else{
                        cell.userPhotoImageView.image = UIImage(systemName: "person.circle.fill")
                    }
                }
            }
        }
    }
    
    func configureSearchResults(_ cell:RandomUserItemTableViewCell,forRowAt indexPath:IndexPath){
        let searchResult = searchResults[indexPath.row]
        cell.loadingActivityIndicator.stopAnimating()
        cell.userNameLabel.text = searchResult.name.first + "," + searchResult.name.last
        UserListController.shared.fetchImage(url: searchResult.picture.medium) { image in
            DispatchQueue.main.async {
                if indexPath == self.tableView.indexPath(for: cell){
                    if let image = image {
                        cell.userPhotoImageView.image = image
                    }else{
                        cell.userPhotoImageView.image = UIImage(systemName: "person.circle.fill")
                    }
                }
            }
        }
    }
    func alert(completion:@escaping (UIAlertAction)->()){
        let alert = UIAlertController(title: "確認", message: "是否要加入收藏夾", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
