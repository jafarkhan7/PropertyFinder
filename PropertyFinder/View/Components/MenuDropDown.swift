struct MenuDropDown<Content: View>: View {
    let menuItem: [String]
    let labelContent: Content
    @Binding var selectedIndex: Int

    init(menuItem: [String], selectedIndex: Binding<Int>, @ViewBuilder labelContent: () -> Content) {
        self.menuItem = menuItem
        self._selectedIndex = selectedIndex
        self.labelContent = labelContent()
    }
    
    var body: some View {

        Menu(content: {
            ForEach(menuItem.indices, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    HStack {
                        Text(menuItem[index])
                        if selectedIndex == index {
                            Image(systemName: "checkmark") // Checkmark icon
                                .foregroundColor(.blue) // Change color if selected
                        }
                    }
                }
            }
            
        }, label: {
            labelContent
        })

        
    }
}