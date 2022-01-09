/**
 Сущность "Раунд"
 */

import Foundation

protocol GameRoundProtocol {
    
    // количество заработанных очков
    var score: Int { get }
    // загаданное значение
    var currentSecretValue: Int { get }
    
    // сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {
    
    var score: Int = 0
    // минимальное загаданное значение
    var currentSecretValue: Int = 0

    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    
    // подсчитывает количество очков
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 + value - currentSecretValue
        } else {
            score += 50
        }
    }
}
