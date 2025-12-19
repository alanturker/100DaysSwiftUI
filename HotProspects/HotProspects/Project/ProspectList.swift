//
//  ProspectList.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI
import SwiftData

struct ProspectList: View {
    @Query private var prospects: [Prospect]
    let filter: FilterType
    @Binding var selectedProspects: Set<Prospect>
    @Environment(\.modelContext) var modelContext
    
    init(filter: FilterType, sortOrder: [SortDescriptor<Prospect>], selectedProspects: Binding<Set<Prospect>>) {
        self.filter = filter
        _selectedProspects = selectedProspects
        let showContactedOnly = filter == .contacted
        
        switch filter {
        case .none:
            _prospects = Query(sort: sortOrder)
        case .contacted:
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        case .uncontacted:
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        }
    }
    
    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                EditProspectView(prospect: prospect) { updatedProspect in
                    update(prospect: updatedProspect)
                }
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text(prospect.createdAt, format: .dateTime)
                        .font(.caption)
                    
                    if filter == .none {
                        Image(systemName: prospect.isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark" )
                    }
                }
            }
            .swipeActions(edge: .leading) {
                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
            }
            .tag(prospect)
        }
    }
    
    func update(prospect: Prospect) {
        guard let selectedProspect = selectedProspects.first else { return }
        modelContext.delete(selectedProspect)
        modelContext.insert(prospect)
        selectedProspects.removeAll()
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            ///testing purposes
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectList(filter: .none, sortOrder: [SortDescriptor(\Prospect.name)], selectedProspects: .constant(Set(Array(_immutableCocoaArray: Prospect(name: "", emailAddress: "", isContacted: false)))))
}
