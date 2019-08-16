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

    @IBOutlet weak var tableView: UITableView!
    
    var selectedPlant: Plant?
    var animating: Bool = true
    var headerView: DetailTableHeaderView?

    var currentSection: Section = .diaryCard {
        didSet {
            headerView?.currentSection = currentSection
            for cell in tableView.visibleCells {
                if let sectionCell = cell as? SectionTableViewCell {
                    sectionCell.changeSection(to: currentSection, animated: true)
                    return
                }
            }
        }
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
        
        let mainDetailNib = UINib(nibName: MainDetailTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(mainDetailNib, forCellReuseIdentifier: MainDetailTableViewCell.reuseIdentifier)
        
        let sectionNib = UINib(nibName: SectionTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(sectionNib, forCellReuseIdentifier: SectionTableViewCell.reuseIdentifier)
    }
    
    func setUpGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        tableView.addGestureRecognizer(gesture)
        gesture.delegate = self
    }
    
    func animatePlant(_ bool: Bool) {
        for cell in tableView.visibleCells {
            if let plantCell = cell as? MainDetailTableViewCell {
                if bool {
                    plantCell.plantView.startAnimatingGif()
                    animating = true
                } else {
                    plantCell.plantView.stopAnimatingGif()
                    animating = false
                }
                return
            }
        }
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
            if velocity.y > 0 {
                dismiss(animated: true, completion: nil)
            }
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
    
}
