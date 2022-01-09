/**
 Сущность "Генератор случайных чисел"
 */

import Foundation

protocol GeneratorProtocol {
    
    // хранит алгоритм, возвращаюший новое случайное значение
    func getRandomValue() -> Int
}

class NumberGenerator: GeneratorProtocol {
    
    private let startRangeValue: Int
    private let endRangeValue: Int
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    // загадать и вернуть новое случайное значение
    func getRandomValue() -> Int {
        (startRangeValue...endRangeValue).randomElement()!
    }
}
