//
//  ViewController.swift
//  TrafficLight
//
//  Created by Anton Redkozubov on 27.05.2021.
//

import UIKit
import SnapKit
import Then


enum Colors {
    case red, yellow, green
}

//MARK: - Appearance

private extension Appearance {
    var alphaContainerView: CGFloat { 0.5 }
    var alphaContainerInit: CGFloat { 1 }
    var buttonCornerRadius: CGFloat { 10 }
    var viewCornerRadius: CGFloat { 75 }
}

class ViewController: UIViewController {
    
    private var currentLight = Colors.red
    
//MARK: - Private Properties
    
    private lazy var box = UIView().then {
        $0.backgroundColor = .black
    }
    
    private lazy var redLight = UIView().then {
        $0.alpha = appearance.alphaContainerView
    }
    
    private lazy var yellowLight = UIView().then {
        $0.alpha = appearance.alphaContainerView
    }
    
    private lazy var greenLight = UIView().then {
        $0.alpha = appearance.alphaContainerView
    }
    
    private lazy var startButton = UIButton().then {
        $0.backgroundColor = .darkGray
        $0.setTitle("Start", for: .normal)
        $0.layer.cornerRadius = appearance.buttonCornerRadius
    }
    
// MARK: - Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        startButton.addTarget(self, action: #selector(lightBegin), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        redLight.layer.cornerRadius = redLight.frame.width / 2
        yellowLight.layer.cornerRadius = yellowLight.frame.width / 2
        greenLight.layer.cornerRadius = greenLight.frame.width / 2
    }
    
    func setupStyle() {
        redLight.backgroundColor = .red
        yellowLight.backgroundColor = .yellow
        greenLight.backgroundColor = .green
        
    }
    
    @objc func lightBegin() {
        print(#function)
        lightBurning()
    }
    
    func lightBurning() {
        startButton.setTitle("Next", for: .normal)
        
        switch currentLight {
        case .red:
            redLight.alpha = appearance.alphaContainerInit
            yellowLight.alpha = appearance.alphaContainerView
            greenLight.alpha = appearance.alphaContainerView
            currentLight = .yellow
        case .yellow:
            redLight.alpha = appearance.alphaContainerView
            yellowLight.alpha = appearance.alphaContainerInit
            currentLight = .green
        case .green:
            yellowLight.alpha = appearance.alphaContainerView
            greenLight.alpha = appearance.alphaContainerInit
            currentLight = .red
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(box)
        box.addSubview(redLight)
        box.addSubview(yellowLight)
        box.addSubview(greenLight)
        box.addSubview(startButton)
        
        box.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        redLight.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        yellowLight.snp.makeConstraints { make in
            make.top.equalTo(redLight).inset(200)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        greenLight.snp.makeConstraints { make in
            make.top.equalTo(yellowLight).inset(200)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(72)
        }
        
    }



}

