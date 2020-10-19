
import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1 //cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations =
        //横
        [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],
         //縦
         [0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],
         //斜め４列
         [0,5,10,15],[3,6,9,12],
        //正方形４つ
       [0,1,4,5], [2,3,6,7], [8,9,12,13], [10,11,14,15],
       //真ん中正方形　１つ
       [5,6,9,10],
       //正方形の中２つ
       [1,2,5,6],[9,10,13,14]
        ]
       
    
    
    var gameIsActive = true
    
    @IBOutlet weak var label: UILabel!
    
    
    
    @IBAction func action(_ sender: AnyObject)
    {
        if (gameState[sender.tag-1] == 0 && gameIsActive == true)
        {
            gameState[sender.tag-1] = activePlayer
            
            if (activePlayer == 1)
            {
                sender.setImage(UIImage(named: "Cross.png"),for: UIControl.State())
                activePlayer = 2
            }
            else {
                sender.setImage(UIImage(named: "Nought.png"),for: UIControl.State())
                activePlayer = 1
            }
        }
        
        for combination in winningCombinations
        {
            if gameState[combination[0]] != 0 &&
                // 0番目と1番目が同じコマか判断
                gameState[combination[0]] == gameState[combination[1]] &&
                // 1番目と2番目が同じコマか判断
                gameState[combination[1]] == gameState[combination[2]] &&
                // 2番目と3番目が同じコマか判断
                gameState[combination[2]] == gameState[combination[3]] {
                gameIsActive = false
                
                if gameState[combination[0]] == 1
                {
                    label.text = "✖️の勝ち！"
                }
                else
                {
                    label.text = "○の勝ち！"
                }
                
                playAgainButton.isHidden = false
                label.isHidden = false
                
                return 
            }
        }
        
        gameIsActive = false
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        if gameIsActive == false {
            label.text = "引き分け！"
            label.isHidden = false
            playAgainButton.isHidden = false
        }
    }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: AnyObject) {
        
        gameState = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        gameIsActive = true
        activePlayer = 1
        
        playAgainButton.isHidden = true
        label.isHidden = true
        
        for i in 1...16 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
