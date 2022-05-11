//
//  ViewModelScreen.swift
//  PokemonGames
//
//  Created by noverio joe on 12/02/22.
//

import UIKit
import NVActivityIndicatorView
import uicomponents

class ViewModelScreen<T : BaseViewModel>: UIBaseViewController {
    var activityIndicator : NVActivityIndicatorView?
    let viewModel : T = T()
    let uiComponent = UIComponentsInstances.sharedManager()
    let applicationTheme = UIComponentsInstances.sharedManager().appTheme
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder?) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = ColouringUtilities.color(withHexString: applicationTheme.navigationColor)
        self.setViewControllerBackgroundColour(self.applicationTheme.backgroundColor, targetedView: self.view)
        self.viewModel.viewContext = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
