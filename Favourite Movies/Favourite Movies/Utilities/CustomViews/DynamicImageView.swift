//
//  DynamicImageView.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation
import UIKit

class DynamicImageView: UIImageView {
   static let imageCache = ImageCache()
    
    func addImage(_ url:String?,_ placeHolder: UIImage,completionHandler:@escaping ()->()){
        if let unwrap = url{
            downloaded(from: unwrap,completionHandler: completionHandler)
        }else{
            self.image = placeHolder
        }
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill,urlString:String = "",completionHandler:@escaping ()->()) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                DynamicImageView.imageCache.set(forKey: urlString, image: image)
                completionHandler()
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill,completionHandler:@escaping ()->()) {
        guard let url = URL(string: link) else { return }
        if let image = DynamicImageView.imageCache.get(forKey: link){
            self.image = image
        }else{
            downloaded(from: url, contentMode: mode,urlString: link, completionHandler: completionHandler)
        }
        
    }
}




class ImageCache {
    
    private var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }

}
