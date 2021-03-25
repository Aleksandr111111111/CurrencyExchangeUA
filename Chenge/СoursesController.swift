//
//  СoursesController.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 07.12.2020.
//

import UIKit

class СoursesController: UITableViewController {
    
    
    @IBAction func pushRefrehAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadXML") , object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                activityIndicator.startAnimating()
                activityIndicator.color = UIColor.green
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed") , object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = Model.shared.currentDate
                
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefrehAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"ErrorWhenXMLloading"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["ErrorName"]
            print(errorName!)
        
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"ErrorWhenXMLloading"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["ErrorName"]
            print(errorName!)
            DispatchQueue.main.async {
                let alert = UIAlertController(title:"ErrorWhenXMLloading", message: "", preferredStyle: UIAlertController.Style.alert)
                
                let alertAcnion = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(alertAcnion)
                self.present(alert, animated: true, completion: nil)
                
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefrehAction(_:)))
                
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
            
        }
        

        navigationItem.title = Model.shared.currentDate
        
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        Model.shared.loadXMLFile(date: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Model.shared.currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseCell
        
        let courseForCell = Model.shared.currencies[indexPath.row]
        cell.initCell(currency: courseForCell)
        
//        cell.textLabel?.text = courseForCell.Name
//        cell.detailTextLabel?.text = courseForCell.Value

        return cell
    }
}
