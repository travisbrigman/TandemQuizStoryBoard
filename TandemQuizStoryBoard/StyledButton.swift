//
//  StyledButton.swift
//  TandemQuizStoryBoard
//
//  Created by Travis Brigman on 11/1/20.
//  Copyright © 2020 Travis Brigman. All rights reserved.
//

import UIKit


    @IBDesignable
class StyledButton: UIButton {

        @IBInspectable var cornerRadius: CGFloat = 0{
            didSet{
            self.layer.cornerRadius = cornerRadius
            }
        }

        @IBInspectable var borderWidth: CGFloat = 0{
            didSet{
                self.layer.borderWidth = borderWidth
            }
        }

        @IBInspectable var borderColor: UIColor = UIColor.clear{
            didSet{
                self.layer.borderColor = borderColor.cgColor
            }
        }
    }

