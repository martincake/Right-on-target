//
//  ColorModeViewController.swift
//  Right on target
//
//  Created by Артём Шилоносов on 09.01.2022.
//

import UIKit

class ColorModeViewController: UIViewController {
    
    // связь UI-элементов с кодом
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    // свойства класса для отслеживания параметров игровой сессии
    var score = 0
    var rounds = 1
    var selectedColor: String?
    
    // генератор компонента цвета RGB
    let colorGenerator = NumberGenerator(startValue: 0, endValue: 255)
    // генератор числа от 1 до 4
    let buttonNumberGenerator = NumberGenerator(startValue: 1, endValue: 4)
    
    // возврат на главный экран по нажатию кнопки "назад"
    @IBAction func returnToMainScreenAction() {
        
        dismiss(animated: true, completion: nil)
    }
    
    // при загрузке View начинаем новый раунд
    override func viewDidLoad() {
        newRound()
    }
    
    // алгоритм действий при нажатии кнопки
    @IBAction func colorButtonsAction(_ sender: UIButton) {
        
        // добавляем 50 очков при угадывании
        if selectedColor == sender.currentTitle {
            score += 50
        }
        
        // проверяем количество раундов
        if rounds == 5 {
            // завершаем игру
            showAlertWith(score: score)
            rounds = 1
            score = 0
        } else {
            // увеличиваем номер раунда
            rounds += 1
        }
        
        // начинаем новый раунд
        newRound()
    }
    
    // метод, начинающий новый раунд
    func newRound() {
        
        // словарь, хранящий сгенерированные цвета и коды их компонент
        var rgbDictionary = Dictionary<String, Array<Int>>()
        
        for optionButton in 1...4 {
            
            // переменная для хранения HEX-кода
            var colorString = "#"
            // массив с RGB-кодами
            var rgbArray = Array<Int>()
            
            // генерация компонент RGB и HEX-кода цвета
            for color in 0...2 {
                rgbArray.append((colorGenerator?.getRandomValue())!)
                colorString += intToHex(n: rgbArray[color])
            }
            // сохранение данных о сгенерированном цвете в словарь
            rgbDictionary[colorString] = rgbArray
            
            // присвоение кнопкам HEX-кодов
            switch optionButton {
            case 1: option1.setTitle(colorString, for: .normal)
            case 2: option2.setTitle(colorString, for: .normal)
            case 3: option3.setTitle(colorString, for: .normal)
            case 4: option4.setTitle(colorString, for: .normal)
            default: break
            }
            
            // загадывание цвета
            selectedColor = rgbDictionary.keys.first
            
            // присвоение цвета в Label с использованием инициализатора в расширении
            hexLabel.backgroundColor = UIColor(
                rgbColorCodeRed: rgbDictionary[selectedColor!]![0],
                green: rgbDictionary[selectedColor!]![0],
                blue: rgbDictionary[selectedColor!]![0],
                alpha: 1)
        }
    }
    
    // метод генерирует из кода компонента цвета в Int значение строки в шестнадцатиричном формате
    func intToHex(n: Int) -> String {
        let string = String(format:"%02X", n)
        
        return string
    }
    
    // отображение всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        // создаем View
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы заработали \(score) очков",
                                      preferredStyle: .alert)
        // добавляем в него действие
        alert.addAction(UIAlertAction(title: "Начать заново",
                                      style: .default,
                                      handler: nil))
        // отображаем View на экране
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - Расширение для упрощенной инициализации цвета классу UIColor через значения Int

extension UIColor {
    convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let redPart: CGFloat = CGFloat(red) / 255
        let greenPart: CGFloat = CGFloat(green) / 255
        let bluePart: CGFloat = CGFloat(blue) / 255

        self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
    }
}
