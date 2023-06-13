//
//  FileManager+Path.swift
//  BBKit
//
//  Created by 肥啊 on 2023/2/18.
//

import Foundation

public extension FileManager {
    class func urlForDirectory(directory: SearchPathDirectory) -> URL? {
        return self.default.urls(for: directory, in: .userDomainMask).last
    }
    
    class func pathForDirectory(directory: SearchPathDirectory) -> String? {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first
    }
    
    class func documentsURL() -> URL? {
        return self.urlForDirectory(directory: .documentDirectory)
    }
    
    class func documentsPath() -> String? {
        return self.pathForDirectory(directory: .documentDirectory)
    }
    
    class func libraryURL() -> URL? {
        return self.urlForDirectory(directory: .libraryDirectory)
    }
    
    class func libraryPath() -> String? {
        return self.pathForDirectory(directory: .libraryDirectory)
    }
    
    class func cachesURL() -> URL? {
        return self.urlForDirectory(directory: .cachesDirectory)
    }
    
    class func cachesPath() -> String? {
        return self.pathForDirectory(directory: .cachesDirectory)
    }
}
