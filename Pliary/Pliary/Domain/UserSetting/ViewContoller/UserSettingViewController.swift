//
//  UserSettingViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 9..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase

class UserSettingViewController: UIViewController {
    
    let imagePickerController = UIImagePickerController()
    
    let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler : nil)
    let signOutAction = UIAlertAction(title: "로그아웃", style: .destructive) { (action:UIAlertAction!) -> Void in
        print("signOutAction")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    let deleteAccountAction = UIAlertAction(title: "탈퇴", style: .destructive) { (alert: UIAlertAction!) in
        print("deleteAccountAction")
    }
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userPlantLabel: UILabel!

    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var wateringSwitch: UISwitch!
    
    // Change user info

    // Logout
    @IBAction func signOutBarButtonClicked(_ sender: Any) {
        let signOutAlert = UIAlertController(title: "로그아웃하시겠습니까?", message: "", preferredStyle: .alert)
        

        signOutAlert.addAction(cancleAction)
        signOutAlert.addAction(signOutAction)
        
        present(signOutAlert, animated: false, completion: nil)
    }
    @IBAction func signOutButtonClicked(_ sender: Any) {
        let signOutAlert = UIAlertController(title: "로그아웃하시겠습니까?", message: "", preferredStyle: .alert)

        signOutAlert.addAction(cancleAction)
        signOutAlert.addAction(signOutAction)
        
        present(signOutAlert, animated: false, completion: nil)
    }
    
    // Delete account
    @IBAction func deleteAccountBarButtonClicked(_ sender: Any) {
        let deleteAccountAlert = UIAlertController(title: "탈퇴하시겠습니까?", message: "탈퇴 시 회원님의 계정에 저장된 모든 정보가 영구적으로 삭제되며, 다시는 복구할 수 없습니다.", preferredStyle: .alert)
        
        deleteAccountAlert.addAction(cancleAction)
        deleteAccountAlert.addAction(deleteAccountAction)
        
        present(deleteAccountAlert, animated: false, completion: nil)
    }
    @IBAction func deleteAccountButtonClicked(_ sender: Any) {
        let deleteAccountAlert = UIAlertController(title: "탈퇴하시겠습니까?", message: "탈퇴 시 회원님의 계정에 저장된 모든 정보가 영구적으로 삭제되며, 다시는 복구할 수 없습니다.", preferredStyle: .alert)
        
        deleteAccountAlert.addAction(cancleAction)
        deleteAccountAlert.addAction(deleteAccountAction)
        
        present(deleteAccountAlert, animated: false, completion: nil)
    }
    
    // Change watering push setting
    @IBAction func wateringSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(wateringSwitch.isOn, forKey: "switchState")

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = "Zooki"
        userPlantLabel.text = "식물 수 5개"
        wateringSwitch.isOn =  UserDefaults.standard.bool(forKey: "switchState")
        
        // Do any additional setup after loading the view.
    }
    
    func signOut(){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
