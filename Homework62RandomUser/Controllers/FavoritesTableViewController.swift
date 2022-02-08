//
//  FavoritesTableViewController.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/8.
//

import UIKit
private let reusableIdentifier = "favoritesItemCell"
private let segueIdentifier = "showFavoritesUserProfile"

class FavoritesTableViewController: UITableViewController {

    var favorites = [Favorites](){
        didSet{
            Favorites.save(favorites)
        }
    }
    var userItem:UserItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let loadData = Favorites.load(){
            favorites = loadData
            tableView.reloadData()
        }
    }

    @IBSegueAction func passUserItem(_ coder: NSCoder) -> UserProfileTableViewController? {
        return UserProfileTableViewController(coder: coder, userProfile: userItem!)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard favorites.isEmpty == false else{return 0}
        return favorites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! FavoritesItemTableViewCell
        configure(cell, forRowAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userItemData = favorites[indexPath.row].users
        userItem = UserItem(gender: userItemData.gender, name: userItemData.name, location: userItemData.location, email: userItemData.email, phone: userItemData.phone, picture: userItemData.picture)
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == segueIdentifier{
            guard userItem != nil else{return false}
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    func configure(_ cell:FavoritesItemTableViewCell,forRowAt indexPath:IndexPath){
        let userItem = favorites[indexPath.row].users
        cell.userNameLabel.text = userItem.name.first + "," + userItem.name.last
        UserListController.shared.fetchImage(url: userItem.picture.medium) { image in
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
