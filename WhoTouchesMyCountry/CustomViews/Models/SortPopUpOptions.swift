//
//  SortPopUpOptions.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 07/08/2021.
//

import UIKit

enum SortPopUpOptions: CaseIterable {
    case none
    case sizeAscending
    case sizeDescending
    case nameAscending
    case nameDescending
        
    var view: UIView {
        switch self {
        case .none:  return makeLabel()
        case .sizeAscending, . sizeDescending,
             .nameAscending, .nameDescending:
            return makeLabelWithImage()
        }
    }
    
    private var text: String {
        switch self {
        case .none: return "None"
        case .nameAscending,.nameDescending: return "Name"
        case .sizeAscending,.sizeDescending: return "Size"
        }
    }
    private var imageName: String {
        switch self {
        case .none: return "no image"
        case .nameAscending,.sizeAscending: return ImageConstants.arrowUpToLine
        case .nameDescending,.sizeDescending: return ImageConstants.arrowDownToLine
        }
    }
    
    private func makeLabel() -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.textAlignment = .center
        return lbl
    }
    
    private func makeImageView() -> UIImageView {
        let iv = UIImageView(image: UIImage(systemName: imageName))
        iv.contentMode = .scaleAspectFit
        return iv
    }
    
    
    // had problems to center the view using HStack or view as a container,
    // I tried also "NSAttributedString(attachment: attachment)" and it worked but it didnt let me change the color of the image. this is the easiest way to do it to look like the swiftUI counterpart 
    private func makeLabelWithImage() -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: imageName), for: .normal)
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.semanticContentAttribute = .forceRightToLeft
        return btn

    }
    
}
