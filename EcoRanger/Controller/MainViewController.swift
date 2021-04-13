//
//  ViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit
import AVKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate {
    
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
    @IBOutlet var creditView: UIView!
    @IBOutlet weak var creditTableView: UITableView!
    @IBOutlet var settingView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet var creditBackButton: UIButton!
    @IBAction func backButton(_ sender: UIButton) {
        popUpTransitionOut(desiredView: settingView)
        popUpTransitionOut(desiredView: blurView)
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
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
            dataThumbail = dataThumbnailCoreData
            dataThumbailFiltered = dataThumbail.filter({ (Thumbnail) -> Bool in
                return Thumbnail.story == "Cerita 1"
            })
            //            dataThumbailFiltered = dataThumbail
        }
        
        //popUp setting button
        setUpPopUpSettingView()
        setUpCreaditPopUp()
        setUpUISegmented()
        
        //Play BGM on Menu Load
        MusicPlayer.shared.startBackgroundMusic(bgmFIleName: "MainMenuBGM")
    
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
            SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        }
        else if sender.selectedSegmentIndex == 1
        {
            StorySelected = "Cerita 2"
            storyBgImage.image = #imageLiteral(resourceName: "parkbg")
            collectionView.reloadData()
            SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        }
        else if sender.selectedSegmentIndex == 2
        {
            StorySelected = "Cerita 3"
            storyBgImage.image = #imageLiteral(resourceName: "beachbg")
            collectionView.reloadData()
            SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
        }
        
        //Get all Data Core Data
        dataThumbnailCoreData = CoreDataHandle.getAllThumbailData()
        dataThumbailFiltered = dataThumbnailCoreData.filter
        {   (thumbnail) in
            return thumbnail.story == StorySelected
        }
        
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
        
        let s1c1 = Thumbnail(id: 1,chapter: "Bagian 1", story: "Cerita 1", imgthumbnail: "S1C1-TB", imgtutorthumbnail: "S1C1T-TB",  videoPath:"S1C1", tutorPath:"S1C1Tutorial", isActive: true, gameStoryboard: "YesOrNoStoryboard", gameIdentifier: "YesOrNo")
        let s1c2 = Thumbnail(id: 2, chapter: "Bagian 2", story: "Cerita 1", imgthumbnail: "S1C2-TB", imgtutorthumbnail: "S1C2T-TB", videoPath:"S1C2", tutorPath:"S1C2Tutorial", isActive: false, gameStoryboard: "SlapMosquitoGame", gameIdentifier: "slapMosquitoGame")
        let s1c3 = Thumbnail(id: 3,chapter: "Bagian 3", story: "Cerita 1", imgthumbnail: "tb3", imgtutorthumbnail: "S1C2T-TB", videoPath:"s1c3", tutorPath:"s1c3", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        
        let s2c1 = Thumbnail(id: 4,chapter: "Bagian 1", story: "Cerita 2", imgthumbnail: "tb1", imgtutorthumbnail: "S1C1T-TB", videoPath:"s2c1", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s2c2 = Thumbnail(id: 5,chapter: "Bagian 2", story: "Cerita 2", imgthumbnail: "tb2", imgtutorthumbnail: "S1C1T-TB", videoPath:"s2c2", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s2c3 = Thumbnail(id: 6, chapter: "Bagian 3", story: "Cerita 2", imgthumbnail: "tb3", imgtutorthumbnail: "S1C1T-TB", videoPath:"s2c3", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        
        let s3c1 = Thumbnail(id: 7, chapter: "Bagian 1", story: "Cerita 3", imgthumbnail: "tb1", imgtutorthumbnail: "S1C1T-TB", videoPath:"s3c1", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s3c2 = Thumbnail(id: 8,chapter: "Bagian 2", story: "Cerita 3", imgthumbnail: "tb2", imgtutorthumbnail: "S1C1T-TB", videoPath:"s3c2", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        let s3c3 = Thumbnail(id: 9,chapter: "Bagian 3", story: "Cerita 3", imgthumbnail: "tb3", imgtutorthumbnail: "S1C1T-TB", videoPath:"s3c3", tutorPath:"s1c1", isActive: false, gameStoryboard: "CarGame", gameIdentifier: "carGame")
        
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
            SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
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
        SettingPopUpController.instance.showAlert()
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
    }
    
    //badges
    @IBAction func badgesButtonPressed(_ sender: UIButton) {
//        GameResultPopUpController.instance.showResultView(alertType: .success)
//
//        PausePopUpController.instance.showPausePopUp()
          SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
    }
    
    //avatar
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        print("Avatar Button Pressed")
        //testing game failure popup
       // GameResultPopUpController.instance.showResultView(alertType: .failure)
        //testing
        SFXPlayer.shared.PlaySFX(SFXFileName: "ButtonPress")
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
    
    //credit PopUp
    let creditLabels = ["Freepik",
                        "BGM Dova Syndrome",
                        "Irasutoya ",
                        "Beach",
                        "Hidden Object BGM",
                        "Taman",
                        "Bersih Kamar Vibes",
                        "Nangkep Sampah",
                        "Taman V2",
                        "Menu Button",
                        "Mosquito Slap",
                        "Beach BG",
                        "Potato Chips Bag",
                        "Bento Box",
                        "Orange Peel",
                        "Ocean Waste",
                        "Dolphin Ocean Waste",
                        "Beach ball",
                        "Boy Littering",
                        "Boy Washing Hands",
                        "ubbish Bins + Rubbish",
                        "Organic Waste",
                        "Waste",
                        "Plastic Waste",
                        "Food Wastes",
                        "Mobile UI Buttons",
                        "Wooden UI Buttons"]
    let creditLinks = ["https://support.freepik.com/hc/en-us/articles/208976585-Attribution-How-when-and-where- ",
                       "https://dova-s.jp/_contents/license/ ",
                       "https://www.irasutoya.com/p/terms.html ",
                       "https://youtu.be/dpsOt7rcZCE ",
                       "https://youtu.be/NoZNP5gUf6E",
                       "https://youtu.be/pNIdw2I4umM",
                       "https://youtu.be/m_onXjyekUw",
                       "https://youtu.be/CIaOdhNyblQ",
                       "https://youtu.be/t9U0sLxVxbc",
                       "https://freesound.org/s/506052/ ",
                       "https://freesound.org/s/232135/ ",
                       "https://www.freepik.com/free-vector/realistic-beautiful-sea-view-summer-vacation-concept_2438179.htm#page=1&query=beach&position=11",
                       "https://www.irasutoya.com/2020/09/blog-post_20.html ",
                       "https://www.irasutoya.com/2020/09/blog-post_98.html",
                       "https://www.irasutoya.com/2020/11/blog-post_23.html",
                       "https://www.irasutoya.com/2017/08/blog-post_941.html ",
                       "https://www.irasutoya.com/2014/02/blog-post_7197.html ",
                       "https://www.irasutoya.com/2012/03/blog-post_6415.html ",
                       "https://www.irasutoya.com/2013/06/blog-post_1432.html ",
                       "https://www.irasutoya.com/2013/02/blog-post_8482.html ",
                       "https://www.freepik.com/free-vector/garbage-sorting-set_13146308.htm ",
                       "https://www.freepik.com/free-vector/food-trash-set-rotten-fruits-vegetables-meat-fish-bread-organic-waste-isolated-shite-background-flat-illustration_12699080.htm ",
                       "https://www.freepik.com/free-vector/pollution-litter-rubbish-trash-objects-isolated_5840643.htm#page=1&query=waste&position=0 ",
                       "https://www.freepik.com/free-vector/set-plastic-trash_4555725.htm#page=1&query=waste&position=22 ",
                       "https://www.freepik.com/free-vector/set-waste-elements_4510802.htm#page=1&query=waste&position=44",
                       "https://kenney.nl/assets/onscreen-controls ",
                       "https://www.freepik.com/free-vector/wooden-buttons-ui-game_12632833.htm#page=1&query=game%20ui&position=4  "]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditLabels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = (tableView.dequeueReusableCell(withIdentifier: "creditCellIdentifier", for: indexPath) as? CreditPopUpTableViewCell)!
        myCell.creditTitel.text = creditLabels[indexPath.row]
        myCell.creditLink.text = creditLinks[indexPath.row]
        return myCell
        
    }
    func setUpCreaditPopUp(){
        creditView.layer.cornerRadius = 10
        creditBackButton.layer.cornerRadius = 5
        creditTableView.delegate = self
        creditTableView.dataSource = self
    }
    
    @IBAction func creditButton(_ sender: UIButton) {
        popUpTransitionIn(desiredView: blurView)
        popUpTransitionIn(desiredView: creditView)
    }
    
    @IBAction func creditBackButtonAction(_ sender: UIButton) {
        popUpTransitionOut(desiredView: creditView)
        popUpTransitionOut(desiredView: blurView)
        
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

