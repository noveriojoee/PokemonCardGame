//
//  CardPopUpViewController.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import UIKit

class CardPopUpViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var uiView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var imageUrl : String?
    weak var consummerVc : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let blurrEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurrEffect)
//        blurEffectView.frame = self.view.bounds
//
//        self.view.insertSubview(blurEffectView, belowSubview: self.uiView)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.imageUrl == nil) {return}
        
        self.imgView.downloaded(from: self.imageUrl!)
    }
    
    public func showCardPopUp(image : String?, consumerVC : UIViewController?){
        if (consumerVC == nil || image == nil) {return}
        self.consummerVc = consumerVC
        
        self.isModalInPopover = true
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        
        self.imageUrl = image
        self.consummerVc!.present(self, animated: true, completion: nil)
    }

    @IBAction func btnOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
