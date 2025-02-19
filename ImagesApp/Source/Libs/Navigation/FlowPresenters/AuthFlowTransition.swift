//
//  CustomPushTransition.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2025.
//

import UIKit

class AuthFlowTransition: NSObject, NavigationCoordinatorAnimatorType {
    
    // MARK: -
    // MARK: Variables
    
    private let duration: TimeInterval = 0.5
    
    // MARK: -
    // MARK: UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        
        let bounds = containerView.bounds
        containerView.addSubview(toView)
        toView.frame = bounds

        let width = fromView.frame.width
        
        let sortedSubviews = fromView.subviews.sorted { $0.frame.minY < $1.frame.minY }
        
        var frames: [CGRect] = []
        var previousMaxY: CGFloat = 0

        for subview in sortedSubviews {
            let midY = (previousMaxY + subview.frame.minY) / 2
            let height = subview.frame.maxY - midY
            let frame = CGRect(x: 0, y: midY, width: fromView.frame.width, height: height)
            frames.append(frame)
            previousMaxY = subview.frame.maxY
        }

        if let lastSubview = sortedSubviews.last {
            let frame = CGRect(x: 0, y: lastSubview.frame.maxY, width: fromView.frame.width, height: fromView.frame.maxY - lastSubview.frame.maxY)
            frames.append(frame)
        }
        
        let views: [UIView?] = frames.map { frame in
            return fromView.resizableSnapshotView(from: frame, afterScreenUpdates: false, withCapInsets: .zero)
        }
        
        zip(views, frames).forEach { view, frame in
            guard let view = view else { return }
            view.frame = frame.offsetBy(dx: 0, dy: 0)
            containerView.addSubview(view)
        }
        
        views.enumerated().forEach { index, view in
            let delay = TimeInterval(index) * 0.2
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: duration,
                delay: delay,
                options: [.curveEaseInOut, .allowUserInteraction]
            ) {
                view?.frame.origin.x = -width
            }
        }
        
        let finished = !transitionContext.transitionWasCancelled
        transitionContext.completeTransition(finished)
    }
}
