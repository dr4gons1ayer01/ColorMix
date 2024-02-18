//
//  UIColor.swift
//  Chall1
//
//  Created by Иван Семенов on 09.02.2024.
//

import UIKit

extension UIColor {
    func closestStandartColorName() -> String? {
        let standardColors: [String: UIColor] = [
            "Черный": .black,
            "Белый": .white,
            "Серый": .gray,
            "Красный": .red,
            "Зелен": .green,
            "Синий": .blue,
            "Голубой": .cyan,
            "Желтый": .yellow,
            "Пурпурный": .magenta,
            "Оранжевый": .orange,
            "Фиолетовый": .purple,
            "Розовый": .systemPink,
            "Лимонный": .systemYellow,
            "Бирюзовый": .systemTeal,
            "Зеленый": .systemGreen,
            "Красно-оранжевый": .systemOrange,
            "Бирюзово-синий": .systemIndigo,
            "Серо-синий": .systemBlue,
        ]
        var closestColorName: String?
        var minDistance: CGFloat = .greatestFiniteMagnitude
        
        for (name, standardColor) in standardColors {
            let distance = self.distance(to: standardColor)
            if distance < minDistance {
                minDistance = distance
                closestColorName = name
            }
        }
        return closestColorName
    }
    func distance(to color: UIColor) -> CGFloat {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let distance = sqrt(pow(r1 - r2, 2) + pow(g1 - g2, 2) + pow(b1 - b2, 2))
        return distance
    }
}
