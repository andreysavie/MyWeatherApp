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
    
    private var hourlyTempArray = [Int]()
    private var hours = [String]()
    
    private lazy var temperatureChart: LineChartView = {
        let chart = LineChartView()
        
        var entries = [ChartDataEntry]()
        if hourlyTempArray.count >= 12 {
            for x in 0..<12 { entries.append(ChartDataEntry(x: Double(hours[x]) ?? 0, y: Double(hourlyTempArray[x]))) }
        }
        
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
    
    func configureOfCell(_ weather: WeatherModel?) {
        guard let weather = weather else { return }
        
        let hourly = weather.hourly
        for hour in hourly {
            hourlyTempArray.append(Int(hour.temp))
            hours.append(Date.getCurrentDate(dt: hour.dt, style: .hour))
        }
    }
        
    
    
}

