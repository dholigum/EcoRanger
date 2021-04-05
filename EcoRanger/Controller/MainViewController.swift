//
//  ViewController.swift
//  EcoRanger
//
//  Created by Syahrul Apple Developer BINUS on 03/04/21.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataThumbail = [Thumbnail]()
    private var indexSelected = 0
    
    //popUp var space
    @IBOutlet var settingView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBAction func backButton(_ sender: UIButton) {
        popUpTransitionOut(desiredView: settingView)
        popUpTransitionOut(desiredView: blurView)
            
        }
    @IBAction func sfxButton(_ sender: Any) {
        print("ini switch sfx")
        
    }
    @IBAction func bgmSwitch(_ sender: Any) {
        print("ini switch BMG")
    }
    //
    
        

    override func viewDidLoad() {
        super.viewDidLoad()
        //popUp setting button
        blurView.bounds = self.view.bounds
        settingView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        initDataThumbnail()
    }
    
    func initDataThumbnail() {
        let s1c1 = Thumbnail(chapter: "Chapter 1",story: "Story 1", imgthumbnail: "tb1", videoPath:"s1c1")
        let s1c2 = Thumbnail(chapter: "Chapter 2",story: "Story 1", imgthumbnail: "tb2", videoPath:"s1c2")
        let s1c3 = Thumbnail(chapter: "Chapter 3",story: "Story 1", imgthumbnail: "tb3", videoPath:"s1c3")
        dataThumbail.append(s1c1)
        dataThumbail.append(s1c2)
        dataThumbail.append(s1c3)
        collectionView.reloadData()
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataThumbail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellThumbnail", for: indexPath ) as! ThumbnailCollectionViewCell
                // set nilai ke view dalam cell
        let Thumbnail = dataThumbail[indexPath.row]
                cell.labelThumbnail.text = Thumbnail.chapter
                cell.imgThumbnail.image = UIImage(named: Thumbnail.imgthumbnail)
        cell.imgThumbnail.layer.cornerRadius = 20.0
        collectionView.backgroundColor = UIColor.clear
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        self.performSegue(withIdentifier: "prologIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PrologViewController {
            destination.chapterModel = dataThumbail[indexSelected]
        }
    }
    
    //settingButtonPressed
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        //print("Setting Button Pressed")
        //action
        popUpTransitionIn(desiredView: blurView)
        popUpTransitionIn(desiredView: settingView)
        
        
    }
    
    //badges
    @IBAction func badgesButtonPressed(_ sender: UIButton) {
        print("Badges Button Pressed")
    }
    
    //avatar
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        print("Avatar Button Pressed")
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

