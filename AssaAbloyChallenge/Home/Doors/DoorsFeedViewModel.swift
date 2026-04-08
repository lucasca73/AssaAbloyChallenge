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
    var errorMessage: String? = nil
    var doors: [DoorDisplayModel] = []
    
    
    init(doorsService: DoorsFetchService) {
        self.doorsService = doorsService
    }
    
    func selectedDoor(doorId: Int) {
        onDoorSelected?(doorId)
    }
    
    func viewAppeared() {
        guard doors.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        doorsService.fetchDoors { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let doors):
                self.doors = doors.map(self.displayModel)
            case .failure:
                self.errorMessage = "Failed fetching doors. Please try again."
                break
            }
            self.isLoading = false
        }
    }
    
    func displayModel(_ door: DoorModel) -> DoorDisplayModel {
        let subtitle = door.isOpen ? "last closed at \(door.lastClosed?.description ?? "-:-")" : "last opened at \(door.lastOpened?.description ?? "-:-")"
        return .init(id: door.id, title: door.name, subtitle: subtitle)
    }
}
