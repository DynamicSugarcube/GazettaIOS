//
//  UIImageUtils.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import Alamofire
import UIKit

extension UIImage {
    static func load(from url: String, onComplete: @escaping (UIImage) -> Void) {
        getImageData(url) { data in
            if let image = UIImage(data: data) {
                onComplete(image)
            } else {
                print("Couldn't load image")
            }
        }
    }
    
    private static func getImageData(_ url: String, onComplete: @escaping (Data) -> Void) {
        AF.request(url, method: .get).response { response in
            if let data = response.data {
                onComplete(data)
            }
        }
    }
}
