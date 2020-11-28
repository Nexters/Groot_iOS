//
//  AsssetManager.swift
//  Pliary
//
//  Created by jeewoong.han on 22/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
import Photos
import UIKit

struct AssetManager {
    // MARK: - Method
    static func fetchImages(by identifiers: [String]?) -> [PHAsset] {
        let fetchResult: PHFetchResult<PHAsset>
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d",
                                             PHAssetMediaType.image.rawValue)
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        if (identifiers != nil) {
            fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers!, options: fetchOptions)
        } else {
            fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        }
        
        let indexSet = IndexSet(0..<fetchResult.count)
        
        return fetchResult.objects(at: indexSet)
    }
    
    static func getDictData(for key: String) -> [String: Any] {
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            if let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any] {
                return dictionary
            }
        }
        return [:]
    }
    
    static func getString(for key: String) -> String? {
        if let string = UserDefaults.standard.object(forKey: key) as? String {
            return string
        } else {
            return nil
        }
    }
    
    static func save(string: String, for key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(string, forKey: key)
        userDefaults.synchronize()
    }
    
    static func save(data: Any, for key: String) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: data)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
    
    static func save(image: UIImage, identifier: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.85) ?? image.pngData() else {
            return nil
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as URL else {
            return nil
        }
        
        let imageIdentifier = identifier.replacingOccurrences(of: "/", with: "")
        let imageDirectory = directory.appendingPathComponent("\(imageIdentifier).jpeg")
        
        do{
            try data.write(to: imageDirectory)
            return imageDirectory
        } catch {
            return nil
        }
    } // saveImage
    
    static func getImageURL(path: String) -> URL? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as URL else {
            return nil
        }
        
        guard let imageName = path.split(separator: "/").last else {
            return nil
        }
        
        let imageDirectory = directory.appendingPathComponent(String(imageName))
        return imageDirectory
    }
}
