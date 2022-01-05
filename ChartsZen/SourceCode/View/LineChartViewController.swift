//
//  LineChartViewController.swift
//  ChartsZen
//
//  Created by SaanviSpace on 05/01/22.
//

import UIKit

class LineChartViewController: UIViewController {
    
    @IBOutlet var tbv: UITableView!
    
    var chartsVM:ChartsViewModel = ChartsViewModel()
    var dataArr:[Player] = [Player]() {
        didSet {
            self.tbv.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        customizeView()
        allClosures()
        chartsVM.getChartsData()
    }
    
    private func customizeView() {
        tbv.delegate = self
        tbv.dataSource = self
        tbv.separatorStyle = .none
    }
    
    private func allClosures() {
        chartsVM.receivedJsonData = { players in
            self.dataArr = players
        }
    }
    
}

extension LineChartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tbvCell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        tbvCell.configureCell(player: dataArr[indexPath.row])
        return tbvCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
