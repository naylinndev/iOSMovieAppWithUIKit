//
//  MovieViewController.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//

import Foundation
import UIKit

protocol MovieDisplayedLogic {
    func displayDiscoverMovies(viewModel : MovieModel.FetchDiscoverVideos.ViewModel)
}
class MovieViewController : UIViewController, MovieDisplayedLogic {
    
    var movieInteractor : MovieInteractor?
    var router: (NSObjectProtocol & MovieRoutingLogic & MovieDataPassing)?

    private lazy var sizingCell: MovieCollectionViewCell? = .fromNib()

    var displayedMovies: [MovieModel.DisplayedMovie] = []
    var hasMorePages : Bool = false
    var lastID : Int = 0
    var lastPopularity : Double = 0.0
    var currentPage : Int = 1

    @IBOutlet weak var collectionView: UICollectionView!

    
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
        setupCollectionView()
        fetchDiscoverMovies()

    }
    
    
}

// MARK: Fetch discoverMovies on screen load

extension MovieViewController {
    
    // MARK: Fetch the data to display in the movies collection view
    
    func fetchDiscoverMovies() {
        let request = MovieModel.FetchDiscoverVideos.Request(page: self.currentPage,lastID: self.lastID,lastPopularity : self.lastPopularity)
        movieInteractor?.fetchDiscoverMovies(request: request)
    }
    
    func displayDiscoverMovies(viewModel: MovieModel.FetchDiscoverVideos.ViewModel) {
        displayedMovies += viewModel.displayedMovies
        hasMorePages = viewModel.hasMorePages
        currentPage = viewModel.currentPage
        lastID = viewModel.lastID
        lastPopularity = viewModel.lastPopularity

        collectionView.reloadData()
    }
}



// MARK: - Collection view delegates

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if hasMorePages {
            return 2
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if hasMorePages {
            if section == 0 {
                return displayedMovies.count
            }else if section == 1 {
                return 1
            }else {
                return 0
            }
        }else {
            return displayedMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            let movie = self.displayedMovies[indexPath.row]
            cell.update(item: movie)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            cell.loadingView.startAnimating()
            return cell
        }
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0 {
            let widthOfCell: CGFloat

            if traitCollection.userInterfaceIdiom == .phone {
                widthOfCell = floor((collectionView.frame.size.width - 3.0 * Style.Size.margin) / 2.0)
            } else {
                var isLandscape : Bool
                
                if #available(iOS 13.0, *) {
                    isLandscape = UIApplication.shared.windows
                        .first?
                        .windowScene?
                        .interfaceOrientation
                        .isLandscape ?? false
                } else {
                    isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
                }
                
                if isLandscape {
                    widthOfCell = floor((collectionView.frame.size.width - 6.0 * Style.Size.margin) / 5.0)
                } else {
                    widthOfCell = floor((collectionView.frame.size.width - 4.0 * Style.Size.margin) / 3.0)
                }
            }
            return getCellsize(indexPath, widthOfCell)

        }else {
            return CGSize(width: collectionView.frame.size.width, height: 50)
        }
        
    }
    
    private func getCellsize(_ indexPath: IndexPath, _ widthOfCell: CGFloat) -> CGSize {
        // load cell from Xib
        guard let cell = sizingCell, !displayedMovies.isEmpty else {
            return CGSize(width: widthOfCell, height: 350)
        }
        
        // configure cell with data in it
        let data = self.displayedMovies[indexPath.row]
        cell.update(item: data)
        
        return cell.getSize(widthOfCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && hasMorePages && indexPath.row == self.displayedMovies.count - 1 {
            currentPage += 1
            fetchDiscoverMovies()
        }
    }
   

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = displayedMovies[indexPath.row]
        router?.showMovieDetailPage(for: movie.id)
    }
}


// MARK: Setup

private extension MovieViewController {
    
    func setup() {
        title = "Movies"
        let viewController = self
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let router = MovieRouter()

        viewController.router = router
        viewController.movieInteractor = interactor
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Style.Size.margin, bottom: 44, right: Style.Size.margin)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        collectionView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCell")

    }
}
