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
            checkChartModelDataAndBuildChart(_playerArr: [dataArr[0]])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        customizeView()
        allClosures()
        customizeChartUI()
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
        checkChartModelDataAndBuildChart(_playerArr: [dataArr[indexPath.row]])
    }
    
    private func checkChartModelDataAndBuildChart(_playerArr: [Player]) {
        let player = _playerArr[0]
        if player.name == "All Players" {
            var newPlayerArr:[Player] = [Player]()
            newPlayerArr.append(contentsOf: self.dataArr)
            newPlayerArr.removeFirst()
            buildChartsWithData(playerArr: newPlayerArr)
        } else {
            buildChartsWithData(playerArr: _playerArr)
        }
    }
}

extension LineChartViewController {
    private func customizeChartUI() {
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.granularity = 1
        lineChartView.leftAxis.drawGridLinesEnabled = false
    }
    
    private func buildChartsWithData(playerArr: [Player]) {
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        for _dataM in playerArr {
            let set = setupChart(_playerIs: _dataM)
            dataSets.append(set)
        }
        
        let lineChartData = LineChartData(dataSets: dataSets)
        self.lineChartView.data = lineChartData
        lineChartView.animate(xAxisDuration: 2.0)
    }
    
    private func setupChart(_playerIs: Player) -> LineChartDataSet {
        var yVals : [ChartDataEntry] = [ChartDataEntry]()
        var xAxisVals:[String] = [String]()
        
        guard let playersHistory = _playerIs.history else { return LineChartDataSet()}
        for (index, dataIs) in playersHistory.enumerated() {
            if let _modified = dataIs.modified, let _score = dataIs.score {
                xAxisVals.append(_modified)
                yVals.append(ChartDataEntry(x: Double(index), y: Double(_score)))
            }
        }
        
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisVals)
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        let randomColor:UIColor = ThemeManager.generateRandomColor()
        
        let set: LineChartDataSet = LineChartDataSet(entries: yVals, label: _playerIs.name)
        set.axisDependency = .left
        set.setColor(randomColor.withAlphaComponent(0.5))
        set.setCircleColor(randomColor)
        set.lineWidth = 2.0
        set.circleRadius = 5.0
        set.circleHoleRadius = 3.0
        set.fillAlpha = 65 / 255.0
        set.fillColor = randomColor
        set.highlightColor = UIColor.red
        set.drawCircleHoleEnabled = true
        set.drawValuesEnabled = false
        set.circleHoleColor = randomColor
        return set
    }

}
