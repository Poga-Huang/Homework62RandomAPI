//
//  RandomUserListTableViewController.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/6.
//

import UIKit
private let reusableIdentifier = "randomUserItemCell"

class RandomUserListTableViewController: UITableViewController {
    
    var users:RandomUser?
    var usersSort = [RandomUser.Results]()
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //加入下拉更新
        let refreshControl = UIRefreshControl()
        let atrributtes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "重新載入...", attributes: atrributtes)
        refreshControl.tintColor = .black
        refreshControl.backgroundColor = .white
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action:#selector(refreshData), for: UIControl.Event.valueChanged)
        
        fetchData()
    }
    //下拉重整資料
    @objc func refreshData(){
        fetchData()
        tableView.refreshControl?.endRefreshing()
    }
    //錯誤顯示
    func displayError(error:Error){
        let alert = UIAlertController(title: "Error", message:error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "重新整理", style: .default, handler: { ＿ in
            self.fetchData()
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    //抓資料
    func fetchData(){
        UserListController.shared.fetchRandomUser { result in
            switch result{
            case .success(let userResponse):
                DispatchQueue.main.async {
                    self.users = userResponse
    //排序
                    for letter in self.letters {
                        for index in 0..<self.users!.results.count{
                            let letterChar = Array(letter)
                            if letterChar[0] == self.users!.results[index].name.first.first{
                                self.usersSort.append(self.users!.results[index])
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.displayError(error: error)
                }
            }
        }
    }
    
//     MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = users else {
            return 1
        }
        return users.results.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? RandomUserItemTableViewCell else{return UITableViewCell()}
        if users != nil{
            configure(cell, forRowAt: indexPath)
        }
        return cell
    }
    func configure(_ cell:RandomUserItemTableViewCell,forRowAt indexPath:IndexPath){
        guard let users = users else {return}
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
}
