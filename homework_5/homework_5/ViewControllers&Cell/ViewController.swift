//
//  ViewController.swift
//  homework_5
//
//  Created by Liubov on 12.07.2023.
//

import UIKit
import Foundation
import CoreData

enum CharacterListState {
    case data
    case error
    case fatalError
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate, NSFetchedResultsControllerDelegate {
    
    private let manager = NetworkManager()
    private var characters: [CharacterResponseModel]? = []
    
     
    private let visitCounterData: UILabel = {
        let visitCounterData = UILabel()
        visitCounterData.translatesAutoresizingMaskIntoConstraints = false
        visitCounterData.textColor = .black
        visitCounterData.numberOfLines = 0
        let numberOfVisits = UserDefaults.standard.integer(forKey: "visitCounter")
        visitCounterData.text = String(numberOfVisits)
        return visitCounterData
    }()
        
    private let visitCounterImage: UIImageView = {
        let visitCounterImage = UIImageView()
        visitCounterImage.image = UIImage(named: "eye.png")
        return visitCounterImage
    }()

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    lazy var frc: NSFetchedResultsController<Character> = {
        let request = Character.fetchRequest()
        request.sortDescriptors = [
            .init(key: "name", ascending: true)
        ]
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: PersistentContainer.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        frc.delegate = self
        return frc
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        let numberOfVisits = UserDefaults.standard.integer(forKey: "visitCounter")
        if (numberOfVisits % 3 == 0){
            let alert = UIAlertController(title: "Welcome back :)", message: "Now it is your app visit #\(numberOfVisits)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Nice", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        customHeaderView.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Rick & Morty characters"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.backgroundColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: customHeaderView.frame.width * 0.7, height: customHeaderView.frame.height)
        
        let visitCounterView = UIView()
        visitCounterView.backgroundColor = .systemBackground
        visitCounterView.frame = CGRect(x: customHeaderView.frame.width * 0.7 + 30, y: 0, width: customHeaderView.frame.width * 0.3 - 30, height: customHeaderView.frame.height)
        
        visitCounterData.font = .systemFont(ofSize: 18)
        visitCounterImage.frame = CGRect(x: 0, y: (visitCounterView.frame.height - visitCounterView.frame.width * 0.3) / 2, width: visitCounterView.frame.width * 0.3, height: visitCounterView.frame.width * 0.3)
        visitCounterData.frame = CGRect(x: visitCounterImage.frame.width + 10, y: 0, width: visitCounterView.frame.width - visitCounterImage.frame.width - 10, height: visitCounterView.frame.height)
            
        visitCounterView.addSubview(visitCounterImage)
        visitCounterView.addSubview(visitCounterData)
        customHeaderView.addSubview(label)
        customHeaderView.addSubview(visitCounterView)
        
        return customHeaderView
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterCell")
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
            
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
        loadCharacters()
    }
    
    private func loadCharacters() {
        manager.fetchCharacters { result in
            switch result {
            case let .success(response):
                DispatchQueue.global(qos: .background).async{
                    for character in response.characters{
                        do {
                            let request = Character.fetchRequest()
                            request.predicate = NSPredicate(format: "dataID == %i", character.id)
                            let results = try PersistentContainer.shared.viewContext.fetch(request)
                            if(results.first==nil){
                                let url = URL(string: character.image)!
                                let image = try? Data(contentsOf:url)
                                let newCharacter = Character(context: PersistentContainer.shared.viewContext)
                                newCharacter.dataID = Int64(character.id)
                                newCharacter.name = character.name
                                newCharacter.gender = character.gender
                                newCharacter.image = image
                                newCharacter.location = character.location.location
                                newCharacter.species = character.species
                                newCharacter.status = character.status
                                PersistentContainer.shared.saveContext()
                            }
                        } catch {
                            print(error)
                        }
                      
                    }
                    DispatchQueue.main.async {
                        self.reloadData()
                    }
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func deleteCharacterData(with id: Int64) {
        do {
            let request = Character.fetchRequest()
            request.predicate = NSPredicate(format: "dataID == %i", id)
            let results = try PersistentContainer.shared.viewContext.fetch(request)
            results.forEach { result in
                PersistentContainer.shared.viewContext.delete(result)
            }
            PersistentContainer.shared.saveContext()
        } catch {
            print(error)
        }
        dismiss(animated: true)
    }

    func updateCharacterData(_ character: Character) {
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func tableViewSetup() {
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.clear
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.delegate = self
        present(detailViewController, animated: true)
        let character = frc.object(at: indexPath)
        detailViewController.data = character
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = frc.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Couldn't dequeue cell with identifier: CharacterTableViewCell")
        }
        let obtainedCharacter = frc.object(at: indexPath)
        cell.setUpData(obtainedCharacter)
        cell.setUpViews()
        cell.backgroundColor = .systemBackground
        return cell
    }

    @objc func refresh(_ sender: AnyObject) {
        loadCharacters()
        sender.endRefreshing()
    }
}
