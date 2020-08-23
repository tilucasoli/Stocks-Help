//
//  ChartView.swift
//  Stocks Help
//
//  Created by Lucas Oliveira on 13/08/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit
import Charts

class ChartView: UIView {
    let pieChart: PieChartView = {
        let pieChart = PieChartView()
        
        pieChart.legend.enabled = false
        pieChart.holeRadiusPercent = 0.45
        
        pieChart.transparentCircleRadiusPercent = 0.5
        pieChart.transparentCircleColor = UIColor.white.withAlphaComponent(0.25)
        
        pieChart.usePercentValuesEnabled = true
        
        return pieChart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPieChart()
        
        updateChartData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatingDataSet() -> [PieChartDataEntry] {
        var dataSetList = [PieChartDataEntry]()
        
        for index in 0..<ListAssets.list.count {
            let asset = ListAssets.list[index]
            dataSetList += [PieChartDataEntry(value: Double(asset.qnty))]
            dataSetList[index].label = asset.symbol
        }
        
        return dataSetList
    }
    
    //Refatorar essa parte do código
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: creatingDataSet(), label: "Lucas")
        chartDataSet.selectionShift = 0
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.redSH, UIColor.purpleSH, UIColor.greenSH]
        
        chartDataSet.colors = colors as [NSUIColor]
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        pieChart.data = chartData
        
    }
    
    func setupPieChart() {
        addSubview(pieChart)
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: topAnchor),
            pieChart.rightAnchor.constraint(equalTo: rightAnchor),
            pieChart.leftAnchor.constraint(equalTo: leftAnchor),
            pieChart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
