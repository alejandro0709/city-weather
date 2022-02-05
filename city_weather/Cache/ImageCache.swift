//
//  ImageCache.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation

protocol ImageCacheProtocol {
    func getImageData(by abbr: String) -> Data?
    func saveImage(abbr: String, imageData: Data)
}

class ImageCache: ImageCacheProtocol{
    
    func getImageData(by abbr: String) -> Data?{
        guard let filePath = self.filePath(by: abbr),
              let fileData = FileManager.default.contents(atPath: filePath.path) else {
                  return nil
              }
        
        return fileData
    }
    
    func saveImage(abbr: String, imageData: Data){
        guard let imagePath = self.filePath(by: abbr) else { return }
        
        do{
            try imageData.write(to: imagePath)
        }catch{
            print(error)
        }
    }
    
    fileprivate func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
    
    fileprivate func filePath(by abbr: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent("\(abbr).png")
    }
}
