//
//  ViewController.swift
//  fb-stream-animation
//
//  Created by Олег В. Твердохлеб on 05/05/2018.
//  Copyright © 2018 oltv00. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    private var curvedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .yellow
        view.addSubview(curvedView)
        self.curvedView = curvedView

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        self.curvedView.removeFromSuperview()

        let curvedView = CurvedView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        curvedView.backgroundColor = .yellow
        view.addSubview(curvedView)
        self.curvedView = curvedView
    }

    @objc
    private func handleTap() {
        (0..<10).forEach { _ in makeAnimation() }
    }

    private func makeAnimation() {
        let imageName = arc4random_uniform(100) % 2 == 0 ? "thumbs_up" : "heart"
        let imageView = UIImageView(image: UIImage(named: imageName))
        let dimension = 25 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = makePath(frame: view.bounds).cgPath
        let duration = 2 + drand48() * 3
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            imageView.removeFromSuperview()
        }
    }
}

func makePath(frame: CGRect) -> UIBezierPath {

    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))

    let endPoint = CGPoint(x: frame.width, y: frame.height / 2)

    let randomYShift = drand48() * 300
    let randomXShift = arc4random_uniform(50)
    let sign_cp1_x = arc4random_uniform(100) % 2 == 0 ? true : false
    let sign_cp2_x = arc4random_uniform(100) % 2 == 0 ? true : false

    let cp1_x = Double(sign_cp1_x ? 100 + randomXShift : 100 - randomXShift)
    let cp2_x = Double(sign_cp2_x ? 200 + randomXShift : 200 - randomXShift)

    let cp1 = CGPoint(x: cp1_x, y: 100 - randomYShift)
    let cp2 = CGPoint(x: cp2_x, y: 300 + randomYShift)

    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        let path = makePath(frame: rect)
        path.lineWidth = 3
        path.stroke()
    }
}
