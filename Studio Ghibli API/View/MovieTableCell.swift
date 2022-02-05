//
//  MovieTableCell.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import UIKit

/// Custom Tableview cell to display the title, director and description, when tapped, of each movie
class MovieTableCell: UITableViewCell {
    static let identifier = "MovieTableCell"

    var cellConfiguration: UIListContentConfiguration!

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }()

    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(movieTitleLabel)

        self.selectionStyle = .none

        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true

        movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        // Keep the icon in the center of the title label even when the user taps to expand the cell
        iconImageView.centerYAnchor.constraint(equalTo: movieTitleLabel.centerYAnchor).isActive = true

//        cellConfiguration = self.defaultContentConfiguration()
//        cellConfiguration.image = UIImage(named: "icon.png")
//        cellConfiguration.text = "test"
//        self.contentConfiguration = cellConfiguration
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConfiguration(using state: UICellConfigurationState) {

    }

    /// When the user taps on a cell, the cell expands to reveal more details about what data they're consenting to share with Intuit
    func addDetailLabel() {
        self.contentView.addSubview(movieDescriptionLabel)
        movieDescriptionLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10).isActive = true
        movieDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        movieDescriptionLabel.trailingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor).isActive = true
        movieDescriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }

    /// When the user taps on an expanded cell, the cell will shrink back to originial height to only show the title
    func removeDetailLabel() {
        self.movieDescriptionLabel.removeFromSuperview()
    }

    func updateData(model: StudioGhibliMovie) {
        iconImageView.image = UIImage(named: "icon.png")
        movieTitleLabel.text = model.title
        movieDescriptionLabel.text = model.studioGhibliMovieDescription
    }

}
