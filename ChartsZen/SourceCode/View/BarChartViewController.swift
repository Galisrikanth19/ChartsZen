//
//  BarChartViewController.swift
//  ChartsZen
//
//  Created by SaanviSpace on 05/01/22.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    
    @IBOutlet var tbv: UITableView!
    @IBOutlet weak var chartView: BarChartView!
    
    var selIndex = 0
    var chartsVM:ChartsViewModel = ChartsViewModel()
    var xAxisVals: [String] = [String]()
    var yAxisVals = [Double]()
    
    var dataArr:[Player] = [Player]() {
        didSet {
            self.tbv.reloadData()
            buildChartsWithData(playerIs: dataArr[0])
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
            self.dataArr.append(contentsOf: players)
        }
    }
    
}

extension BarChartViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        buildChartsWithData(playerIs: dataArr[indexPath.row])
    }
    
}

extension BarChartViewController {
    
    private func buildChartsWithData(playerIs: Player) {
        xAxisVals = [String]()
        yAxisVals = [Double]()
        
        guard let playersHistory = playerIs.history else { return }
        for (_, dataIs) in playersHistory.enumerated() {
            xAxisVals.append(dataIs.modified ?? "")
            yAxisVals.append(Double(dataIs.score ?? 0))
        }
        
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        chartView.xAxis.labelPosition = .bottom
        chartView.rightAxis.enabled = false
        setChart(dataEntryX: xAxisVals, dataEntryY: yAxisVals, ForTitle: playerIs.name ?? "")
    }
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double], ForTitle title: String) {
        var dataEntries:[BarChartDataEntry] = []
        for i in 0..<forX.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: xAxisVals as AnyObject?)
           dataEntries.append(dataEntry)
        }
        let randomColor:UIColor = ThemeManager.generateRandomColor()
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: title)
        chartDataSet.colors = [randomColor]
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        chartView.xAxis.granularity = 1
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisVals)
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
    }

}
