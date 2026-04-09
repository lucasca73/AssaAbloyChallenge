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
    var pagination: Int = 0
    var size: Int = 0
    
    
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
        
        doorsService.fetchDoors(page: 0, size: 20) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let doorsResponse):
                self.doors = doorsResponse.content.map(self.displayModel)
            case .failure:
                self.errorMessage = "Failed fetching doors. Please try again."
                break
            }
            self.isLoading = false
        }
    }
    
    func displayModel(_ door: Door) -> DoorDisplayModel {
        let subtitle = "Battery Level: \(door.battery)% \n\(door.address)"
        return .init(id: door.id, title: door.name, subtitle: subtitle)
    }
}
