//
//  UISearch+CustomTheme.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import Foundation
import UIKit
import uicomponents

extension UISearchBar {
    func appliedTheme(appTheme : AppBaseTheme) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = ColouringUtilities.color(withHexString: appTheme.primaryTextColor)
        self.barTintColor = ColouringUtilities.color(withHexString: appTheme.navigationColor)
    }
}
