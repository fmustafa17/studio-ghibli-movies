//
//  ViewController.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var networkLayer = NetworkLayer.shared
    var movies: [StudioGhibliMovie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // this will contain the index of the row (integer) that is expanded
    var expandedIndexSet: IndexSet = []

    override func viewDidLoad() {
        super.viewDidLoad()
        networkLayer.fetchMovies(successHandler: { [weak self] (movies) in
            self?.movies = movies
        }) { (error) in
            print(error)
        }
        // For removing the extra empty spaces of TableView below
        tableView.tableFooterView = UIView()
        tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.identifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: MovieTableCell.identifier, for: indexPath) as? MovieTableCell)!
        cell.updateData(model: movies[indexPath.row])

        // if the cell is expanded
        if expandedIndexSet.contains(indexPath.row) {
            // Add the detail label and add the constraints to the cell
            cell.addDetailLabel()
            cell.movieDescriptionLabel.text = movies[indexPath.row].studioGhibliMovieDescription
        } else {
          // if the cell is contracted, remove the detailLabel from the view in order to not calculate this into the new cell height
            cell.removeDetailLabel()
        }

        tableView.invalidateIntrinsicContentSize()
        tableView.layoutIfNeeded()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                tableView.beginUpdates()
                movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
                tableView.endUpdates()
            }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

            // if the cell is already expanded, remove it from the indexset to contract it
            if expandedIndexSet.contains(indexPath.row) {
                expandedIndexSet.remove(indexPath.row)
            } else {
                // if the cell is not expanded, add it to the indexset to expand it
                expandedIndexSet.insert(indexPath.row)
            }

            // this will call cellForRowAt to update the cell's image and detailLabel
            tableView.reloadData()

//            tableView.beginUpdates()
//            tableView.endUpdates()
//            tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == selectedRowIndex {
//            if dateCellExpanded {
//                return 280
//            }
//        }
//        return 50
//    }
}
