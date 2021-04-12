//
//  ViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmentedViewController: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var storyBgImage: UIImageView!
    
    var dataThumbail = [Thumbnail]()
    var dataThumbailFiltered = [Thumbnail]()
    private var indexSelected = 0
    var StorySelected = "Cerita 1"
    var MenuBGM = AVAudioPlayer()
    var ButtonPressSFX = AVAudioPlayer()
    var SFXAllowStatus = true
    
    var dataThumbnailCoreData = [Thumbnail]()
    
    //popUp var space
    @IBOutlet var settingView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBAction func backButton(_ sender: UIButton) {
        popUpTransitionOut(desiredView: settingView)
        popUpTransitionOut(desiredView: blurView)
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
    }
    @IBOutlet weak var SFXSwitch: UISwitch!
    @IBOutlet weak var BGMSwitch: UISwitch!
    @IBAction func sfxButton(_ sender: Any) {
        print("ini switch sfx")
        if SFXSwitch.isOn
        {
            print("On")
            SFXAllowStatus = true
        }
        else
        {
            print("Off")
            SFXAllowStatus = false
        }
    }
    @IBAction func bgmSwitch(_ sender: Any) {
        print("ini switch BMG")
        if BGMSwitch.isOn
        {
            print("On")
            MenuBGM.play()
        }
        else
        {
            print("Off")
            MenuBGM.stop()
        }
    }
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        CoreDataHandle.initCoreData(appDelegate)
        
        //Get All Data from core data
        dataThumbnailCoreData = CoreDataHandle.getAllThumbailData()
        print("Size nya berapa onViewDidLoad -> \(dataThumbnailCoreData.count)")
        
        //Prevent Duplicate Data
        if ( dataThumbnailCoreData.count == 0) {
            initDataThumbnail()
        } else {
            dataThumbailFiltered = dataThumbnailCoreData
            dataThumbail = dataThumbnailCoreData
            dataThumbailFiltered = dataThumbail.filter({ (Thumbnail) -> Bool in
                return Thumbnail.story == "Cerita 1"
            })
            dataThumbailFiltered = dataThumbail
        }
        
        //popUp setting button
        setUpPopUpSettingView()
       
        
        setUpUISegmented()
        
      
        
        //Play BGM on Menu Load
   //     MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "MainMenuBGM")
        
        
//        do{
//            MenuBGM = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:  Bundle.main.path(forResource: "MainMenuBGM", ofType: ".mp3")!))
//            MenuBGM.prepareToPlay()
//            MenuBGM.play()
//        }
//        catch{
//            print(error)
//        }
        
        //Prepare SFX on Button Press
        do{
            ButtonPressSFX = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:  Bundle.main.path(forResource: "ButtonPress", ofType: ".wav")!))
            ButtonPressSFX.prepareToPlay()
        }
        catch{
            print(error)
        }
    }
    
    func setUpUISegmented() {
        segmentedViewController.layer.cornerRadius = 15
        
        let font = UIFont(name: "Luckiest Guy Regular", size: 15)
        
        SegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white,
                                               NSAttributedString.Key.font : font], for: .normal)
        
    }
    
    
    //Story Segmented Control
    @IBAction func DidChangeSegment(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            StorySelected = "Cerita 1"
            storyBgImage.image = #imageLiteral(resourceName: "homescreenbg")
            collectionView.reloadData()
            if SFXAllowStatus
            {
                if ButtonPressSFX.isPlaying
                {
                    ButtonPressSFX.stop()
                }
                ButtonPressSFX.play()
            }
        }
        else if sender.selectedSegmentIndex == 1
        {
            StorySelected = "Cerita 2"
            storyBgImage.image = #imageLiteral(resourceName: "parkbg")
            collectionView.reloadData()
            if SFXAllowStatus
            {
                if ButtonPressSFX.isPlaying
                {
                    ButtonPressSFX.stop()
                }
                ButtonPressSFX.play()
            }
        }
        else if sender.selectedSegmentIndex == 2
        {
            StorySelected = "Cerita 3"
            storyBgImage.image = #imageLiteral(resourceName: "beachbg")
            collectionView.reloadData()
            if SFXAllowStatus
            {
                if ButtonPressSFX.isPlaying
                {
                    ButtonPressSFX.stop()
                }
                ButtonPressSFX.play()
            }
        }
        
        //Get all Data Core Data
        dataThumbnailCoreData = CoreDataHandle.getAllThumbailData()
        dataThumbailFiltered = dataThumbnailCoreData.filter
        {   (thumbnail) in
            return thumbnail.story == StorySelected
        }
        
        //Change to dataThumbnailCoreData
//        dataThumbailFiltered = dataThumbail.filter
//        {   (thumbnail) in
//            return thumbnail.story == StorySelected
//        }
        collectionView.reloadData()
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
    }
    
    
    func setUpPopUpSettingView(){
        blurView.bounds = self.view.bounds
        settingView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initDataThumbnail() {
        
        //Add Id and Change isActive true only in S1C1
        
        let s1c1 = Thumbnail(id: 1,chapter: "Bagian 1", story: "Cerita 1", imgthumbnail: "tb1", videoPath:"s1c1", tutorPath:"s1c1", isActive: true, gameStoryboard: "YesOrNoStoryboard", gameIdentifier: "YesOrNo")
        let s1c2 = Thumbnail(id: 2, chapter: "Bagian 2", story: "Cerita 1", imgthumbnail: "tb2", videoPath:"s1c2", tutorPath:"s1c2", isActive: false, gameStoryboard: "SlapMosquitoGame", gameIdentifier: "slapMosquitoGame")
        let s1c3 = Thumbnail(id: 3,chapter: "Bagian 3", story: "Cerita 1", imgthumbnail: "tb3", videoPath:"s1c3", tutorPath:"s1c3", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        
        let s2c1 = Thumbnail(id: 4,chapter: "Bagian 1", story: "Cerita 2", imgthumbnail: "tb1", videoPath:"s2c1", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s2c2 = Thumbnail(id: 5,chapter: "Bagian 2", story: "Cerita 2", imgthumbnail: "tb2", videoPath:"s2c2", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s2c3 = Thumbnail(id: 6, chapter: "Bagian 3", story: "Cerita 2", imgthumbnail: "tb3", videoPath:"s2c3", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        
        let s3c1 = Thumbnail(id: 7, chapter: "Bagian 1", story: "Cerita 3", imgthumbnail: "tb1", videoPath:"s3c1", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s3c2 = Thumbnail(id: 8,chapter: "Bagian 2", story: "Cerita 3", imgthumbnail: "tb2", videoPath:"s3c2", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s3c3 = Thumbnail(id: 9,chapter: "Bagian 3", story: "Cerita 3", imgthumbnail: "tb3", videoPath:"s3c3", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        
        
        //Save to CoreData
        CoreDataHandle.addDataThumbnail(s1c1)
        CoreDataHandle.addDataThumbnail(s1c2)
        CoreDataHandle.addDataThumbnail(s1c3)
        CoreDataHandle.addDataThumbnail(s2c1)
        CoreDataHandle.addDataThumbnail(s2c2)
        CoreDataHandle.addDataThumbnail(s2c3)
        CoreDataHandle.addDataThumbnail(s3c1)
        CoreDataHandle.addDataThumbnail(s3c2)
        CoreDataHandle.addDataThumbnail(s3c3)
        
        dataThumbnailCoreData = CoreDataHandle.getAllThumbailData()
        dataThumbail = dataThumbnailCoreData
        print("Size nya berapa dataThumbnail di init data -> \(dataThumbail.count)")
        
//        dataThumbail.append(s1c1) //Append untuk ngesave data yang diinput ke array. (Masuk ke akhir queue array)
//        dataThumbail.append(s1c2)
//        dataThumbail.append(s1c3)
//        dataThumbail.append(s2c1)
//        dataThumbail.append(s2c2)
//        dataThumbail.append(s2c3)
//        dataThumbail.append(s3c1)
//        dataThumbail.append(s3c2)
//        dataThumbail.append(s3c3)
        
        
        dataThumbailFiltered = dataThumbail.filter
        {   (thumbnail) in
            return thumbnail.story == StorySelected
        }
        
        collectionView.reloadData()
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataThumbailFiltered.count
    }
    
    //Buat display data thumbnail
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellThumbnail", for: indexPath ) as! ThumbnailCollectionViewCell
        let Thumbnail = dataThumbailFiltered[indexPath.row]
        
        if  Thumbnail.isActive == true {
            cell.imgThumbnail.layer.borderWidth = 8
            cell.imgThumbnail.layer.borderColor = UIColor.white.cgColor
            cell.imgThumbnail.alpha = 1.0
            cell.lockIcon.isHidden = true
            cell.labelThumbnail.text = Thumbnail.chapter
            cell.imgThumbnail.image = UIImage(named: Thumbnail.imgthumbnail)
            cell.imgThumbnail.layer.cornerRadius = 20.0
            collectionView.backgroundColor = UIColor.clear
        } else {
            cell.imgThumbnail.layer.borderWidth = 8
            cell.imgThumbnail.layer.borderColor = UIColor.white.cgColor
            cell.imgThumbnail.alpha = 0.7
            cell.lockIcon.isHidden = false
            cell.labelThumbnail.text = Thumbnail.chapter
            cell.imgThumbnail.image = UIImage(named: Thumbnail.imgthumbnail)
            cell.imgThumbnail.layer.cornerRadius = 20.0
            collectionView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        
        if (dataThumbailFiltered[indexSelected].isActive == true) {
            self.performSegue(withIdentifier: "prologIdentifier", sender: self)
            if SFXAllowStatus
            {
                if ButtonPressSFX.isPlaying
                {
                    ButtonPressSFX.stop()
                }
                ButtonPressSFX.play()
            }
        } else {
            print("Belom kelar oy")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PrologViewController {
            destination.chapterModel = dataThumbail[indexSelected]
            MenuBGM.stop()
        }
    }
    
    
    //settingButtonPressed
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        //print("Setting Button Pressed")
        //action
        //popUpTransitionIn(desiredView: blurView)
        //popUpTransitionIn(desiredView: settingView)
        //menggunakan view xib
        SettingPopUpController.instance.showAlert()
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
    }
    
    //badges
    @IBAction func badgesButtonPressed(_ sender: UIButton) {
        print("Badges Button Pressed")
        //testing pause pop up
        //testing pause pop up
        //PausePopUpController.instance.showPausePopUp()
        //testing game success popup
        GameResultPopUpController.instance.showResultView(alertType: .success)
        
        PausePopUpController.instance.showPausePopUp()
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
    }
    
    //avatar
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        print("Avatar Button Pressed")
        //testing game failure popup
        GameResultPopUpController.instance.showResultView(alertType: .failure)
        //testing
        if SFXAllowStatus
        {
            if ButtonPressSFX.isPlaying
            {
                ButtonPressSFX.stop()
            }
            ButtonPressSFX.play()
        }
    }
    
    //popUp transition
    func popUpTransitionIn(desiredView:UIView){
        let bgView  = self.view!
        
        //
        bgView.addSubview(desiredView)
        
        //
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = bgView.center
        
        //
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    func popUpTransitionOut(desiredView:UIView){
        //
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
    }
    
}

extension UIImageView {
    func applyshadowWithCorner(containerView: UIView, cornerRadious: CGFloat, shadowOpacity: Float){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = shadowOpacity
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}

