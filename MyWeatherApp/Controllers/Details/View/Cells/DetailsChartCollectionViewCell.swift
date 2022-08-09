//
//  DetailsChartCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import UIKit
import Charts
import SnapKit


class DetailsChartCollectionViewCell: UICollectionViewCell, ChartViewDelegate {
    
    static let identifier = "DetailsChartCollectionViewCell"
    
    
    // MARK: PROPERTIES ============================================================================
    
    private lazy var temperatureChart: LineChartView = {
        let chart = LineChartView()
        
        var entries = [ChartDataEntry]()
        for x in 0..<10 { entries.append(ChartDataEntry(x: Double(x), y: Double(x))) }
        
        let set = LineChartDataSet(entries: entries)
        let data = LineChartData(dataSet: set)
        
//        set.colors = ChartColorTemplates.material()
        chart.data = data
        
        chart.isUserInteractionEnabled = false
        return chart
    }()

    
    
    // MARK: INITS ============================================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        temperatureChart.delegate = self
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
        
        contentView.addSubviews(temperatureChart)
        
        temperatureChart.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview().inset(16)
        }
    }
        
    
    
}

