//
//  UserProfileTableViewController.swift
//  Homework62RandomUser
//
//  Created by 黃柏嘉 on 2022/2/6.
//

import UIKit
import MapKit

class UserProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var userPhotoImageView: UserPhotoImageViw!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    
    
    var userProfile:UserItem
    init?(coder:NSCoder,userProfile:UserItem){
        self.userProfile = userProfile
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    func updateUI(){
        genderLabel.text = userProfile.gender
        titleLabel.text = userProfile.name.title + "."
        firstNameLabel.text = userProfile.name.first
        lastNameLabel.text = userProfile.name.last
        emailLabel.text = userProfile.email
        phoneLabel.text = userProfile.phone
        countryLabel.text = userProfile.location.country
        cityLabel.text = userProfile.location.city
        addressLabel.text = userProfile.location.street.name+","+"\(userProfile.location.street.number)"
        setMap()
        UserListController.shared.fetchImage(url: userProfile.picture.large) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.userPhotoImageView.image = image
                }
            }else{
                DispatchQueue.main.async {
                    self.userPhotoImageView.image = UIImage(systemName: "person.circle.fill")
                }
            }
        }
    }
    
    func setMap(){
        guard let latitude = CLLocationDegrees(userProfile.location.coordinates.latitude),let longitude = CLLocationDegrees(userProfile.location.coordinates.longitude)else{return}
        print(latitude,longitude)
        locationMap.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 500, longitudinalMeters: 500)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "UserLocation"
        annotation.subtitle = "\(latitude),\(longitude)"
        locationMap.addAnnotation(annotation)
    }
    
}
