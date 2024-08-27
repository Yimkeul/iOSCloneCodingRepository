//
//  DataManager.swift
//  RecommandMenu
//
//  Created by yimkeul on 2023/03/02.
//

import SwiftUI
import Firebase

class DataManager : ObservableObject{
    @Published var menus : [Menu] = []
    
    init(){
        fetchData()
    }
    
    func fetchData() {
        menus.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("menus")
        ref.getDocuments { snapshot, error in
            guard error == nil
            else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    print(data)
                    
                    let id = data["id"] as? Int ?? 9999
                    let name = data["name"] as? String ?? ""
                    
                    let menu = Menu(id: id, name: name)
                    self.menus.append(menu)
                }
            }
        }
    }
}
