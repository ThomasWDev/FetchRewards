//
//  EventSearchViewController.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import UIKit

enum State {
    case start
    case empty
    case loading
    case events
}

protocol EventSearchViewControllerDelegate: class {
    
    func didSelectEvent(event: Event)
}

class EventSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private let appConfiguration: AppConfiguration
    private let searchController: UISearchController
    private let eventSearchViewModel: EventSearchViewModel

    private var events : [Event] = []
    private var selectedEvent: Event?
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
        self.eventSearchViewModel = EventSearchViewModel(appConfiguration: appConfiguration)
        searchController = UISearchController(searchResultsController: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureUI() {
        self.eventSearchViewModel.delegate = self
        title = NSLocalizedString("Fetch Rewards", comment: "")
        extendedLayoutIncludesOpaqueBars = true
        
        tableView.register(UINib(nibName: String(describing: EventSearchCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EventSearchCell.self))
        tableView.keyboardDismissMode = .onDrag
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search Events", comment: "")
        searchController.searchBar.tintColor = UIColor(named: "searchBarTint")
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor(named: "searchBarText") ?? .white]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        setViewState(state: .start)
    }
    
    func setViewState(state: State) {
        switch state {
        case .start:
            tableView.isHidden = true
            loadingIndicator.isHidden = true
            actionLabel.isHidden = false
            actionLabel.text = NSLocalizedString("Welcome to Fetch Rewards", comment: "")
        case .loading:
            tableView.isHidden = true
            loadingIndicator.isHidden = false
            actionLabel.isHidden = true
        case .empty:
            tableView.isHidden = true
            loadingIndicator.isHidden = true
            actionLabel.isHidden = false
            actionLabel.text = NSLocalizedString("No events found :(", comment: "")
        case .events:
            tableView.isHidden = false
            loadingIndicator.isHidden = true
            actionLabel.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource

extension EventSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventSearchCell.self), for: indexPath) as? EventSearchCell {
            let event = events[indexPath.row]
            cell.configureData(event: event, isFavorite: appConfiguration.eventRepository.isFavorite(event: event))
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension EventSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let eventDetailViewController = EventDetailViewController(appConfiguration: appConfiguration, event: events[indexPath.row])
        self.navigationController?.pushViewController(eventDetailViewController, animated: true)
    }
}

// MARK: - EventSearchView

extension EventSearchViewController: EventSearchViewModelDelegate {
    
    func setState(state: State) {
        setViewState(state: state)
    }
    
    func setEvents(events: [Event]) {
        self.events = events
        tableView.reloadData()
    }
    
    func showMessage(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating

extension EventSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        eventSearchViewModel.queryEvents(query: searchController.searchBar.text)
    }
}
