import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var roundCount = 0
    @IBOutlet weak var roundCountLabel:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        
        restartGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    func startNewRound(){
        roundCount+=1
        targetValue = 1 + Int(arc4random_uniform(100))
        
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()
    }
    
    func updateLabel(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundCountLabel.text = String(roundCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func restartGame(){
        score = 0
        roundCount = 0
        startNewRound()
    }
    
    @IBAction func sliderMoved(){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert(){
       
        let difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        score += points
        let title:String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1{
                points += 51
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {title = "Not even close..."}
        
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action  = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
       
    }
    
    
    
    
}

