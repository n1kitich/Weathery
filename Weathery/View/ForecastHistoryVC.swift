//
//  ForecastHistoryVC.swift
//  Weathery
//
//  Created by Anon Account on 28.06.2021.
//

import UIKit
import CoreData

class ForecastHistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        fetchedResultsController = getFetchedController()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch is losing")
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForecastViewCell.nib(), forCellReuseIdentifier: ForecastViewCell.cellIdentifier)
    }
    
    func getFetchedController() -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        let sortDescriptor = NSSortDescriptor(key: "temperature", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultsController
    }

}

// MARK: Configure table view
extension ForecastHistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastViewCell.cellIdentifier, for: indexPath) as! ForecastViewCell
        
        let object = fetchedResultsController.object(at: indexPath) as! Weather
        cell.localtimeLabel.text = object.location?.localtime
        cell.placeLabel.text = object.location?.name
        cell.tempLabel.text = "\(object.current!.temperature)"
        cell.descriptLabel.text = object.current?.weatherDescriptions
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
        
        if editingStyle == .delete {
            managedObjectContext.delete(managedObject)
            do {
                try managedObjectContext.save()
            } catch {
                print("Failed to delete object")
            }
        }
    }
}
    
//MARK: - Refresh fetched controller
extension ForecastHistoryVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .delete {
            tableView.deleteRows(at: [indexPath!], with: .left)
        }
    }
        
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
