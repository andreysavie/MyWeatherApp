//
//  OnboardingView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 08.08.2022.
//

import UIKit
import SnapKit

class OnboardingView: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "onboarding_image")
        let view = UIImageView(image: image)
        return view
    }()

    private lazy var titleLabel = getLabel(
        text: """
              Разрешить приложению  Weather использовать данные
              о местоположении вашего устройства
              """,
        font: Fonts.onboardTitleFont,
        color: Colors.darkTextColor
    )
    
    private lazy var descriptionLabel = getLabel(
        text: """
                Чтобы получить более точные прогнозы погоды во время движения или путешествия
              \n\nВы можете изменить свой выбор в любое время из меню приложения
              """,
        font: Fonts.onboardDescriptionFont,
        color: Colors.darkTextColor
    )

    private lazy var separateView: SeparateLineView = {
        let line = SeparateLineView(frame: .zero)
        return line
    }()
    
    
    private lazy var confimButton: CustomButton = {
        let button = CustomButton(
            title: "Использовать местоположение устройства".uppercased(),
            font: Fonts.onboardConfimFont
        )
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
        
        confimButton.tapAction = { [weak self] in
            self?.buttonPressed()
        }
    }
    
    func buttonPressed() {
        print ("pressed!!!")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout() {
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        getShadow(self)
        
        addSubviews(imageView,
                    titleLabel,
                    descriptionLabel,
                    confimButton,
                    separateView
        )
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(38)
            make.width.equalTo(180)
            make.height.equalTo(200)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        confimButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(self.snp.bottom).inset(25)
        }
        
        separateView.makeConstraints(atBottom: self.snp.bottom)
    }
}

