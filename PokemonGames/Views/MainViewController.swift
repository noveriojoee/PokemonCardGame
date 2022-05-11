//
//  ViewController.swift
//  PokemonGames
//
//  Created by noverio joe on 12/02/22.
//

import UIKit


class MainViewController: ViewModelScreen<MainViewModel>, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var sbSearchPokemon: UISearchBar!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var timer = Timer()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sbSearchPokemon.delegate = self
        self.sbSearchPokemon.appliedTheme(appTheme: self.applicationTheme)
        
        self.sbSearchPokemon.placeholder = "Search Pokemon by name.."
        self.sbSearchPokemon.sizeToFit()
        self.navigationItem.titleView = self.sbSearchPokemon
        
        self.cardCollectionView.delegate = self
        self.cardCollectionView.dataSource = self
        self.cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: Bundle.init(identifier: "com.gid.PokemonGame.PokemonGames")), forCellWithReuseIdentifier: "card_collection_identifier")
        self.cardCollectionView.register(UINib(nibName: "ActivityIndicatorCollectionViewCell", bundle: Bundle.init(identifier: "com.gid.PokemonGame.PokemonGames")), forCellWithReuseIdentifier: "activity_collection_identifier")
        self.cardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")

        
        self.cardCollectionView.collectionViewLayout.invalidateLayout()
        self.cardCollectionView.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //internal Method
    
    @objc func searchPokemon(isImediate : Bool){
        self.count += 1
        if(count == 5){
            self.count = 0
            self.timer.invalidate()
            self.viewModel.searchPokemon { (responseCode) -> Void in
                self.cardCollectionView.reloadData()
            }
        }
    }
    
    //##Internal Method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //bind value
        viewModel.searchText = searchText
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.searchPokemon), userInfo: nil, repeats: true)
    }
    
    //##CollectionView Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.sbSearchPokemon.endEditing(true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return self.viewModel.pokemonCardsCount
        }else{
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.goToDetailCard(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0){
            let width = (self.cardCollectionView.frame.width / 2) - CGFloat(5)
            let height = (self.cardCollectionView.frame.height / 3) - CGFloat(5)
            let sizeOfCard = CGSize(width: width, height: height)
            
            return sizeOfCard
        }
        
        return CGSize(width: self.cardCollectionView.frame.width, height: (self.cardCollectionView.frame.height / 3))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            guard let cellItem = self.cardCollectionView.dequeueReusableCell(withReuseIdentifier: "card_collection_identifier", for: indexPath) as? CardCollectionViewCell else{
                return cardCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            let card = self.viewModel.pokemonCards![indexPath.item]
            
            cellItem.setCardImage(image: card!.images!.large!)
            
            return cellItem
        }
        else if(indexPath.section == 1 && self.viewModel.pokemonCardsCount > 0){
            guard let cellItem = self.cardCollectionView.dequeueReusableCell(withReuseIdentifier: "activity_collection_identifier", for: indexPath) as? ActivityIndicatorCollectionViewCell else{
                return cardCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            
            cellItem.setupIndicatorViewCell()
            
            return cellItem
        }
        return cardCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.pokemonCardsCount - 1  && !self.viewModel.isFetchingData{
            self.viewModel.cardsPage += 1
            self.viewModel.loadMore { (responseCode) -> Void in
                self.cardCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "segue_to_detail"){
            guard let nextVC = segue.destination as? DetailCardViewController else{
                return
            }
            guard let args = sender as? DetailCardArgs else{
                return
            }
            nextVC.arguments = args
        }
    }
    
}
