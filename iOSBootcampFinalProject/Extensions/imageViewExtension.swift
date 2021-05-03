//
//  imageViewExtension.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: @escaping (Bool)->Void) {
        contentMode = mode
        //print("URL is here \(url)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion(false)
                    return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                completion(true)
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping (Bool)->Void) {
        guard let url = URL(string: link) else {
            completion(false)
            return }
        downloadedFrom(url: url, contentMode: mode, completion: completion)
    }
}
