//
//  PieChartViewController.swift
//  ChartsZen
//
//  Created by SaanviSpace on 05/01/22.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    
    var chartsVM:ChartsViewModel = ChartsViewModel()
    var playersNames: [String] = [String]()
    var totalScores: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        allClosures()
        chartsVM.getChartsData()
        customizeChart(dataPoints: playersNames, values: totalScores.map{ Double($0) })
    }
    
    private func allClosures() {
        chartsVM.receivedJsonData = { playersArr in
            for playerM in playersArr {
                let playerName: String = playerM.name ?? ""
                var playerTotalScore = 0
                
                if let playerHistory = playerM.history {
                    for historyRecord in playerHistory {
                        playerTotalScore = playerTotalScore + (historyRecord.score ?? 0)
                    }
                }
                
                self.playersNames.append(playerName)
                self.totalScores.append(playerTotalScore)
            }
        }
    }
    
}

extension PieChartViewController {
    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        chartView.data = pieChartData
        chartView.holeColor = ThemeManager.generateRandomColor()
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let color = ThemeManager.generateRandomColor()
            colors.append(color)
        }
        return colors
    }
}
