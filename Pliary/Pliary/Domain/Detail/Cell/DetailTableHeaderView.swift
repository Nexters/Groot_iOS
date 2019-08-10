//
//  DetailTableHeaderView.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DetailTableHeaderView: UIView {
    static func instance() -> DetailTableHeaderView {
        let view: DetailTableHeaderView = UIView.createViewFromNib(nibName: "DetailTableHeaderView")
        return view
    }
    
    static let height: CGFloat = (92 + UIApplication.shared.statusBarFrame.height / 2)
}
