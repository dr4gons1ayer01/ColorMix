//
//  ViewController.swift
//  ColorMix
//
//  Created by Иван Семенов on 08.02.2024.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    let mainView = ColorMixView()
    var selectedSquare: UIView? // Свойство для хранения выбранного квадрата
    var currentLanguage = "EN" // По умолчанию установите русский язык
    
    let colorTranslations: [String: [String: String]] = [
        "Черный": ["RU": "Черный", "EN": "Black"],
        "Белый": ["RU": "Белый", "EN": "White"],
        "Серый": ["RU": "Серый", "EN": "Gray"],
        "Красный": ["RU": "Красный", "EN": "Red"],
        "Зелен": ["RU": "Зелен", "EN": "Green"],
        "Синий": ["RU": "Синий", "EN": "Blue"],
        "Голубой": ["RU": "Голубой", "EN": "Cyan"],
        "Желтый": ["RU": "Желтый", "EN": "Yellow"],
        "Пурпурный": ["RU": "Пурпурный", "EN": "Magenta"],
        "Оранжевый": ["RU": "Оранжевый", "EN": "Orange"],
        "Фиолетовый": ["RU": "Фиолетовый", "EN": "Purple"],
        "Розовый": ["RU": "Розовый", "EN": "Pink"],
        "Лимонный": ["RU": "Лимонный", "EN": "Lemon"],
        "Бирюзовый": ["RU": "Бирюзовый", "EN": "Turquoise"],
        "Красно-оранжевый": ["RU": "Красно-оранжевый", "EN": "Red-Orange"],
        "Бирюзово-синий": ["RU": "Бирюзово-синий", "EN": "Turquoise-Blue"],
        "Серо-синий": ["RU": "Серо-синий", "EN": "Grey-Blue"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        addTapGesture()
        
    }
    
    func addTapGesture() {

        let firstColorTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFirstColorSquareTap))
        mainView.firstColorSquare.addGestureRecognizer(firstColorTapGesture)
        mainView.firstColorSquare.isUserInteractionEnabled = true
        
        let secondColorTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSecondColorSquareTap))
        mainView.secondColorSquare.addGestureRecognizer(secondColorTapGesture)
        mainView.secondColorSquare.isUserInteractionEnabled = true
        
        mainView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func handleFirstColorSquareTap() {
        selectedSquare = mainView.firstColorSquare
        
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = mainView.firstColorSquare.backgroundColor ?? .white
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    @objc func handleSecondColorSquareTap() {
        selectedSquare = mainView.secondColorSquare
        
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = mainView.secondColorSquare.backgroundColor ?? .white
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    //TODO: - разобраться с переключением языка
    func updateSelectedColorsWithCurrentLanguage() {
        if let firstColorName = mainView.firstColorLabel.text,
           let translatedFirstColor = colorTranslations[firstColorName],
           let translatedColorName = translatedFirstColor[currentLanguage] {
            mainView.firstColorLabel.text = translatedColorName
        }
        if let secondColorName = mainView.secondColorLabel.text,
           let translatedSecondColor = colorTranslations[secondColorName],
           let translatedColorName = translatedSecondColor[currentLanguage] {
            mainView.secondColorLabel.text = translatedColorName
        }
        if let mixedColor = mainView.resultColorSquare.backgroundColor {
            mainView.resultColorLabel.text = mixedColor.closestStandartColorName() ?? "Непонятный цвет"
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentLanguage = "RU"
            updateSelectedColorsWithCurrentLanguage()
        case 1:
            currentLanguage = "EN"
            updateSelectedColorsWithCurrentLanguage()
        default:
            break
        }
        
    }
    
    func mixColors(firstColor: UIColor, secondColor: UIColor) {
        let mixedColor = mixColor(firstColor: firstColor, secondColor: secondColor)
        
        mainView.resultColorLabel.text = mixedColor.closestStandartColorName() ?? "Непонятный цвет"
        mainView.resultColorSquare.backgroundColor = mixedColor
    }
    
    func mixColor(firstColor: UIColor, secondColor: UIColor) -> UIColor {
        var firstRed: CGFloat = 0, firstGreen: CGFloat = 0, firstBlue: CGFloat = 0, firstAlpha: CGFloat = 0
        var secondRed: CGFloat = 0, secondGreen: CGFloat = 0, secondBlue: CGFloat = 0, secondAlpha: CGFloat = 0
        
        firstColor.getRed(&firstRed, green: &firstGreen, blue: &firstBlue, alpha: &firstAlpha)
        secondColor.getRed(&secondRed, green: &secondGreen, blue: &secondBlue, alpha: &secondAlpha)
        
        let mixedRed = (firstRed + secondRed) / 2
        let mixedGreen = (firstGreen + secondGreen) / 2
        let mixedBlue = (firstBlue + secondBlue) / 2
        let mixedAlpha = (firstAlpha + secondAlpha) / 2
        
        // Создаем и возвращаем новый цвет
        return UIColor(red: mixedRed, green: mixedGreen, blue: mixedBlue, alpha: mixedAlpha)
    }
    
    
}
//MARK: - UIColorPickerViewControllerDelegate
extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // Обновляем цвет только для выбранного квадрата
        selectedSquare?.backgroundColor = viewController.selectedColor
        
        // Обновляем текст Label с названием выбранного цвета
        if let selectedSquare = selectedSquare,
           let colorName = viewController.selectedColor.closestStandartColorName() {
            if selectedSquare == mainView.firstColorSquare {
                mainView.firstColorLabel.text = colorName
            } else if selectedSquare == mainView.secondColorSquare {
                mainView.secondColorLabel.text = colorName
                mixColors(firstColor: mainView.firstColorSquare.backgroundColor ?? .black, secondColor: viewController.selectedColor)
            }
        }
        
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        selectedSquare?.backgroundColor = viewController.selectedColor

        if let selectedSquare = selectedSquare,
           let colorName = viewController.selectedColor.closestStandartColorName() {
            if selectedSquare == mainView.firstColorSquare {
                mainView.firstColorLabel.text = colorName
            } else if selectedSquare == mainView.secondColorSquare {
                mainView.secondColorLabel.text = colorName
                mixColors(firstColor: mainView.firstColorSquare.backgroundColor ?? .black, secondColor: viewController.selectedColor)
            }
        }

    }
}

