//
//  GestureSubscriber.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/05/20.
//

import UIKit
import Combine

class GestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {
    private var subscriber: S?
    private var gestureType: GestureType
    private var view: UIView
    init(subscriber: S, view: UIView, gestureType: GestureType) {
        self.subscriber = subscriber
        self.view = view
        self.gestureType = gestureType
        configureGesture(gestureType)
    }
    private func configureGesture(_ gestureType: GestureType) {
        let gesture = gestureType.get()
        gesture.addTarget(self, action: #selector(handler))
        view.addGestureRecognizer(gesture)
    }
    func request(_ demand: Subscribers.Demand) { }
    func cancel() {
        subscriber = nil
    }
    @objc
    private func handler() {
        _ = subscriber?.receive(gestureType)
    }
}
