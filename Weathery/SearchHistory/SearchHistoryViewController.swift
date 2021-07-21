//
//  ForecastHistoryVC.swift
//  Weathery
//
//  Created by Anon Account on 28.06.2021.
//

import UIKit
import CoreData

class SearchHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var coreDataManager = CoreDataManager(modelName: "WeatherCD")
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        initializeFetchedResultsController()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchHistoryViewCell.nib(), forCellReuseIdentifier: SearchHistoryViewCell.cellIdentifier)
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        let sortDescriptor = NSSortDescriptor(key: "location.name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataManager.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch is losing")
        }
    }

}

// MARK: Configure table view
extension SearchHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryViewCell.cellIdentifier, for: indexPath) as! SearchHistoryViewCell
        
        let object = fetchedResultsController.object(at: indexPath) as! Weather
        DispatchQueue.main.async {
            cell.localtimeLabel.text = object.location?.localtime
            cell.placeLabel.text = object.location?.name
            cell.tempLabel.text = "\(object.current!.temperature) °C"
            cell.descriptLabel.text = object.current?.weatherDescriptions
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
        if editingStyle == .delete {
            coreDataManager.deleteManagedObject(managedObject)
        }
    }
}
    
//MARK: - Refresh fetched controller
extension SearchHistoryViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .delete {
            tableView.deleteRows(at: [indexPath!], with: .left)
        }
    }
        
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }

}
