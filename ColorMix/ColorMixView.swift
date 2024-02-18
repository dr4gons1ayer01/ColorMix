//
//  ColorMixView.swift
//  ColorMix
//
//  Created by Иван Семенов on 08.02.2024.
//

import UIKit

class ColorMixView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.text = "Mix Colors"
        label.font = .systemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    let firstColorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Выберите цвет"
        return label
    }()
    let firstColorSquare: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.tintColor = .black
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = .systemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    let secondColorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Выберите цвет"
        return label
    }()
    
    let secondColorSquare: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.tintColor = .black
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    let equalsLabel: UILabel = {
        let label = UILabel()
        label.text = "="
        label.font = .systemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    let resultColorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Полученный цвет"
        return label
    }()
    let resultColorSquare: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.tintColor = .black
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["RU", "EN"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 1
        return segmentedControl
    }()
    
    init() {
        super.init(frame: CGRect())
        setViews()
        setCostraints()
    }
    func setViews() {
        backgroundColor = UIColor(named: "bg")
        
    }
    func setCostraints() {
        let firstColorStack = UIStackView(views: [firstColorLabel, firstColorSquare],
                                          axis: .vertical,
                                          spacing: 10)
        
        let secondColorStack = UIStackView(views: [secondColorLabel, secondColorSquare],
                                           axis: .vertical,
                                           spacing: 10)
        
        let resultColorStack = UIStackView(views: [resultColorLabel, resultColorSquare],
                                           axis: .vertical,
                                           spacing: 10)
        
        let stack = UIStackView(views: [label, firstColorStack, plusLabel, secondColorStack, equalsLabel, resultColorStack],
                                axis: .vertical,
                                spacing: 30)
        addSubview(stack)
        addSubview(segmentedControl)
        stack.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            segmentedControl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

struct ColorViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = ColorMixView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
