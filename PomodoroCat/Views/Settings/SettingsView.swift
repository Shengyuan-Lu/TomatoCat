import SwiftUI

struct SettingsView: View {
    
    // MARK: - Variable
    @Environment(\.presentationMode) var presentationMode
    
    // 0 = default, 1 = light, 2 = dark
    @AppStorage("themeIndex") private var themeIndex = 1
    
    @AppStorage("work") private var work = 25
    @AppStorage("shortRest") private var shortRest = 5
    @AppStorage("longRest") private var longRest = 15
    @AppStorage("numOfSection") private var numOfSection = 4
    
    @ObservedObject var taskManager:TaskManager
    
    // MARK: - View
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            // Form
            Form {
                
                // Timer Section
//                Section(header: Text("Timer")) {
//
//                    NavigationLink(
//                        destination: TimerPickerView(bindingNum: $work, selectionIndex: (work - 10), lowerBound: 10, upperBound: 60, unit: "Minutes"),
//                        label: {
//                            SettingsRowTypeAbout(iconName: "hammer.fill", iconColor: Color.tomato, firstText: "Work", secondText: "\(work) Minutes")
//                                .padding(.vertical, 3)
//                        }).id(UUID())
//
//                    NavigationLink(
//                        destination: TimerPickerView(bindingNum: $shortRest, selectionIndex: (shortRest - 5), lowerBound: 5, upperBound: 30, unit: "Minutes"),
//                        label: {
//                            SettingsRowTypeAbout(iconName: "die.face.3.fill", iconColor: Color.tomato, firstText: "Short Break", secondText: "\(shortRest) Minutes")
//                                .padding(.vertical, 3)
//                        }).id(UUID())
//
//                    NavigationLink(
//                        destination: TimerPickerView(bindingNum: $longRest, selectionIndex: (longRest - 15), lowerBound: 15, upperBound: 90, unit: "Minutes"),
//                        label: {
//                            SettingsRowTypeAbout(iconName: "bed.double.fill", iconColor: Color.tomato, firstText: "Long Break", secondText: "\(longRest) Minutes")
//                                .padding(.vertical, 3)
//                        }).id(UUID())
//
//                    NavigationLink(
//                        destination: TimerPickerView(bindingNum: $numOfSection, selectionIndex: (numOfSection - 2), lowerBound: 2, upperBound: 10, unit: "Sections"),
//                        label: {
//                            SettingsRowTypeAbout(iconName: "rectangle.stack", iconColor: Color.tomato, firstText: "Sections", secondText:"\(numOfSection)")
//                                .padding(.vertical, 3)
//                        }).id(UUID())
//
//                }
                
                // Theme Section
                Section(header: Text("Theme")) {
                    Picker(LocalizedStringKey("Theme"), selection: $themeIndex) {
                        Text("Light").tag(0)
                        Text("Dark").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .id(UUID())
                    
                }
                
                // Developer Section
                Section(header: Text("Developers")) {
                    
                    NavigationLink(
                        destination: GeniusView(),
                        label: {
                            SettingsRowTypeAbout(iconName: "person.fill", iconColor: Color.pink, firstText: "Developers", secondText: "Stanford Rejects")
                                .padding(.vertical, 3)
                        }).id(UUID())
                }
                
                // About Section
                Section(header: Text("About")) {
                    SettingsRowTypeAbout(iconName: "apps.iphone", iconColor: Color.blue, firstText: "Application", secondText: "PomodoroCat")
                    SettingsRowTypeAbout(iconName: "checkmark.circle.fill", iconColor: Color.green, firstText: "Compatibility", secondText: "iPhone")
                    SettingsRowTypeAbout(iconName: "swift", iconColor: Color.orange, firstText: "Programming Language", secondText: "Swift")
                    SettingsRowTypeAbout(iconName: "flag", iconColor: Color.red, firstText: "App Version", secondText: "\(AppVersion.version!)")
                }
                .padding(.vertical, 3)
                
                // Link Section
                Section(header: Text("Links")) {
                    SettingsRowTypeLink(iconName: "globe", iconColor: Color.purple, text: "Developer Website", link: "https://www.google.com")
                    SettingsRowTypeLink(iconName: "hand.raised.fill", iconColor: Color.gray, text: "Privacy Policy", link: "https://www.google.com")
                }
                .padding(.vertical, 3)

                
                
                // Footer
                HStack {
                    Spacer()
                    Text("Made with ♡ and boba in Irvine, California")
                        .padding(.vertical, 10)
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .edgesIgnoringSafeArea(.all)
            
            
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        // Hide the system back button
        .navigationBarBackButtonHidden(true)
        // Add your custom back button here
        .navigationBarItems(leading:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.left.circle.fill")
                                        Text("Back")
                                    }
                                })
        .onChange(of: work, perform: { value in
            taskManager.task = Task(workSeconds: work, shortRelaxSeconds: shortRest, longRelaxSeconds: longRest, numOfSections: numOfSection)
            taskManager.resetTimer()
        })
        .onChange(of: shortRest, perform: { value in
            taskManager.task = Task(workSeconds: work, shortRelaxSeconds: shortRest, longRelaxSeconds: longRest, numOfSections: numOfSection)
            taskManager.resetTimer()
        })
        
        .onChange(of: longRest, perform: { value in
            taskManager.task = Task(workSeconds: work, shortRelaxSeconds: shortRest, longRelaxSeconds: longRest, numOfSections: numOfSection)
            taskManager.resetTimer()
        })
        .onChange(of: numOfSection, perform: { value in
            taskManager.task = Task(workSeconds: work, shortRelaxSeconds: shortRest, longRelaxSeconds: longRest, numOfSections: numOfSection)
            taskManager.resetTimer()
        })
        
    }
    
}

// MARK: - Preview
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(taskManager: TaskManager())
    }
}
