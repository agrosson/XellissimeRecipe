//
//  AppDelegate.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 27/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let navFont = UIFont(name: "BradleyHandITCTT-Bold", size: 28) else {return false}
        let navFontAttribute = [NSAttributedString.Key.font: navFont]
        UIBarButtonItem.appearance().setTitleTextAttributes(navFontAttribute, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(navFontAttribute, for: .selected)
        UIBarButtonItem.appearance().setTitleTextAttributes(navFontAttribute, for: .highlighted)
        UITabBarItem.appearance().setTitleTextAttributes(navFontAttribute, for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(navFontAttribute, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(navFontAttribute, for: .highlighted)
        UINavigationBar.appearance().titleTextAttributes = navFontAttribute
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
 }

    func applicationWillEnterForeground(_ application: UIApplication) {
}

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "XellissimeRecipe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print(storeDescription)
        })
        return container
    }()

    // AppDelegate.persistentContainer
    static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    static var viewContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

