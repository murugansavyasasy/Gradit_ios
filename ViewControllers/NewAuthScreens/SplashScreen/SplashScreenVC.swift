//
//  SplashScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

class SplashScreenVC: UIViewController {
    
    @IBOutlet weak var ellipsisImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateEllipsisColor()
    }
    
    func animateEllipsisColor() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.ellipsisImage.tintColor = .systemBlue
        }, completion: nil)
    }

}

@IBDesignable
final class CurveView: UIView {

    @IBInspectable var curveHeight: CGFloat = 80 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var lineColor: UIColor = .systemPink {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var fillColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    private let shapeLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {

        backgroundColor = .clear

        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shapeLayer.frame = bounds

        let width = bounds.width
        let height = bounds.height

        let path = UIBezierPath()

        // MARK: - TOP CURVE

        let topY = curveHeight

        path.move(
            to: CGPoint(
                x: 0,
                y: topY
            )
        )

        path.addCurve(
            to: CGPoint(
                x: width,
                y: topY
            ),
            controlPoint1: CGPoint(
                x: width * 0.25,
                y: topY - curveHeight
            ),
            controlPoint2: CGPoint(
                x: width * 0.75,
                y: topY - curveHeight
            )
        )

        // MARK: - RIGHT SIDE

        path.addLine(
            to: CGPoint(
                x: width,
                y: height - curveHeight
            )
        )

        // MARK: - BOTTOM CURVE

        path.addCurve(
            to: CGPoint(
                x: 0,
                y: height - curveHeight
            ),
            controlPoint1: CGPoint(
                x: width * 0.75,
                y: height - curveHeight + curveHeight
            ),
            controlPoint2: CGPoint(
                x: width * 0.25,
                y: height - curveHeight + curveHeight
            )
        )

        // MARK: - LEFT SIDE

        path.close()

        shapeLayer.path = path.cgPath

        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
    }
}
