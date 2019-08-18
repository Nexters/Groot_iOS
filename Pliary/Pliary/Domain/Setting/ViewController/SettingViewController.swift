//
//  SettingViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 10/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero
import Firebase

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var profileBackgrondView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var userProfileView: UserProfileView?
    var settings: [Setting] {
        let changePassword = Setting(title: .changePassword, type: .next)
        let logout = Setting(title: .logout, type: .next)
        let deleteAccount = Setting(title: .deleteAccount, type: .next)
        let updateAlert = Setting(title: .updateAlert, type: .updateSwitch)
        
        return [changePassword, logout, deleteAccount, updateAlert]
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        hero.modalAnimationType = .pull(direction: .right)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            hero.modalAnimationType = .pull(direction: .right)
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.x / view.bounds.width)
        default:
            if ((translation.x + velocity.x) / view.bounds.width) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let settingNextName = SettingNextTableViewCell.reuseIdentifier
        let settingNextNib = UINib(nibName: settingNextName, bundle: nil)
        tableView.register(settingNextNib, forCellReuseIdentifier: settingNextName)
        
        let settingSwitchName = SettingSwitchTableViewCell.reuseIdentifier
        let settingSwitchNib = UINib(nibName: settingSwitchName, bundle: nil)
        tableView.register(settingSwitchNib, forCellReuseIdentifier: settingSwitchName)
        
    }
    
    private func logout() {
        let signOutAlert = UIAlertController(title: "로그아웃하시겠습니까?", message: "", preferredStyle: .alert)
        
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
        
        signOutAlert.addAction(cancleAction)
        signOutAlert.addAction(signOutAction)
        signOutAlert.view.tintColor = Color.gray1
        
        present(signOutAlert, animated: false, completion: nil)
    }
    
    private func deleteAccount() {
        
        let deleteAccountAlert = UIAlertController(title: "탈퇴하시겠습니까?", message: "\n탈퇴 시 회원님의 계정에 저장된 모든 정보가 영구적으로 삭제되며, 다시는 복구할 수 없습니다.", preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler : nil)
        let deleteAccountAction = UIAlertAction(title: "탈퇴", style: .destructive) { (alert: UIAlertAction!) in
            print("deleteAccountAction")
        }
        
        deleteAccountAlert.addAction(cancleAction)
        deleteAccountAlert.addAction(deleteAccountAction)
        deleteAccountAlert.view.tintColor = Color.gray1
        
        present(deleteAccountAlert, animated: false, completion: nil)
    }
    
    func goChangePasswordVC() {
        let storyboard = UIStoryboard.init(name: StoryboardName.setting, bundle: Bundle(for: ChangePasswordViewController.self))
        guard let chanegUserSettingVC = storyboard.instantiateViewController(withIdentifier: ChangePasswordViewController.identifier) as? ChangePasswordViewController else {
            return
        }
        
        chanegUserSettingVC.hero.isEnabled = true
        chanegUserSettingVC.hero.modalAnimationType = .push(direction: .left)
        present(chanegUserSettingVC, animated: true, completion: nil)
    }
    
}

extension SettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
        
        
        let profileView = UserProfileView.instance()
        userProfileView = profileView
        profileBackgrondView.addSubview(profileView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userProfileView?.frame = CGRect(origin: .zero, size: profileBackgrondView.frame.size)
    }
}

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil else {
            print("Expected a dictionary containing an image, but was provided the following: \(info)")
            return
        }
        
//        userProfileImageView.image = selectedImage.resize(withSize: CGSize(width: 151.0, height: 151.0), contentMode: .contentAspectFill)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setting = settings[indexPath.row]
        switch setting.type {
        case .next:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingNextTableViewCell.reuseIdentifier) as? SettingNextTableViewCell {
                cell.cellTitleLabel.text = setting.title.rawValue
                return cell
            }
        case .updateSwitch:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTableViewCell.reuseIdentifier) as? SettingSwitchTableViewCell {
                cell.cellTitleLabel.text = setting.title.rawValue
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        switch setting.title {
        case .changePassword:
            goChangePasswordVC()
        case .logout:
            logout()
        case .deleteAccount:
            deleteAccount()
        case .updateAlert:
            ()
        }
    }
    
}
