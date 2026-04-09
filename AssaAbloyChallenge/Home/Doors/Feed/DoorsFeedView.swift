//
//  DoorsFeedView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

struct DoorDisplayModel: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
}

protocol DoorsFeedViewModelProtocol: AnyObject, Observable {
    var isLoading: Bool { get }
    var isLoadingMore: Bool { get }
    var errorMessage: String? { get }
    var doors: [DoorDisplayModel] { get }
    var filteredDoors: [DoorDisplayModel] { get }
    var searchText: String { get set }
    func selectedDoor(doorId: Int)
    func viewAppeared()
    func loadMoreIfNeeded(currentDoor: DoorDisplayModel)
}

struct DoorsFeedView<ViewModel: DoorsFeedViewModelProtocol>: View {

    @State var viewModel: ViewModel

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMessage, !error.isEmpty {
            Text(error).foregroundStyle(Color.red)
        } else {
            List {
                ForEach(viewModel.filteredDoors) { door in
                    DoorItemView(id: door.id, title: door.title, subtitle: door.subtitle) { id in
                        viewModel.selectedDoor(doorId: id)
                    }
                    .onAppear {
                        viewModel.loadMoreIfNeeded(currentDoor: door)
                    }
                }
                if viewModel.isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .searchable(text: Binding(
                get: { viewModel.searchText },
                set: { viewModel.searchText = $0 }
            ), prompt: "Search doors")
            .onAppear {
                viewModel.viewAppeared()
            }
        }
    }
}

@Observable fileprivate final class DoorsFeedMockViewModel: DoorsFeedViewModelProtocol {
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    var errorMessage: String? = nil
    var searchText: String = ""
    var doors: [DoorDisplayModel] = [
        DoorDisplayModel(id: 1, title: "Outside Door", subtitle: "closed at 12:21"),
        DoorDisplayModel(id: 2, title: "Backyard Door", subtitle: "closed yesterday at 12:22"),
        DoorDisplayModel(id: 3, title: "Bedroom Door", subtitle: "opened at 07:00 this morning")
    ]
    var filteredDoors: [DoorDisplayModel] {
        guard !searchText.isEmpty else { return doors }
        return doors.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    func selectedDoor(doorId: Int) { debugPrint("Selected door with id: \(doorId)") }
    func viewAppeared() {}
    func loadMoreIfNeeded(currentDoor: DoorDisplayModel) {}
}

#Preview {
    DoorsFeedView(viewModel: DoorsFeedMockViewModel())
}

