//
//  DetailViewController.swift
//
//  Created by Liubov
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func deleteCharacterData(with id: Int64)
    func updateCharacterData(_ character: Character)
}

final class DetailViewController: UIViewController {
    
    var data: Character? {
        didSet {
            guard let data = data else { return }
            setUpData(data)
        }
    }
    
    weak var delegate: DetailViewControllerDelegate?
    
    let nameChanger = UIAlertController()
    let speciesChanger = UIAlertController()
    let locationChanger = UIAlertController()
    
    private lazy var editNameButton: UIButton = {
        let editNameButton = UIButton()
        editNameButton.translatesAutoresizingMaskIntoConstraints = false
        editNameButton.setImage(UIImage(named: "EditButton.svg"), for: .normal)
        return editNameButton
    }()

    private lazy var editSpeciesButton: UIButton = {
        let editSpeciesButton = UIButton()
        editSpeciesButton.translatesAutoresizingMaskIntoConstraints = false
        editSpeciesButton.setImage(UIImage(named: "EditButton.svg"), for: .normal)
        return editSpeciesButton
    }()

    private lazy var editLocationButton: UIButton = {
        let editLocationButton = UIButton()
        editLocationButton.translatesAutoresizingMaskIntoConstraints = false
        editLocationButton.setImage(UIImage(named: "EditButton.svg"), for: .normal)
        return editLocationButton
    }()

    let updateAction = UIAlertAction(title: "OK", style: .default) { (_) in
        print("OK!")
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        print("Cancel!")
    }
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete this character", for: .normal)
        deleteButton.backgroundColor = .systemRed
        deleteButton.layer.cornerRadius = 10
        deleteButton.titleLabel?.numberOfLines = 0
        deleteButton.titleLabel?.textAlignment = .center
        return deleteButton
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameHint: UILabel = {
        let nameHint = UILabel()
        nameHint.translatesAutoresizingMaskIntoConstraints = false
        nameHint.text = "Name:"
        nameHint.textColor = .systemGray
        nameHint.textAlignment = .left
        nameHint.numberOfLines = 0
        return nameHint
    }()
    
    private lazy var statusHint: UILabel = {
        let statusHint = UILabel()
        statusHint.numberOfLines = 0
        statusHint.translatesAutoresizingMaskIntoConstraints = false
        statusHint.text = "Status:"
        statusHint.textColor = .systemGray
        return statusHint
    }()
    
    private lazy var genderHint: UILabel = {
        let genderHint = UILabel()
        genderHint.numberOfLines = 0
        genderHint.translatesAutoresizingMaskIntoConstraints = false
        genderHint.textColor = .systemGray
        genderHint.text = "Gender:"
        return genderHint
    }()
    
    private lazy var speciesHint: UILabel = {
        let speciesHint = UILabel()
        speciesHint.numberOfLines = 0
        speciesHint.translatesAutoresizingMaskIntoConstraints = false
        speciesHint.textColor = .systemGray
        speciesHint.text = "Species:"
        return speciesHint
    }()
    
    private lazy var locationHint: UILabel = {
        let locationHint = UILabel()
        locationHint.numberOfLines = 0
        locationHint.translatesAutoresizingMaskIntoConstraints = false
        locationHint.textColor = .systemGray
        locationHint.text = "Location:"
        return locationHint
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.numberOfLines = 0
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.numberOfLines = 0
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        return genderLabel
    }()
    
    private lazy var speciesLabel: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.numberOfLines = 0
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        return speciesLabel
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.numberOfLines = 0
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
    }()
    
    @objc func deleteButtonDidTap(_ sender: Any) {
        guard let data = data else { return }
        delegate?.deleteCharacterData(with: data.dataID)
    }

    
    private func setUpViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(deleteButton)
        
        view.addSubview(nameHint)
        view.addSubview(statusHint)
        view.addSubview(speciesHint)
        view.addSubview(locationHint)
        view.addSubview(genderHint)
        
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(locationLabel)
        view.addSubview(genderLabel)
        
        view.addSubview(editNameButton)
        view.addSubview(editSpeciesButton)
        view.addSubview(editLocationButton)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45),
            imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            
            nameHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            nameHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            nameHint.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nameHint.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),

            statusHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            statusHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            statusHint.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusHint.centerYAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            
            speciesHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            speciesHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            speciesHint.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            speciesHint.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            
            locationHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            locationHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            locationHint.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            locationHint.centerYAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),
            
            genderHint.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            genderHint.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            genderHint.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            genderHint.centerYAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            
            nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            nameLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            nameLabel.leadingAnchor.constraint(equalTo: nameHint.trailingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),

            statusLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            statusLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            statusLabel.leadingAnchor.constraint(equalTo: statusHint.trailingAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            
            speciesLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            speciesLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            speciesLabel.leadingAnchor.constraint(equalTo: speciesHint.trailingAnchor),
            speciesLabel.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            
            locationLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            locationLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            locationLabel.leadingAnchor.constraint(equalTo: locationHint.trailingAnchor),
            locationLabel.centerYAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),
            
            genderLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            genderLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            genderLabel.leadingAnchor.constraint(equalTo: genderHint.trailingAnchor),
            genderLabel.centerYAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            
            editNameButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.05),
            editNameButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.05),
            editNameButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            editNameButton.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),

            editSpeciesButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.05),
            editSpeciesButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.05),
            editSpeciesButton.leadingAnchor.constraint(equalTo: speciesLabel.trailingAnchor, constant: 16),
            editSpeciesButton.centerYAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),

            editLocationButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.05),
            editLocationButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.05),
            editLocationButton.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 16),
            editLocationButton.centerYAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),

            deleteButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            deleteButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            deleteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 64)
        ])
        
        editNameButton.addTarget(self, action: #selector(editNameButtonTapped), for: .touchUpInside)
        editSpeciesButton.addTarget(self, action: #selector(editSpeciesButtonTapped), for: .touchUpInside)
        editLocationButton.addTarget(self, action: #selector(editLocationButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    
    private func setUpData(_ data: Character) {
        nameLabel.text = data.name
        statusLabel.text = data.status
        speciesLabel.text = data.species
        genderLabel.text = data.gender
        locationLabel.text = data.location
        imageView.image = UIImage(data: data.image!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    @objc func editNameButtonTapped() {
        let textChanger = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        textChanger.addTextField { textField in
            textField.placeholder = "Name"
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            if let textField = textChanger.textFields?.first,
               let newText = textField.text {
                if var character = self?.data {
                    character.name = newText
                    self?.nameLabel.text = newText
                    self?.delegate?.updateCharacterData(character)
                }
            }
        }
        textChanger.addAction(updateAction)
        textChanger.addAction(cancelAction)
        present(textChanger, animated: true, completion: nil)
    }

    @objc func editSpeciesButtonTapped() {
        let textChanger = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        textChanger.addTextField { textField in
            textField.placeholder = "Species"
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            if let textField = textChanger.textFields?.first,
               let newText = textField.text {
                if var character = self?.data {
                    character.species = newText
                    self?.speciesLabel.text = newText
                    self?.delegate?.updateCharacterData(character)
                }
            }
        }
        textChanger.addAction(updateAction)
        textChanger.addAction(cancelAction)
        present(textChanger, animated: true, completion: nil)
    }

    @objc func editLocationButtonTapped() {
        let textChanger = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        textChanger.addTextField { textField in
            textField.placeholder = "Location"
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            if let textField = textChanger.textFields?.first,
               let newText = textField.text {
                if var character = self?.data {
                    character.location = newText
                    self?.locationLabel.text = newText
                    self?.delegate?.updateCharacterData(character)
                }
            }
        }
        textChanger.addAction(updateAction)
        textChanger.addAction(cancelAction)
        present(textChanger, animated: true, completion: nil)
    }
}
