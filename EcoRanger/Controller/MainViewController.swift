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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        initDataThumbnail()
    }
    
    func initDataThumbnail() {
        let s1c1 = Thumbnail(id:"s1c1",chapter: "Chapter 1",story: "Story 1", imgthumbnail: "tb1")
        let s1c2 = Thumbnail(id:"s1c2",chapter: "Chapter 2",story: "Story 1", imgthumbnail: "tb2")
        let s1c3 = Thumbnail(id:"s1c3",chapter: "Chapter 3",story: "Story 1", imgthumbnail: "tb3")
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
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        print("Setting Button Pressed")
    }
    @IBAction func badgesButtonPressed(_ sender: UIButton) {
        print("Badges Button Pressed")
    }
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        print("Avatar Button Pressed")
    }
    
}

