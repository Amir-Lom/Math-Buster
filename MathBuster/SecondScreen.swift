//
//  SecondScreen.swift
//  MathBuster
//
//  Created by Amir Umarov on 26.02.2024.
//

import UIKit
    
    class CustomLabel: UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupLabel()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupLabel()
        }
        
        func setupLabel() {
            self.textColor = UIColor.blue
            self.font = UIFont.boldSystemFont(ofSize: 18)
            self.textAlignment = .center
            self.numberOfLines = 0 // Allows for multiple lines
        }
    }

    // Example of using the custom label
    let customLabel = CustomLabel(frame: CGRect(x: 20, y: 100, width: 200, height: 100))
//    customLabel.text = "Hello, Custom Label!"

