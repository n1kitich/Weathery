//
//  ForecastHistoryVC.swift
//  Weathery
//
//  Created by Anon Account on 28.06.2021.
//

import UIKit

class ForecastHistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

}

extension ForecastHistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        return cell
    }
    
}
