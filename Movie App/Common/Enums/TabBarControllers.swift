//
//  TabBarControllers.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 25/05/2023.
//


import Foundation
import SwiftIconFont


/// Enum containing the tabbar controllers
///
/// - home: Main TabBar page
/// - chart: User charts
/// - account: User account controller
enum TabBarControllers: String, CaseIterable {
    case movies
    case favourite
    
    /// Return the image associated with the current value of TabBarControllers
    ///
    /// - Parameter selected: Boolean taht determinates the state of image
    /// - Returns: The  image to display in the tabbar
    func getImage(selected: Bool = false) -> UIImage {
        switch self {
        case .movies:
            return UIImage(from: .fontAwesome5, code: "image", textColor: selected ? Style.Color.MainGray : .lightGray, backgroundColor: .clear, size: Style.Size.tabBarIcon)
        case .favourite:
            return UIImage(from: .fontAwesome5, code: "star", textColor: selected ? Style.Color.MainGray : .lightGray, backgroundColor: .clear, size: Style.Size.tabBarIcon)
                   
        }
    }
    
    /// Return a viewController associated with the current value of TabBarControllers
    ///
    /// - Returns: ViewController to display in tabbar
    func getViewController() -> UIViewController {
        switch self {
        case .movies:
            return MovieViewController()
        case .favourite:
            return  UIViewController()
            
        }
    }
    
    /// Help for formatted names of controllers in tabbar
    ///
    /// - Returns: Uppercase controllers description names
    func getName() -> String {
        switch self {
        case .movies:
            return "Movies"
        case .favourite:
            return "Favourite"
        }
    }
}

