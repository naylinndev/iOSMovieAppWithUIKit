//
//  MovieDetailViewController.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 27/05/2023.
//

import Foundation
import UIKit

protocol MovieDetailViewModel {
    func displayDiscoverMovie(viewModel : MovieDetailModel.GetDiscoverMovie.ViewModel.DisplayMovie)
}


class MovieDetailViewController : UIViewController ,MovieDetailViewModel{
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var lblRating : UILabel!
    @IBOutlet weak var lblMovieTitle : UILabel!
    @IBOutlet weak var lblMovieDescription : UILabel!
    @IBOutlet weak var lblMovieReleaseDate : UILabel!
    @IBOutlet weak var btnAddToFavorite : UIButton!

    var interactor : MovieDetailInteractor?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
   
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDiscoverMovie()
    }
    
}

extension MovieDetailViewController {
    
    func getDiscoverMovie(){
        interactor?.getDiscoverMovie(request: MovieDetailModel.GetDiscoverMovie.Request())
    }
    
    func displayDiscoverMovie(viewModel: MovieDetailModel.GetDiscoverMovie.ViewModel.DisplayMovie) {

        if imageView.image == nil {
            imageView.load.request(with: viewModel.posterImage)
        }
        lblRating.text = "⭐️ \(viewModel.rating)"
        lblMovieTitle.text = viewModel.title
        lblMovieDescription.text = viewModel.description
        lblMovieReleaseDate.text = viewModel.date


        if viewModel.favorite {
            btnAddToFavorite.setTitle("Remove Favorite", for: .normal)
        }else {
            btnAddToFavorite.setTitle("Add To Favorite", for: .normal)
        }

    }
    @IBAction func toggleFavorite(_ sender: Any) {
        interactor?.toggleFavorite()
    }
    
}

extension MovieDetailViewController{
    func setup() {
        let viewcontroller = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router = router
        
        interactor.presenter = presenter
        
        presenter.viewController = viewcontroller
        
        router.dataStore = interactor
    }
}
