//
//  LottiesBottom.swift
//  Example
//
//  Created by Christopher G Prince on 9/23/17.
//  Copyright © 2017 Spastic Muffin, LLC. All rights reserved.
//

import Foundation
import UIKit
import Lottie

public class LottiesBottom : UIView {
    private weak var scrollView: UIScrollView!
    private var animationView:LOTAnimationView!
    
    public var completionThreshold: Float = 1.0 {
        didSet {
            assert(completionThreshold > 0.0 && completionThreshold <= 1.0)
        }
    }
    
    public var animating = true
    
    private let top:CGFloat = 100
    private var lastOffset:CGFloat = 0
    
    private enum Direction {
    case up
    case down
    case none
    }
    
    private var direction:Direction = .none
    private var animationFullSize: (()->())?
    private var animationToFullSizeFinished = false
    
    // Adds LottiesBottom as a subview of the scroll view parent at the bottom center of the parent view, and animates it as the user drags up from the bottom.
    public init(useLottieJSONFileWithName name: String, withSize size: CGSize, scrollView: UIScrollView, scrollViewParent parent: UIView, animationFullSize: (()->())? = nil) {
        
        self.scrollView = scrollView
        self.animationFullSize = animationFullSize
        
        animationView = LOTAnimationView(name: name)
        var myFrame = CGRect.zero
        myFrame.size = size
        animationView.frame = myFrame
        animationView.contentMode = .scaleAspectFill
        
        myFrame.origin.y = scrollView.frame.maxY - size.height
        super.init(frame: myFrame)
        
        // So this animation is transparent to touches
        isUserInteractionEnabled = false
        
        addSubview(animationView)
        setNeedsLayout()
        
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: nil)
        
        parent.addSubview(self)
        self.center.x = parent.center.x
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect.zero)
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if animating {
            scrollViewDidScroll(scrollView)
        }
    }
    
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        let offset = bottomEdge - scrollView.contentSize.height
        
        if offset > lastOffset {
            direction = .up
        }
        else if offset < lastOffset {
            direction = .down
        }
        else {
            direction = .none
        }
        
        lastOffset = offset
        
        var position: CGFloat = 0
        if offset > 0 {
            position = min(1.0, offset/top)
        }
        
        print("offset: \(position)")
        let currProgress = animationView.animationProgress
        print("offset: \(position); progress: \(currProgress); direction: \(direction)")

        if currProgress >= CGFloat(completionThreshold) {
            if !animationToFullSizeFinished {
                animationFullSize?()
                animationToFullSizeFinished = true
            }
        }
        else {
            animationToFullSizeFinished = false
        }
        
        if position > currProgress && direction == .up {
            if !animationView.isAnimationPlaying {
                // Need to play animation forward.
                animationView.play(fromProgress: currProgress, toProgress: position, withCompletion: nil)
                print("Playing forward from \(currProgress) to \(position)")
            }
        } else if position < currProgress && direction == .down {
            if !animationView.isAnimationPlaying {
                // Need to play animation backward.
                animationView.play(fromProgress: currProgress, toProgress: position, withCompletion: nil)
                print("Playing backward to \(position)")
            }
        }
    }
    
    public func hide() {
        if animating {
            if !animationView.isAnimationPlaying && animationView.animationProgress > 0 {
                animationView.play(toProgress: 0, withCompletion: nil)
            }
        }
        else {
            animationView.play(fromProgress: 0, toProgress: 0, withCompletion: nil)
        }
    }
}

