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
    
    // MARK: PROPERTIES
    
    private var hourlyTempArray = [Double]()
    private var entries = [ChartDataEntry]()

    private var hours = [Double]() {
        didSet {
            if hours.count == 12 {
                for x in 0..<hours.count { entries.append(ChartDataEntry(x: Double(x), y: hourlyTempArray[x] )) }
                let set = LineChartDataSet(entries: entries)
                let data = LineChartData(dataSet: set)
                temperatureChart.data = data
            }
        }
    }
    
    private lazy var temperatureChart: LineChartView = {
        let chart = LineChartView()
        chart.isUserInteractionEnabled = false
        return chart
    }()

    
    
    // MARK: INITS
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        temperatureChart.delegate = self
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS
    
    
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
        guard let wthr = weather else { return }
        
        let hourly = wthr.hourly
        for hour in hourly {
            hourlyTempArray.append(hour.temp)
            hours.append(Double(Date.getCurrentDate(dt: hour.dt, style: .hour)) ?? 0)
        }
    }
        
    
    
}

