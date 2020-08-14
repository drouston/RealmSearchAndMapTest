//
//  ViewControllerA.swift
//  RealmMapViewTest
//
//  Created by Drew Collier on 8/10/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//


import UIKit
import RealmSwift
import RealmSwiftSFRestaurantData
import RealmMapView
import RealmSwiftBlogData
import RealmSearchViewController

class MapViewController: UIViewController {

    var mapView: RealmMapView
    var realmSearchViewController = RealmSearchViewController()
    var searchView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        mapView = RealmMapView()
        mapView.entityName = "ABFRestaurantObject"
        mapView.latitudeKeyPath = "latitude"
        mapView.longitudeKeyPath = "longitude"
        mapView.titleKeyPath = "name"
        mapView.subtitleKeyPath = "phoneNumber"
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        mapView = RealmMapView()
        mapView.entityName = "ABFRestaurantObject"
        mapView.latitudeKeyPath = "latitude"
        mapView.longitudeKeyPath = "longitude"
        mapView.titleKeyPath = "name"
        mapView.subtitleKeyPath = "phoneNumber"
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(toggleViews))
        navigationItem.rightBarButtonItem = resetButton
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        realmSearchViewController.useContainsSearch = true
        realmSearchViewController.entityName = "BlogObject"
        realmSearchViewController.searchPropertyKeyPath = "title"
        realmSearchViewController.tableView.register(EventCell.self, forCellReuseIdentifier: "eventCell")
        realmSearchViewController.tableView.rowHeight = 50
        realmSearchViewController.resultsDelegate = self
        realmSearchViewController.resultsDataSource = self
        searchView = realmSearchViewController.tableView
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL = URL(string: ABFRestaurantScoresPath())
        print("config: ", config)
        mapView.realmConfiguration = config
        
        /**
        *  Set the cluster title format string
        *  $OBJECTSCOUNT variable track cluster count
        */
        self.mapView.fetchedResultsController.clusterTitleFormatString = "$OBJECTSCOUNT restaurants in this area"
        
        /**
        *  Add filtering to the result set in addition to the bounding box filter
        */
        self.mapView.basePredicate = NSPredicate(format: "name BEGINSWITH 'A'")
        
        /**
        *  Limit the map results
        */
        self.mapView.resultsLimit = 200
    }
    
    @objc func toggleViews() {
        if mapView.isHidden == true {
            mapView.isHidden = false
            realmSearchViewController.tableView.isHidden = true
        } else {
            mapView.isHidden = true
            realmSearchViewController.tableView.isHidden = false
        }
        print("toggleViews")
    }
}

extension MapViewController: RealmSearchResultsDataSource {
    func searchViewController(_ controller: RealmSearchViewController, cellForObject object: Object, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = realmSearchViewController.tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        if let blog = object as? BlogObject {
            cell.titleLabel.text = blog.title.capitalized
            cell.dateLabel.text = dateFormatter.string(from: blog.date)
            cell.eventImage.image = UIImage(named: "Pink Logo")
            cell.calColorView.backgroundColor = UIColor.orange
        }

        return cell
    }
}

extension MapViewController: RealmSearchResultsDelegate {
    func searchViewController(_ controller: RealmSearchViewController, willSelectObject anObject: Object, atIndexPath indexPath: IndexPath) {
        print("searchViewController willSelectObject: ")
    }
    
    func searchViewController(_ controller: RealmSearchViewController, didSelectObject anObject: Object, atIndexPath indexPath: IndexPath) {
        print("searchViewController didSelectObject: ")
    }
    
    
}

/*extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let safeObjects = ClusterAnnotationView.safeObjects(forClusterAnnotationView: view) {
            
            if let firstObjectName =
                safeObjects.first?.toObject(ABFRestaurantObject.self).name {
                print("First Object: \(firstObjectName)")
            }
            
            print("Count: \(safeObjects.count)")
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if self.mapView.fetchedResultsController.safeObjects.count == self.mapView.resultsLimit {
            print("Hit Results Limit!")
        }
    }
}
*/
