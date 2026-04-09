//
//  DoorsFeedViewModel.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

@Observable
final class DoorsFeedViewModel: DoorsFeedViewModelProtocol {
    
    // MARK: Depedencies
    var doorsService: DoorsFetchService
    
    // MARK: Callbacks
    var onDoorSelected: ((Int) -> Void)?
    
    // MARK: View
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    var errorMessage: String? = nil
    var doors: [DoorDisplayModel] = []
    var searchText: String = ""

    private var currentPage: Int = 0
    private var isLastPage: Bool = false
    private let pageSize: Int = 20

    var filteredDoors: [DoorDisplayModel] {
        guard !searchText.isEmpty else { return doors }
        return doors.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    
    init(doorsService: DoorsFetchService) {
        self.doorsService = doorsService
    }
    
    func selectedDoor(doorId: Int) {
        onDoorSelected?(doorId)
    }
    
    func viewAppeared() {
        guard doors.isEmpty else { return }
        fetchPage(0)
    }

    func loadMoreIfNeeded(currentDoor: DoorDisplayModel) {
        guard !isLoadingMore, !isLastPage, searchText.isEmpty else { return }
        guard currentDoor.id == doors.last?.id else { return }
        fetchPage(currentPage + 1)
    }

    private func fetchPage(_ page: Int) {
        let isFirstPage = page == 0
        if isFirstPage {
            isLoading = true
        } else {
            isLoadingMore = true
        }
        errorMessage = nil
        
        doorsService.fetchDoors(page: page, size: pageSize) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let newDoors = response.content.map(self.displayModel)
                if isFirstPage {
                    self.doors = newDoors
                } else {
                    self.doors += newDoors
                }
                self.currentPage = page
                self.isLastPage = response.last
            case .failure:
                if isFirstPage { self.errorMessage = "Failed fetching doors. Please try again." }
            }
            if isFirstPage {
                self.isLoading = false
            } else {
                self.isLoadingMore = false
            }
        }
    }
    
    func displayModel(_ door: Door) -> DoorDisplayModel {
        let subtitle = "Battery Level: \(door.battery)% \n\(door.address)"
        return .init(id: door.id, title: door.name, subtitle: subtitle)
    }
}
