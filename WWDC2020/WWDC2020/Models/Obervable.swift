//
//  Obervable.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 18/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation
import SpriteKit
//
//public class Observable<T>: ObservableProtocol{
//    
//    
//    public var observers: [ObserverProtocol] = []
//    
//   
//    public func addObserver(_ observer: ObserverProtocol) {
//        guard observers.contains(where: { !($0.id == observer.id)}) else {return}
//        observers.append(observer)
//    }
//    
//    public func removeObserver(_ observer: ObserverProtocol) {
//        guard let index = observers.firstIndex(where: {$0.id == observer.id}) else {return}
//        observers.remove(at: index)
//    }
//    
//    public func notifyObservers(_ observers: [ObserverProtocol]) {
//        observers.forEach({$0.onValueChanged()})
//    }
//    
//    deinit {
//        observers.removeAll()
//    }
//    
//}
