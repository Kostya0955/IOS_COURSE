//
//  AppDelegate.swift
//  RSS Reader
//
//  Created by Константин Головнев on 11/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        userLoggedIn = defaults.bool(forKey: authKey)
        time = defaults.string(forKey: timeKey) ?? timeIntervalArr[0]
        sorted = defaults.string(forKey: sortKey) ?? sortedByArr[0]
        language = defaults.string(forKey: langKey) ?? languageArr[0]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainController = UITabBarController()
        let loginVC = LoginViewController()
        
        window?.rootViewController = mainController
        setupMainVC(mainController: mainController)
        
        window?.makeKeyAndVisible()
        
        if userLoggedIn == false {
            mainController.present(loginVC, animated: false, completion: nil)
        }
        loadData()
        return true
    }
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Subscriptions> = Subscriptions.fetchRequest()
        
        do {
            subs = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setupMainVC(mainController: UITabBarController) {
        mainController.view.backgroundColor = .white
        mainController.tabBar.barTintColor = customBlueColor
        
        guard let loupeWhite = UIImage(named: "loupeWhite") else { return }
        guard let loupeBlack = UIImage(named: "loupeBlack") else { return }
        guard let newspaperWhite = UIImage(named: "newspaperWhite") else { return }
        guard let newspaperBlack = UIImage(named: "newspaperBlack") else { return }
        guard let discoverWhite = UIImage(named: "discoverWhite") else { return }
        guard let discoverBlack = UIImage(named: "discoverBlack") else { return }
        
        let searchController = createNavigationContoller(viewContoller: SearchViewController(), image: loupeWhite, selectedImage: loupeBlack)
        
        let myNewsController = createNavigationContoller(viewContoller: MyNewsViewController(), image: newspaperWhite, selectedImage: newspaperBlack)
        
        let discoverController = createNavigationContoller(viewContoller: DiscoverViewController(), image: discoverWhite, selectedImage: discoverBlack)
        
        mainController.viewControllers = [searchController, myNewsController, discoverController]
        
        guard let items = mainController.tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -8, right: 0)
        }
    }
    
    func createNavigationContoller(viewContoller: UIViewController, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        let navigationContoller = UINavigationController(rootViewController: viewContoller)
        navigationContoller.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        navigationContoller.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        navigationContoller.navigationBar.isHidden = true
        return navigationContoller
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RSS_Reader")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

