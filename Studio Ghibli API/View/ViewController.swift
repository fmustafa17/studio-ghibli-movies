//
//  ViewController.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import UIKit
import Combine

class ViewController: UITableViewController {

    // this will contain the index of the row (integer) that is expanded
    var expandedCellSet: IndexSet = []

    lazy var viewModel: ViewModel = {
        let viewModel = ViewModel(apiManager: APIManager())
        return viewModel
    }()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        bindViewModel()
    }

    /// Register the cell for reuse and add any configurations for the tableView
    private func setUpTableView() {
        tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }

    /// Use the viewModel to fetch the data and publish the event
    private func bindViewModel() {
        self.viewModel.fetchMovies()

        viewModel.$movies
           .receive(on: DispatchQueue.main)
           .sink { [weak self] movies in
              self?.tableView.reloadData()
           }
           .store(in: &cancellables)
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: MovieTableCell.identifier, for: indexPath) as? MovieTableCell)!
        cell.updateData(model: self.viewModel.movies[indexPath.row])

        // if the cell is expanded
        if expandedCellSet.contains(indexPath.row) {
            // Add the detail label and add the constraints to the cell
            cell.addDetailLabel()
            cell.movieDescriptionLabel.text = self.viewModel.movies[indexPath.row].studioGhibliMovieDescription
        } else {
            // if the cell is contracted, remove the detailLabel from the view in order to not calculate this into the new cell height
            cell.removeDetailLabel()
        }

        tableView.invalidateIntrinsicContentSize()
        tableView.layoutIfNeeded()

        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        // if the cell is already expanded, remove it from the indexset to contract it
        if expandedCellSet.contains(indexPath.row) {
            expandedCellSet.remove(indexPath.row)
        } else {
            // if the cell is not expanded, add it to the indexset to expand it
            expandedCellSet.insert(indexPath.row)
        }

        // this will call cellForRowAt to update the cell's movie title and description
        tableView.reloadData()
    }
}
