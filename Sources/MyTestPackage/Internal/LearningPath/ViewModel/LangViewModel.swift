//
//  LangViewModel.swift
//  ABOAcademy
//
//  Created by Swapnil Tilkari on 02/03/22.
//

import Foundation

class LangViewModel : ObservableObject {

var LangArr = ["English","Chineese","Japneese","Spanish","Russian"]
@Published var showLangView : Bool = false
@Published var selectedLang : String = "English"
    
static var shared = LangViewModel()
    
private init(){
        
    }

}
