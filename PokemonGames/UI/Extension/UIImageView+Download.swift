//
//  UIImageView+Download.swift
//  PokemonGames
//
//  Created by noverio joe on 15/02/22.
//

import Foundation
import UIKit

extension UIImageView {
//    func getData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
//        URLSession.shared.dataTask(with: url, completionHandler: { (data, urlResponse, error) -> Void in
//            completion(data,urlResponse,error as! Error)
//        }).resume()
//    }
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        var activityIndicator : UIActivityIndicatorView
        if #available(iOS 13, *) {
            activityIndicator = self.activityIndicator(style: .medium, frame: self.frame, center: self.center)
            
        }
        else{
            activityIndicator = self.activityIndicator(style: .gray, frame: self.frame, center: self.center)
        }
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                activityIndicator.stopAnimating()
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
    private func activityIndicator(style: UIActivityIndicatorView.Style,
                                       frame: CGRect? = nil,
                                       center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        // 2
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        
        // 3
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        
        // 4
        if let center = center {
            activityIndicatorView.center = center
        }
        
        // 5
        return activityIndicatorView
    }
}
