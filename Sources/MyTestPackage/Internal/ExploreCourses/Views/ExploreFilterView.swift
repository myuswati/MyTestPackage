//
//  ExploreFilterView.swift
//  ABOAcademy
//
//  Created by Shrinivas Reddy on 09/03/22.
//

import SwiftUI

@available(iOS 15.0, *)
@available(iOS 15.0, *)
struct ExploreFilterView: View {
        
    @StateObject var FilterData : ExploreFilterVM = ExploreFilterVM.shared

    @State var selectedFilter : [SubCategory] = []
    
    var applyFilterAction : ((_ appliedFilters: [SubCategory]) -> Void)?
    var cancelAction : (() -> Void)?
    
    init(applyFilterAction: @escaping (_ appliedFilters: [SubCategory]) -> (), cancelAction: @escaping () -> ()) {
        self.applyFilterAction = applyFilterAction
        self.cancelAction = cancelAction
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 0) {
                Text("Filters")
                    .font(.getCustomFontWithSize(fontType: .gt_walsheim_medium, fontSize: .vlargemid))
                Spacer()
                Button {
                    //Clear all applied filters
                    FilterData.clearAllFilterState()
                } label: {
                    HStack {
                        Text("Clear All")
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                        .foregroundColor(.darkPurple)
                        Image("CloseIcon", bundle: PackageManager.bundle)
                    }
                }
            }
            .padding(.top, 0)
            .padding(.bottom, 20)
            .padding(.leading, 16)
            .padding(.trailing, 25)
            
            Divider()
                .frame(height: 1)
            
            VStack {
                
                HStack {

                    VStack(alignment: .leading, spacing: 0) {

                        ScrollView {
                            //Show Category filter
                            ForEach(0..<FilterData.exploreFilters.count, id:\.self) { index in

                                HStack {

                                    Button(action: {
                                        FilterData.setSelectedCategoryIndex(index: index)
                                    }, label: {

                                        Text(FilterData.exploreFilters[index].category)
                                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                                            .foregroundColor(.amwayBlack)
                                    })
                                    .fixedSize()
                                    .frame(height: 42)
                                    .padding([.leading, .trailing], 16)
                                    Spacer()
                                }
                                .background(index == FilterData.selectedCategoryIndex ? Color.white : Color.lightGray)
                            }
                        }
                    }
                    .padding([.top, .bottom], 12)
                    .background(Color.lightGray)
                    .frame(width: UIScreen.main.bounds.width / 2.5)

                    VStack(alignment: .leading, spacing: 0) {
                        
                        ScrollView {

                            VStack(spacing: 22) {
                                //Show subcategories for selected category filter
                                ForEach(0..<FilterData.exploreFilters[FilterData.selectedCategoryIndex].subCategory.count, id:\.self) { i in

                                        CheckboxField(subcategoryFilter: $FilterData.exploreFilters[FilterData.selectedCategoryIndex].subCategory[i], callback: checkboxSelected)
                                            .padding([.leading, .trailing], 16)
                                    }
                            }
                            .padding([.top, .bottom], 23)
                        }

                    }
                }
            }

            VStack {

                HStack(alignment: .center, spacing: 0) {

                    Button(action: {

                        if let cancelAction = cancelAction {
                            cancelAction()
                        }
                    }, label: {

                        Text("Cancel")
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                            .foregroundColor(.amwayBlack)
                    })
                    .fixedSize()
                    .frame(width: 120, height: 36)
                    .padding(.horizontal, 10)
                    .background()
                    .clipShape(Capsule())
                    .customRoundedRectangleOverlay(cornerRadius: 50, color: .amwayBlack, lineWidth: 2.0)

                    Spacer()

                    Button(action: {

                        if let applyFilterAction = applyFilterAction {
                            applyFilterAction(self.selectedFilter)
                        }
                    }, label: {

                        Text("Apply Filters")
                            .font(.getCustomFontWithSize(fontType: .gt_walsheim_bold, fontSize: .regular))
                            .foregroundColor(.white)
                    })
                    .fixedSize()
                    .frame(width: 211, height: 36)
                    .padding(.horizontal, 10)
                    .background(Color.amwayBlack)
                    .clipShape(Capsule())
                    .customRoundedRectangleOverlay(cornerRadius: 50, color: .amwayBlack, lineWidth: 2.0)

                }
                .background(.white)
                .padding()
            }
            .frame(height: 68)
            .background(
                Color.white
                    .shadow(color: .amwayBlack, radius: 6, x: 0, y: 0)
                    .mask(Rectangle()
                            .padding(.top, -20)
                            .opacity(0.2))
            )
        }
        .onAppear() {
            if FilterData.exploreFilters.count > 0 {
                
                FilterData.saveSelectedCategory(categoryFilter: FilterData.exploreFilters[0].category)
                FilterData.setSelectedCategoryIndex(index: 0)
            }
            FilterData.appliedFilterState()
        }
        .onDisappear() {
            FilterData.cancelFilterState()
        }
    }
    
    
    func checkboxSelected(clickedFilter: SubCategory) {
        
        
//        print("Filters", FilterData.exploreFilters)
//        
//        if clickedFilter.isMarked {
//            
//            selectedFilter.append(clickedFilter)
//        } else {
//            
//            let index = selectedFilter.firstIndex{$0.id == clickedFilter.id}
//            if index != nil {
//                
//                selectedFilter.remove(at: index!)
//            }
//        }
    }
}

