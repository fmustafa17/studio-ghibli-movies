//
//  ViewController.swift
//  Studio Ghibli API
//
//  Created by Farhana Mustafa on 2/3/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var networkLayer = APIManager.shared
    var movies: [StudioGhibliMovie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // this will contain the index of the row (integer) that is expanded
    var expandedCellSet: IndexSet = []

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
        tableView.estimatedRowHeight = 100.0
    }

//    var expandedRow: (indexPath: IndexPath, height: CGFloat)? = nil
//    var collapsingRow: (indexPath: IndexPath, height: CGFloat)? = nil
//
//
//        override func numberOfSections(in tableView: UITableView) -> Int {
//            return 1
//        }
//
//
//
//        override func tableView(_ tableView: UITableView,
//                                heightForRowAt indexPath: IndexPath) -> CGFloat {
//            if indexPath == collapsingRow?.indexPath {
//                return collapsingRow!.height
//            } else {
//                return UITableView.automaticDimension
//            }
//        }
//
//        override func tableView(_ tableView: UITableView,
//                                didSelectRowAt indexPath: IndexPath) {
//            guard let tappedCell = tableView.cellForRow(at: indexPath) as? MyTableViewCell
//                else { return }
//
//            CATransaction.begin()
//            tableView.beginUpdates()
//
//            if let expandedRow = expandedRow,
//                let prevCell = tableView.cellForRow(at: expandedRow.indexPath)
//                    as? MyTableViewCell {
//                prevCell.heightConstraint.constant = prevCell.stackView.frame.height
//                prevCell.heightConstraint.isActive = true
//
//                CATransaction.setCompletionBlock {
//                    if let cell = tableView.cellForRow(at: expandedRow.indexPath)
//                        as? MyTableViewCell {
//                        cell.configureExpansion(false)
//                        cell.heightConstraint.isActive = false
//                    }
//                    self.collapsingRow = nil
//                }
//
//                collapsingRow = expandedRow
//            }
//
//
//            if expandedRow?.indexPath == indexPath {
//                collapsingRow = expandedRow
//                expandedRow = nil
//            } else {
//                tappedCell.configureExpansion(true)
//                expandedRow = (indexPath: indexPath, height: tappedCell.frame.height)
//            }
//
//            tableView.endUpdates()
//            CATransaction.commit()
//        }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: MovieTableCell.identifier, for: indexPath) as? MovieTableCell)!
        cell.updateData(model: movies[indexPath.row])

//        let post = posts[indexPath.row]
//        let isExpanded = expandedRow?.indexPath == indexPath
//        cell.configure(expanded: isExpanded, post: post)

        // if the cell is expanded
        if expandedCellSet.contains(indexPath.row) {
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
        if expandedCellSet.contains(indexPath.row) {
            expandedCellSet.remove(indexPath.row)
        } else {
            // if the cell is not expanded, add it to the indexset to expand it
            expandedCellSet.insert(indexPath.row)
        }

        // this will call cellForRowAt to update the cell's image and detailLabel
        tableView.reloadData()

//        tableView.beginUpdates()
//        tableView.endUpdates()
    }
}
