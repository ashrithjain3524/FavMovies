//
//  DynamicImageView.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation
import UIKit

class DynamicImageView: UIImageView {
    let imageCache = ImageCache()
    
    func addImage(_ url:String?,_ placeHolder: UIImage){
        if let unwrap = url{
            downloaded(from: unwrap)
        }else{
            self.image = placeHolder
        }
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill,urlString:String = "") {
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
                self?.imageCache.set(forKey: urlString, image: image)
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        if let image = imageCache.get(forKey: link){
            self.image = image
        }else{
            downloaded(from: url, contentMode: mode,urlString: link)
        }
        
    }
}




class ImageCache {
    
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }

}
