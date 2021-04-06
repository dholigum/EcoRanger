//
//  GameViewController.swift
//  EcoRanger
//
//  Created by Christopher Teddy  on 06/04/21.
//

import UIKit

class GameViewController: UIViewController {
    
    //Declare Model
    var tutorModelInGame: Thumbnail?

    @IBOutlet weak var lblTEST: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblTEST.text = "DUAR CHAPTER BERAPA NI \(tutorModelInGame?.chapter as! String)"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
