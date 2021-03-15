//
//  Observable.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

public final class Observable<Value> {
  
  struct Observer<Value> {
    weak var observer: AnyObject?
    let block: (Value) -> Void
  }
  
  private var observers = [Observer<Value>]()
  
  public var value: Value {
    didSet {
      notifyObservers()
    }
  }
  
  public init(value: Value) {
    self.value = value
  }
  
  public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
    observers.append(Observer(observer: observer, block: observerBlock))
  }
  
  public func remove(observer: AnyObject) {
    observers = observers.filter { $0.observer !== observer }
  }
  
  private func notifyObservers() {
    for observer in observers {
      DispatchQueue.main.async {
        observer.block(self.value)
      }
    }
  }
}
