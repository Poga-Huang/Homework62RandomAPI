//
//  RandomUserListTableViewController.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/6.
//

import UIKit
private let reusableIdentifier = "randomUserItemCell"
private let segueIdentifier = "showUserProfile"

class RandomUserListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users:RandomUser?
    var userItem:UserItem?
    var usersSort = [RandomUser.Results]()
    var searchResults = [RandomUser.Results]()
    var favorites = [Favorites](){
        didSet{
            Favorites.save(favorites)
        }
    }
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加入下拉更新
        addRefreshControl()
        fetchData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let loadData = Favorites.load(){
            favorites = loadData
        }
    }
    
    //下拉重整資料
    @objc func refreshData(){
        fetchData()
        searchBar.text = ""
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
                    //重新下載後清空搜尋結果
                    self.searchResults.removeAll()
                    self.users = userResponse
                    //排序
                    self.sortByLetter()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.displayError(error: error)
                }
            }
        }
    }
    
    
    @IBAction func addFavorites(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            alert { _ in
                self.favorites.append(Favorites(users: self.usersSort[indexPath.row]))
                self.usersSort.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .middle)
            }
            
        }
    }
    
    @IBSegueAction func passUserItem(_ coder: NSCoder) -> UserProfileTableViewController? {
        return UserProfileTableViewController(coder: coder, userProfile: userItem!)
    }
    
    
//     MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard usersSort.isEmpty == false else {
            return 1
        }
        guard searchResults.isEmpty == true else{
            return searchResults.count
        }
        return usersSort.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? RandomUserItemTableViewCell else{return UITableViewCell()}
        
        if searchResults.isEmpty == true{
            if users != nil{
                configure(cell, forRowAt: indexPath)
                
            }
        }else{
            configureSearchResults(cell, forRowAt: indexPath)
            
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard users != nil else {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.allowsSelection = false
            return
        }
        
        guard searchResults.isEmpty == true else{
            let selectUser = searchResults[indexPath.row]
            userItem = UserItem(gender: selectUser.gender, name: selectUser.name, location: selectUser.location, email: selectUser.email, phone: selectUser.phone, picture: selectUser.picture)
            performSegue(withIdentifier: segueIdentifier, sender: nil)
            return
        }
        
        let selectUser = usersSort[indexPath.row]
        userItem = UserItem(gender: selectUser.gender, name: selectUser.name, location: selectUser.location, email: selectUser.email, phone: selectUser.phone, picture: selectUser.picture)
        performSegue(withIdentifier: segueIdentifier, sender: nil)
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == segueIdentifier else{return false}
        guard userItem != nil else {return false}
        return true
    }
    
    
}
