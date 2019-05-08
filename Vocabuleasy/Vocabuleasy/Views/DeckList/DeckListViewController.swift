//
//  DeckListViewController.swift
//  Vocabuleasy
//
//  Created by Eric Groom on 5/7/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import UIKit
import CoreData

class DeckListViewController: UIViewController {
    
    private let tableView = UITableView()
    private lazy var fetchController: NSFetchedResultsController<Deck> = {
        let context = ContainerService.shared.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        let sortNameDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        fetchRequest.sortDescriptors = [sortNameDescriptor]
        
        return  NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    private let reuseId = "DeckCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Decks"
        
        performFetchRequest()
        
        view.addSubview(tableView)
        tableView.fill(parent: view)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showNewDeckAlert))
    }
    
    @objc private func showNewDeckAlert() {
        let alert = UIAlertController(title: "Add New Deck", message: "Enter the name of your new deck", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, name.count > 0 else { return }
            self.addNewDeck(withName: name)
        }
        alert.addAction(addAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewDeck(withName name: String) {
        let context = fetchController.managedObjectContext
        let deck = Deck(context: context)
        deck.name = name
        do {
            try context.save()
            NotificationService.showSuccessBanner(withText: "Deck saved")
        } catch {
            NotificationService.showErrorBanner(withText: "Unable to save deck")
        }
    }
    
    private func performFetchRequest() {
        do {
            try fetchController.performFetch()
        } catch {
            NotificationService.showErrorBanner()
        }
    }

}

extension DeckListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let decks = fetchController.fetchedObjects else { return 0 }
        return decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        cell.textLabel?.text = fetchController.object(at: indexPath).name
        return cell
    }
}

extension DeckListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deck = fetchController.object(at: indexPath)
        let vc = DeckDetailViewController()
        vc.deck = deck
        navigationController?.pushViewController(vc, animated: true)
    }
}
