//
//  HomeViewController.swift
//  
//
//  Created by jueun lee on 2019. 7. 31..
//

import UIKit
import Hero
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var nameSplitLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    
    @IBOutlet weak var slideBackgroundView: UIView!
    @IBOutlet weak var selectedSlideView: UIView!
    @IBOutlet weak var slideViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var indexOfCellBeforeDragging = 0
    private var first: Bool = true
    
    var plants: [Plant] = [] {
        didSet {
            if oldValue != plants {
                collectionView.reloadData()
                slideViewWidthConstraint.constant = slideBackgroundView.frame.width / CGFloat(plantsCount)
            }
        }
    }
    var plantsCount: Int {
        return plants.count + 1
    }
    
    private func setUpSlideView() {
        slideBackgroundView.clipsToBounds = true
        selectedSlideView.clipsToBounds = true
        
        slideBackgroundView.layer.cornerRadius = slideBackgroundView.frame.height / 2
        selectedSlideView.layer.cornerRadius = selectedSlideView.frame.height / 2
    }
    
    private func setUpCollectionView() {
        let homeCardName = HomeCardCollectionViewCell.reuseIdentifier
        let homeCardNib = UINib(nibName: homeCardName, bundle: nil)
        let addCardName = AddCardCollectionViewCell.reuseIdentifier
        let addCardNib = UINib(nibName: addCardName, bundle: nil)
        
        collectionView.register(homeCardNib, forCellWithReuseIdentifier: homeCardName)
        collectionView.register(addCardNib, forCellWithReuseIdentifier: addCardName)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewLayout.minimumLineSpacing = 0
        collectionView.delaysContentTouches = false
        collectionView.hero.isEnabled = true
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = 40
        
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionViewLayout.itemSize = CGSize(width: collectionView.frame.size.width - inset * 2, height: collectionView.frame.size.height)
        
        collectionView.layoutIfNeeded()
    }
    
    private func setFirstCellSize() {
        let indexPath = IndexPath.init(item: 0, section: 0)
        let firstCell = collectionView.cellForItem(at: indexPath)
        
        if let cell = firstCell as? HomeCardCollectionViewCell {
            cell.topLayoutConstraint.constant = 0
            englishNameLabel.text = cell.plant?.englishName
            koreanNameLabel.text = cell.plant?.koreanName
            customNameLabel.text = cell.plant?.nickName
            nameSplitLabel.isHidden = false
        } else if let cell = firstCell as? AddCardCollectionViewCell {
            cell.topLayoutConstraint.constant = 0
        }
        
        collectionView.layoutIfNeeded()
    }
    
    func checkLogin() {
        if Global.shared.user == nil {
            let storyboard = UIStoryboard.init(name: StoryboardName.login, bundle: nil)
            guard let loginVC = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController else {
                return
            }
            
            //present(loginVC, animated: true, completion: nil)
        }
    }
    
    func loadToastView() {
        let toastView = BasicToastView.instance()
        toastView.frame = CGRect(x: (self.view.bounds.width - toastView.bounds.width) / 2, y: self.view.bounds.height - 50, width: toastView.bounds.width, height: toastView.bounds.height)
        toastView.setUp(with: "식물이 성공적으로 등록되었습니다.")
        view.addSubview(toastView)
        UIView.animate(withDuration: 3.0, delay: 0.01, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpSlideView()
        
        loadToastView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        plants = Global.shared.plants
    }
    
    override func viewDidLayoutSubviews() {
        if !first {
            animateCell()
        }
        
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
        slideViewWidthConstraint.constant = slideBackgroundView.frame.width / CGFloat(plantsCount)
        
        if first {
            setFirstCellSize()
            first = false
        }
        
    }
}
