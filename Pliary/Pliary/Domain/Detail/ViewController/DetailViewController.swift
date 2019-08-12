//
//  DetailViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 05/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero

class DetailViewController: UIViewController {

    enum Section: String {
        case diaryCard
        case calendar
    }
    
    @IBOutlet weak var writeDiaryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var diaryCards: [DiaryCard] = []
    var diaryCardsCount: Int {
        return diaryCards.count + 2
    }
    var currentSection: Section = .diaryCard
    
    func setExample() {
        let text = "너에게해충이찾아왔다다지켜주지못해 미안해다음부턴잘할게다못난날용서해잘할게다못난날용서해날용서해용서해너에게해충이찾아왔다다지켜주지못해 미안해다음부턴잘할게다못난날용서해잘할게다못난날용서해날용서해용서해"
        let diary = DiaryCard(timeStamp: "2019.11.02", diaryText: text, diaryImage: UIImage(named: "SampleDiary"))
        
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
    }
    
    @IBAction func tapWriteDiaryButton(_ sender: Any) {
        goDiaryViewController(with: nil)
    }
    
    func goDiaryViewController(with diaryCard: DiaryCard?) {
        let storyboard = UIStoryboard.init(name: StoryboardName.detail, bundle: Bundle(for: DiaryViewController.self))
        guard let writeDiaryVC = storyboard.instantiateViewController(withIdentifier: DiaryViewController.identifier) as? DiaryViewController else {
            return 
        }
        
        writeDiaryVC.hero.isEnabled = true
        writeDiaryVC.hero.modalAnimationType = .push(direction: .left)
        
        DispatchQueue.main.async {
            self.present(writeDiaryVC, animated: true, completion: {
                writeDiaryVC.hero.modalAnimationType = .pull(direction: .right)
            })
            
            if diaryCard != nil {
                writeDiaryVC.currentMode = .showDiary
                writeDiaryVC.currentDiaryCard = diaryCard
            }
        }
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let mainDetailName = MainDetailTableViewCell.reuseIdentifier
        let mainDetailNib = UINib(nibName: mainDetailName, bundle: nil)
        tableView.register(mainDetailNib, forCellReuseIdentifier: mainDetailName)
        
        let dayWithPlantName = DayWithPlantTableViewCell.reuseIdentifier
        let dayWithPlantNib = UINib(nibName: dayWithPlantName, bundle: nil)
        tableView.register(dayWithPlantNib, forCellReuseIdentifier: dayWithPlantName)
        
        let diaryCardWithAllName = DiaryCardWithAllTableViewCell.reuseIdentifier
        let diaryCardWithAllNib = UINib(nibName: diaryCardWithAllName, bundle: nil)
        tableView.register(diaryCardWithAllNib, forCellReuseIdentifier: diaryCardWithAllName)
    }
    
    func setUpGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        tableView.addGestureRecognizer(gesture)
        gesture.delegate = self
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpGesture()
        setExample()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.contentInset.top = -UIApplication.shared.statusBarFrame.size.height
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        guard tableView.contentOffset.y <= 20 else {
            Hero.shared.cancel()
            return
        }
        
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < tableView.frame.height {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            writeDiaryButton.isHidden = true
        } else if scrollView.contentOffset.y == tableView.frame.height {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            writeDiaryButton.isHidden = false
        } else {
            tableView.isPagingEnabled = false
            tableView.bounces = true
            writeDiaryButton.isHidden = false
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return tableView.frame.height
        } else if currentSection == .diaryCard, indexPath.row == 0 {
            return DayWithPlantTableViewCell.height
        } else {
            return DiaryCardWithAllTableViewCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return DetailTableHeaderView.height
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return diaryCardsCount
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = DetailTableHeaderView.instance()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.reuseIdentifier) as? MainDetailTableViewCell {
                return cell
            }
        } else if indexPath.row == 0 {
            if currentSection == .diaryCard, let cell = tableView.dequeueReusableCell(withIdentifier: DayWithPlantTableViewCell.reuseIdentifier) as? DayWithPlantTableViewCell {
                return cell
            }
        } else {
            if currentSection == .diaryCard, let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithAllTableViewCell.reuseIdentifier) as? DiaryCardWithAllTableViewCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            // resume animation
        } else if currentSection == .diaryCard, indexPath.row != 0  {
            let diaryCard = diaryCards[indexPath.row]
            goDiaryViewController(with: diaryCard)
        }
    }
    
}
