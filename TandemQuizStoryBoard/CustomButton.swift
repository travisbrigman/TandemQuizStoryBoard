//
//  CustomButton.swift
//  TandemQuizStoryBoard
//
//  Created by Travis Brigman on 11/2/20.
//  Copyright © 2020 Travis Brigman. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
override init(frame: CGRect) {
    super.init(frame: frame)
}

init() {
    super.init(frame: .zero)
    backgroundColor = .init(red: 153.0/255.0, green: 51.0/255.0, blue: 153.0/255.0, alpha: 0.6)
    //setTitle(title, for: .normal)
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    layer.cornerRadius = 12
    layer.masksToBounds = true
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    }
    

