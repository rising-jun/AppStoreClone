//
//  SceneDelegate.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let dependencyFactory = DependencyFactory()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = UINavigationController(rootViewController: SearchViewController(dependency: dependencyFactory.injectSearchDependency()))
        window.makeKeyAndVisible()
        self.window = window
    }
}
