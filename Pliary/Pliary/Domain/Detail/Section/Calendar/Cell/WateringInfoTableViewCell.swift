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
        self.layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)

        let date = formatterForCell.date(from:dateLabel.text ?? "")
        timestamp = Int(date?.timeIntervalSince1970 ?? 0)
    }
    
    fileprivate let formatterForCell: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "기록을 삭제하시겠습니까?", message: "", preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler : nil)
        let deleteAccountAction = UIAlertAction(title: "삭제", style: .destructive) { (alert: UIAlertAction!) in
            print("\(self.timestamp) 삭제")
            self.removeFromSuperview()
        }
        
        alert.addAction(cancleAction)
        alert.addAction(deleteAccountAction)
        alert.view.tintColor = Color.gray1
   
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        topVC?.present(alert, animated: true, completion: nil)
        
    }
}
