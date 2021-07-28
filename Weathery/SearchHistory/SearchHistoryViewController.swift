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
    
    @IBAction func clearHistory(_ sender: UIBarButtonItem) {
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchHistoryViewCell.nib(), forCellReuseIdentifier: SearchHistoryViewCell.cellIdentifier)
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Current")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
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
        
        let object = fetchedResultsController.object(at: indexPath) as! Current
        let localTime = Int(object.dt)
        
        DispatchQueue.main.async {
            var temperature = object.main.temp
            cell.localtimeLabel.text = localTime.getDateStringFromUnix()
            cell.placeLabel.text = object.name
            cell.tempLabel.text = "\(temperature.roundedToInt())°"
            cell.descriptLabel.text = object.weather.weatherDescription?.capitalized
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
