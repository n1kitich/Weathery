//
//  ForecastHistoryVC.swift
//  Weathery
//
//  Created by Anon Account on 28.06.2021.
//

import UIKit
import CoreData

class ForecastHistoryVC: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        setupTableView()
        setupFetchedController()

    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(ForecastViewCell.self, forCellReuseIdentifier: ForecastViewCell.cellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ForecastViewCell.cellIdentifier)
    }
    
    func setupFetchedController() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        let sortDescriptor = NSSortDescriptor(key: "temperature", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch is losing")
        }
    }

}

extension ForecastHistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastViewCell.cellIdentifier, for: indexPath) //as! ForecastViewCell
        
        let object = fetchedResultsController.object(at: indexPath) as! Weather
//        cell.configure(temperature: object.temperature!, description: object.descript!)
        cell.textLabel?.text = object.descript
        return cell
    }
    
}
