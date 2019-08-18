//
//  DrinkingInfoCardTableViewCell.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 6..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class WateringInfoTableViewCell: UITableViewCell {

    static let height: CGFloat = 66.5
    var timestamp : Int = 0
    @IBOutlet weak var waterImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        let date = formatterForCell.date(from:dateLabel.text ?? "")
        self.timestamp = Int(date?.timeIntervalSince1970 ?? 0)
    }
    
    fileprivate let formatterForCell: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    @IBAction func moreButtonClicked(_ sender: Any) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            print("\(self.timestamp) 삭제")
            self.removeFromSuperview()
        })
        alert.addAction(deleteAction)

        alert.view.tintColor = Color.gray1
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        topVC?.present(alert, animated: true, completion: nil)
        
    }
}
