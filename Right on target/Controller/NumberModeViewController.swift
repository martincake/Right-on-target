/**
 Контроллер экрана игры по угадыванию положения слайдера
 */

import UIKit

class NumberModeViewController: UIViewController {

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
        
        // создаем генератор случайных чисел
        let generator = NumberGenerator(startValue: 1, endValue: 50)!
        // создаем экземпляр сущности "Игра"
        game = Game(valueGenerator: generator, rounds: 5)
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
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
    
    //MARK: - Возврат на главный экран
    
    @IBAction func returnToMainScreenAction() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Начало новой игры
    
    @IBAction func newGameAction() {
        
        // перезапускаем игру
        game.restartGame()
        // обновляем загаданное число на экране
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    //MARK: - Взаимодействие View - Model
    
    // проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        
        // высчитываем очки за раунд
        game.currentRound.calculateScore(with: Int(slider.value))
        // проверяем, окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    //MARK: - Обновление View
    
    // Обновление текста загаданного числа
    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
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

