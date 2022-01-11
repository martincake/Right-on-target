/**
 Главный экран игры - выбор режимов
 */
import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Загрузка и отображение View Controller числового режима игры
    
    // ленивое свойство для хранения контроллера режима игры
    lazy var numberModeViewController: NumberModeViewController = getNumberModeViewController()
    
    // приватный метод возвращающий View Controller данного режима игры
    private func getNumberModeViewController() -> NumberModeViewController {
        // загружаем Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // загружаем View Controller и его сцены со Storyboard
        let numberModeViewController = storyboard.instantiateViewController(
            withIdentifier: "NumberModeViewController")
        // возвращаем View Controller с числовым режимов игры после кастования
        return numberModeViewController as! NumberModeViewController
    }
    
    // метод, вызывающий отображение View Controller по нажатию на кнопку
    @IBAction func numberModeSelection() {
        // отображаем сцену на экране
        present(numberModeViewController, animated: true, completion: nil)
    }
    
    //MARK: - Загрузка и отображение View Controller цветового режима игры
    
    //алгоритм действий аналогичен алгоритму выше
    
    lazy var colorModeViewController: ColorModeViewController = getColorModeViewController()
    
    private func getColorModeViewController() -> ColorModeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let colorModeViewController = storyboard.instantiateViewController(
            withIdentifier: "ColorModeViewController")
        return colorModeViewController as! ColorModeViewController
    }
    
    @IBAction func colorModeSelection() {
        present(colorModeViewController, animated: true, completion: nil)
    }
}
