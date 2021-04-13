//
//  GameResultPopUpController.swift
//  EcoRanger
//
//  Created by Samlo Berutu on 09/04/21.
//

import UIKit

protocol CustomViewDelegate: class {
    func goToNextScene()
}

class GameResultPopUpController: UIView {

    static let instance = GameResultPopUpController()
    @IBOutlet var parentView:UIView!
    @IBOutlet var childView:UIView!
    @IBOutlet var starView:UIImageView!
    @IBOutlet var trueBtn:UIButton!
    @IBOutlet var falseBtn:UIButton!
    @IBOutlet var nextBtn:UIButton!
    @IBOutlet var succesLbl:UILabel!
    @IBOutlet var failureLbl:UILabel!
    
    weak var delegate: CustomViewDelegate?
    
    @IBAction func trueButton(_ sender: Any){
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        print("resume button")
    }
    @IBAction func falseButton(_ sender: Any) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        print("home button")
        parentView.removeFromSuperview()
        //tempat kosong
        
    }
    @IBAction func nextButton(_ sender: Any) {
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        delegate?.goToNextScene()
        parentView.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("GameResultPopUp", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum AlertType{
        case success
        case failure
    }
    
    private func commonInit(){
        trueBtn.layer.cornerRadius = 5
        falseBtn.layer.cornerRadius = 5
        nextBtn.layer.cornerRadius = 5
        childView.layer.cornerRadius = 10
        
        parentView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showResultView(alertType: AlertType){
        print("Result View")
        if alertType == .success {
            print("success")
            //success asset
            trueBtn.isHidden = true
            falseBtn.isHidden = true
            failureLbl.isHidden = true
            //failure asset
            succesLbl.isHidden = false
            nextBtn.isHidden = false
            starView.isHidden = false
            
        }else if alertType == .failure{
            print("failure")
            //failure asset
            succesLbl.isHidden = true
            nextBtn.isHidden = true
            starView.isHidden = true
            //success asset
            trueBtn.isHidden = false
            falseBtn.isHidden = false
            failureLbl.isHidden = false
        }else{
            print("error")
        }
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
//    func returnToHome{
//        //direct ke home
//    }

}
