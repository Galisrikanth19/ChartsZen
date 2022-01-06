//
//  LineChartViewController.swift
//  ChartsZen
//
//  Created by SaanviSpace on 05/01/22.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    
    @IBOutlet var tbv: UITableView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var selIndex = 0
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
            let player = Player(_name: "All Players")
            self.dataArr.append(player)
            self.dataArr.append(contentsOf: players)
        }
    }
    
}

extension LineChartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tbvCell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        if selIndex == indexPath.row {
            tbvCell.configureCell(WithPlayerModel: dataArr[indexPath.row], WithSelectedCell: true)
        } else {
            tbvCell.configureCell(WithPlayerModel: dataArr[indexPath.row], WithSelectedCell: false)
        }
        
        return tbvCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selIndex = indexPath.row
        tbv.reloadData()
    }
}

extension LineChartViewController {
    private func buildCharts() {
//        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
//        //for _dataM in completeArr {
//        let set = setupChart(_dataArr: _dataM.allGraphs!)
//        dataSets.append(set)
//        //}
//
//        let lineChartData = LineChartData(dataSets: dataSets)
//        self.lineChartView.data = lineChartData
//        lineChartView.animate(xAxisDuration: 2.0)
    }

}
