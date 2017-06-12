//
//  LoginButton.swift
//  Sabbath School
//
//  Created by Vitaliy Lim on 2017-05-27.
//  Copyright © 2017 Adventech. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import pop

enum LoginButtonType {
    case facebook
    case google
    case anonymous
}

class LoginButton: ASButtonNode {
    let type: LoginButtonType
    
    init(type: LoginButtonType) {
        self.type = type
        super.init()
        
        var attributes: NSAttributedString!
        var icon: UIImage?
        
        switch type {
        case .facebook:
            attributes = TextStyles.signInButtonTitleStyle(string: "Sign in with Facebook", color: .white)
            backgroundColor = UIColor.facebook
            icon = R.image.loginIconFacebook()
            addShadow()
        case .google:
            attributes = TextStyles.signInButtonTitleStyle(string: "Sign in with Google")
            backgroundColor = UIColor.white
            icon = R.image.loginIconGoogle()
            addShadow()
        case .anonymous:
            attributes = TextStyles.signInButtonTitleStyle(string: "Continue without login")
        }
        
        if let image = icon {
            setImage(image, for: UIControlState())
        }
        
        setAttributedTitle(attributes, for: UIControlState())
        contentEdgeInsets = UIEdgeInsets(top: 13, left: 30, bottom: 13, right: 30)
        cornerRadius = 4
    }
    
    func addShadow() {
        shadowColor = UIColor(white: 0, alpha: 0.25).cgColor
        shadowOffset = CGSize(width: 0, height: 1)
        shadowRadius = 0.6
        shadowOpacity = 1
        clipsToBounds = false
    }
    
    
    override func sendActions(forControlEvents controlEvents: ASControlNodeEvent, with touchEvent: UIEvent?) {
        if controlEvents == .touchDown {
            let anim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
            anim?.duration = 0.2
            anim?.toValue = NSValue(cgSize: CGSize(width: 0.95, height: 0.95))
            self.layer.pop_add(anim, forKey: anim?.property.name)
        }
        
        if controlEvents == .touchUpInside {
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            anim?.dynamicsTension = 300
            anim?.dynamicsFriction = 16
            anim?.dynamicsMass = 1
            anim?.velocity = NSValue(cgSize: CGSize(width: 2, height: 2))
            anim?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
            layer.pop_add(anim, forKey: anim?.property.name)
        }
        
        if controlEvents == .touchDragOutside || controlEvents == .touchCancel {
            let anim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
            anim?.duration = 0.2
            anim?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
            self.layer.pop_add(anim, forKey: anim?.property.name)
        }
        
        super.sendActions(forControlEvents: controlEvents, with: touchEvent)
    }
}