//
//  UIImageViewExtension.swift
//  Avito_testTask
//
//  Created by Боровик Василий on 16.01.2021.
//

import UIKit

extension UIImageView {
	func imageFromServerURL(urlString: String) {
	
	URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
	  
	  if error != nil { return }
	  
	  DispatchQueue.main.async(execute: { () -> Void in
		if let data = data {
			let image = UIImage(data: data)
			self.image = image
		} else {
			self.image = UIImage()
		}
	  })
	}).resume()
  }
}
