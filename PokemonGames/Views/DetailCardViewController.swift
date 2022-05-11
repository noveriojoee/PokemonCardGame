//
//  DetailCardViewController.swift
//  PokemonGames
//
//  Created by noverio joe on 16/02/22.
//

import UIKit

class DetailCardViewController: ViewModelScreen<DetailCardViewModel> ,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblAttributeTitle: UILabel!
    @IBOutlet weak var lblAttributeDetail: UILabel!
    @IBOutlet weak var lblFlavorTitle: UILabel!
    @IBOutlet weak var lblFlavorDetail: UILabel!
    @IBOutlet weak var relatedCardCollectionView: UICollectionView!
    
    var arguments : DetailCardArgs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.registerObservabilityToView(object: self.arguments)
        
        self.relatedCardCollectionView.delegate = self
        self.relatedCardCollectionView.dataSource = self
        self.relatedCardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: Bundle.init(identifier: "com.gid.PokemonGame.PokemonGames")), forCellWithReuseIdentifier: "card_collection_identifier")
        self.relatedCardCollectionView.register(UINib(nibName: "ActivityIndicatorCollectionViewCell", bundle: Bundle.init(identifier: "com.gid.PokemonGame.PokemonGames")), forCellWithReuseIdentifier: "activity_collection_identifier")
        self.relatedCardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        
        
        self.relatedCardCollectionView.collectionViewLayout.invalidateLayout()
        
        self.relatedCardCollectionView.alwaysBounceHorizontal = true
        self.relatedCardCollectionView.alwaysBounceVertical = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getDetailCard(onGetCardCompleted: {
            (resultMessage) -> Void in
            if (resultMessage != "OK"){return}
            
            guard let imageUrl = self.viewModel.selectedCard?.images?.small else{
                return
            }
            
            self.imgView.downloaded(from: imageUrl)
            self.lblAttributeTitle.text = self.viewModel.selectedCard?.name ?? "(-)"
            self.lblAttributeDetail.text = self.viewModel.getAttributeDetail()
            
            self.lblFlavorTitle.text = "Flavor"
            self.lblFlavorDetail.text = self.viewModel.getFlavourDetail()
            
            
        })
        self.viewModel.loadOtherCards(onSearchCompleted: {
            (resultMessage) -> Void in
            self.relatedCardCollectionView.reloadData()
        })
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        guard let imageUrl = self.viewModel.selectedCard?.images?.small else{
            return
        }

        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let popUpVC = CardPopUpViewController(nibName: "CardPopUpViewController", bundle: Bundle.main)
        popUpVC.showCardPopUp(image: imageUrl, consumerVC: self)
    }
    
    //##CollectionView Delegate
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.relatedCardCollectionView.frame.width / 3) - CGFloat(5)
        let height = self.relatedCardCollectionView.frame.height
        let sizeOfCard = CGSize(width: width, height: height)
        
        return sizeOfCard
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            guard let cellItem = self.relatedCardCollectionView.dequeueReusableCell(withReuseIdentifier: "card_collection_identifier", for: indexPath) as? CardCollectionViewCell else{
                return relatedCardCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            let card = self.viewModel.pokemonCards![indexPath.item]
            
            cellItem.setCardImage(image: card!.images!.large!)
            
            return cellItem
        }
        else if(indexPath.section == 1){
            guard let cellItem = self.relatedCardCollectionView.dequeueReusableCell(withReuseIdentifier: "activity_collection_identifier", for: indexPath) as? ActivityIndicatorCollectionViewCell else{
                return relatedCardCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            
            cellItem.setupIndicatorViewCell()
            
            return cellItem
        }
        return relatedCardCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.viewModel.pokemonCardsCount - 1  && !self.viewModel.isFetchingData{
            self.viewModel.cardsPage += 1
            self.viewModel.loadMore { (responseCode) -> Void in
                self.relatedCardCollectionView.reloadData()
            }
        }
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
