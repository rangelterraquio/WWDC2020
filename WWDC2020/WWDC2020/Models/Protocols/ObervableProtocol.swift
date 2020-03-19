//
//  ObervableProtocol.swift
//  WWDC2020
//
//  Created by Rangel Cardoso Dias on 18/03/20.
//  Copyright © 2020 Rangel Cardoso Dias. All rights reserved.
//

import Foundation


public protocol ObservableProtocol: class{
    
    
    var id : String { get set }

    var observer: ObserverProtocol? {get set}
    
    func addObserver(_ observer: ObserverProtocol)
    
    //func removeObserver(_ observer: ObserverProtocol)
     func removeObserver() 
    //func notifyObservers(_ observers: [ObserverProtocol])
    func notifyValueObservers() 
    
    func removeAllObservers()
}

extension ObservableProtocol{
        public func addObserver(_ observer: ObserverProtocol) {
//           guard observers.contains(where: { $0.id == observer.id }) == false else {return}
//           observers.append(observer)
            self.observer = observer
       }
       
        public func removeObserver() {
           //guard let index = observers.firstIndex(where: {$0.id == observer.id}) else {return}
           //observers.remove(at: index)
            self.observer = nil
       }
       
       public func notifyValueObservers() {
//        observers.forEach({$0.onValueChanged()})
            self.observer?.onValueChanged()
        }
    
        public func notifyDeathToObservers(nodeID: String) {
            self.observer?.observableNodeHasDied(nodeID: nodeID)
        }
    
        public func removeAllObservers(){
            //observers.removeAll()
        }
}

public protocol ObserverProtocol : class {

    var id : String { get set }
    
    var nodesObserving: [ObservableProtocol] {get set}
       
    func addObservingNode(_ node: ObservableProtocol)
    
    func removeObservingNode(_ nodeID: String)
    
    func removeAllObservers()
    
    func onValueChanged()
    
    func observableNodeHasDied(nodeID: String)
}


extension ObserverProtocol{
    public func addObservingNode(_ node: ObservableProtocol) {
           guard nodesObserving.contains(where: { $0.id == node.id }) == false else {return}
           nodesObserving.append(node)
       }
       
    public func removeObservingNode(_ nodeID: String) {
           guard let index = nodesObserving.firstIndex(where: {$0.id == nodeID}) else {return}
           nodesObserving.remove(at: index)
       }
    
        public func removeAllObservers(){
            nodesObserving.removeAll()
        }
}
