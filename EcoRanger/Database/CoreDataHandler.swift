//
//  CoreDataHandler.swift
//  EcoRanger
//
//  Created by Christopher Teddy  on 10/04/21.
//

import Foundation
import CoreData

class CoreDataHandle {
    static var context:NSManagedObjectContext!
    
    //Init Core Data
    static func initCoreData(_ appDelegate: AppDelegate) {
        context = appDelegate.persistentContainer.viewContext
    }
    
    //Add Data
    static func addDataThumbnail(_ dataThumbnail: Thumbnail) {
        
        //Declare Entity
        let entity = NSEntityDescription.entity(forEntityName: ThumbnailFieldKey.THUMBNAILTABLE, in: context)
        let newThumbnailData = NSManagedObject(entity: entity!, insertInto: context)
        
        //Set Data
        newThumbnailData.setValue(dataThumbnail.id, forKey: ThumbnailFieldKey.ID)
        newThumbnailData.setValue(dataThumbnail.chapter, forKey: ThumbnailFieldKey.CHAPTER)
        newThumbnailData.setValue(dataThumbnail.gameIdentifier, forKey: ThumbnailFieldKey.GAMEIDENTIFIER)
        newThumbnailData.setValue(dataThumbnail.gameStoryboard, forKey: ThumbnailFieldKey.GAMESTORYBOARD)
        newThumbnailData.setValue(dataThumbnail.imgthumbnail, forKey: ThumbnailFieldKey.IMGTHUMBNAIL)
        newThumbnailData.setValue(dataThumbnail.imgtutorthumbnail, forKey: ThumbnailFieldKey.IMGTUTORTHUMBNAIL)
        newThumbnailData.setValue(dataThumbnail.isActive, forKey: ThumbnailFieldKey.ISACTIVE)
        newThumbnailData.setValue(dataThumbnail.story, forKey: ThumbnailFieldKey.STORY)
        newThumbnailData.setValue(dataThumbnail.tutorPath, forKey: ThumbnailFieldKey.TUTORPATH)
        newThumbnailData.setValue(dataThumbnail.videoPath, forKey: ThumbnailFieldKey.VIDEOPATH)
        
        do {
            try context.save()
        } catch {
            print("Cannot Save")
        }
    }
    
    //Populate Data in CoreData
    static func getAllThumbailData()->[Thumbnail]{
        
        //Init Emoty Array that contains array of Thumbail
        var listThumbnail:[Thumbnail] = []
        
        //Open Request to Core Data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ThumbnailFieldKey.THUMBNAILTABLE)
        
        //Prevent Double data
        listThumbnail.removeAll()
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for i in results {
                let id = i.value(forKey: ThumbnailFieldKey.ID) as! Int
                let chapter = i.value(forKey: ThumbnailFieldKey.CHAPTER) as! String
                let gameIdentifier = i.value(forKey: ThumbnailFieldKey.GAMEIDENTIFIER) as! String
                let gameStoryboard = i.value(forKey: ThumbnailFieldKey.GAMESTORYBOARD) as! String
                let imgThumbnail = i.value(forKey: ThumbnailFieldKey.IMGTHUMBNAIL) as! String
                let imgTutorThumbnail = i.value(forKey: ThumbnailFieldKey.IMGTUTORTHUMBNAIL) as! String
                let isActive = i.value(forKey: ThumbnailFieldKey.ISACTIVE) as! Bool
                let story = i.value(forKey: ThumbnailFieldKey.STORY) as! String
                let tutorPath = i.value(forKey: ThumbnailFieldKey.TUTORPATH) as! String
                let videoPath = i.value(forKey: ThumbnailFieldKey.VIDEOPATH) as! String
               
                
                let thumbnail: Thumbnail = Thumbnail(id: id,chapter: chapter, story: story, imgthumbnail: imgThumbnail, imgtutorthumbnail: imgTutorThumbnail, videoPath: videoPath, tutorPath: tutorPath, isActive: isActive, gameStoryboard: gameStoryboard, gameIdentifier: gameIdentifier)
                
                listThumbnail.append(thumbnail)
            }
            
        } catch {
            print("Cannot Populate Data")
        }
        
        
        return listThumbnail
    }
    
    static func updateIsActiveStatus(id: Int, isActive: Bool) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ThumbnailTable")
        request.predicate = NSPredicate(format: ThumbnailFieldKey.ID + " == \(id)")
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for i in result {
                i.setValue(isActive, forKey: ThumbnailFieldKey.ISACTIVE)
            }
            
            try context.save()
        } catch {
            
        }
     
    }
    
}


class ThumbnailFieldKey{
    static var ID = "id"
    static var CHAPTER = "chapter"
    static var GAMEIDENTIFIER = "gameIdentifier"
    static var GAMESTORYBOARD = "gameStoryboard"
    static var IMGTHUMBNAIL = "imgThumbnail"
    static var IMGTUTORTHUMBNAIL = "imgTutorThumbnail"
    static var ISACTIVE = "isActive"
    static var STORY = "story"
    static var TUTORPATH = "tutorPath"
    static var VIDEOPATH = "videoPath"
    
    static var THUMBNAILTABLE = "ThumbnailTable"
}
