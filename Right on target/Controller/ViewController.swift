//
//  ViewController.swift
//  Right on target
//
//  Created by Артём Шилоносов on 09.01.2022.
//

import UIKit

class ViewController: UIViewController {

    // сущность "Игра"
    var game: Game!
    
    // элементы UI
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    //MARK: - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        // создаем экземпляр сущности "Игра"
        game = Game(startValue: 1, endValue: 50, rounds: 5)
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear")
    }
    
    
    //MARK: - Взаимодействие View - Model
    
    // проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        
        // высчитываем очки за раунд
        game.calculateScore(with: Int(slider.value))
        // проверяем, окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }
    
    //MARK: - Обновление View
    
    // Обновление текста загаданного числа
    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }
    
    // отображение всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы заработали \(score) очков",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

