//
//  AsssetManager.swift
//  Pliary
//
//  Created by jeewoong.han on 22/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
import Photos

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
    
    static func save(data: Any, for key: String) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: data)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
}
