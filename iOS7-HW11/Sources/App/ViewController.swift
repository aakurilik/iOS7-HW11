//
//  ViewController.swift
//  iOS7-HW11
//
//  Created by Anatoly Kurilik on 22.08.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Outlets

    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "fonApp")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let shadowRadius: CGFloat = 5
        imageView.layer.shadowRadius = shadowRadius
        imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowColor = UIColor.systemPurple.cgColor

        // how strong to make the curling effect
        let curveAmount: CGFloat = 30
        let shadowPath = UIBezierPath()

        // the top left and right edges match our view, indented by the shadow radius
        let width: CGFloat = 450
        let height: CGFloat = 450
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))

        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))

        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount), controlPoint1: CGPoint(x: width, y: height - shadowRadius), controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        imageView.layer.shadowPath = shadowPath.cgPath

        return imageView
    }()

    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textFieldMail: UITextField = {
        let textFieldMail = UITextField()
        let leftImage = UIImage(systemName: "person.fill")
        let rightImage = UIImage(systemName: "checkmark.circle.fill")
        textFieldMail.placeholder = "keanureeves01"
        textFieldMail.backgroundColor = .white
        textFieldMail.layer.cornerRadius = 25
        if let image = leftImage {
            textFieldMail.setLeftIcon(image)
        }
        if let image = rightImage {
            textFieldMail.setRightIcon(image)
        }
        textFieldMail.translatesAutoresizingMaskIntoConstraints = false
        return textFieldMail
    }()

    private lazy var textFieldPassword: UITextField = {
        let textFieldPassword = UITextField()
        let leftImage = UIImage(systemName: "lock.fill")
        textFieldPassword.placeholder = "Password"
        textFieldPassword.backgroundColor = .white
        textFieldPassword.layer.cornerRadius = 25
        if let image = leftImage {
            textFieldPassword.setLeftIcon(image)
        }
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        return textFieldPassword
    }()

        private lazy var buttonLogin: UIButton = {
            let button = UIButton()
            button.setTitle("Login", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 25
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.5
            button.layer.shadowOffset = .zero
            button.layer.shadowRadius = 10
            button.layer.shouldRasterize = true
            button.layer.rasterizationScale = UIScreen.main.scale
            button.backgroundColor = .systemIndigo
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    private lazy var labelPasswordNote: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Forgot your password?"
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 15)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private lazy var labelConnection: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "or connect with"
        textLabel.textColor = .darkGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 10)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private lazy var viewLeftLabel: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var viewRightLabel: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var viewFacebook: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 7
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale

        let image = UIImageView(image: UIImage(named: "LogoFacebook"))
        image.frame = CGRect(x: 20, y: 7.5, width: 15, height: 15)

        let label = UILabel()
        label.frame = CGRect(x: image.frame.maxX, y: 10, width: 10, height: 30)
        label.text = "   Facebook"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.sizeToFit()
        label.center.y = image.center.y

        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 30)

        let googleTap = UITapGestureRecognizer(target: self, action: #selector(buttonFacebookPressed))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(googleTap)

        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(button)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var viewTwitter: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 41/255.0, green: 93/255.0, blue: 177/255.0, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 7
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale

        let image = UIImageView(image: UIImage(named: "twitt"))
        image.frame = CGRect(x: 20, y: 7.5, width: 15, height: 15)
        image.backgroundColor = UIColor(red: 41/255.0, green: 93/255.0, blue: 177/255.0, alpha: 1)

        let label = UILabel()
        label.frame = CGRect(x: image.frame.maxX, y: 10, width: 10, height: 30)
        label.text = "    Twitter"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.sizeToFit()
        label.center.y = image.center.y

        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 30)

        let googleTap = UITapGestureRecognizer(target: self, action: #selector(buttonTwitterPressed))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(googleTap)

        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(button)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var hstack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 10

        let firstLabel = UILabel()
        firstLabel.textAlignment = .center
        firstLabel.text = "Don`t have accaunt?"
        firstLabel.textColor = .darkGray
        firstLabel.font = UIFont.systemFont(ofSize: 10)
        firstLabel.frame = CGRect(x: 110, y: 10, width: 110, height: 30)

        let secondLabel = UILabel()
        secondLabel.textAlignment = .center
        secondLabel.text = "Sign Up"
        secondLabel.textColor = .systemIndigo
        secondLabel.font = UIFont.boldSystemFont(ofSize: 10)
        secondLabel.frame = CGRect(x: 190, y: 10, width: 110, height: 30)

        view.addSubviews([firstLabel, secondLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubviews([
            imageView,
            labelLogin,
            textFieldMail,
            textFieldPassword,
            buttonLogin,
            labelPasswordNote,
            labelConnection,
            viewLeftLabel,
            viewRightLabel,
            viewFacebook,
            viewTwitter,
            hstack
        ])
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(450)
            make.height.equalTo(imageView.snp.width)
        }

        labelLogin.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(80)
        }

        textFieldMail.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(330)
            make.height.equalTo(50)
            make.top.equalTo(labelLogin).offset(80)
        }

        textFieldPassword.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(330)
            make.height.equalTo(50)
            make.bottom.equalTo(textFieldMail).offset(70)
        }

        buttonLogin.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(330)
            make.height.equalTo(50)
            make.bottom.equalTo(textFieldPassword).offset(100)
        }

        labelPasswordNote.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(buttonLogin).offset(40)
        }

        labelConnection.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(hstack).offset(-150)
        }

        viewLeftLabel.snp.makeConstraints { make in
            make.left.equalTo(labelPasswordNote)
            make.width.equalTo(80)
            make.height.equalTo(0.5)
            make.bottom.equalTo(hstack).offset(-155)
            make.left.equalTo(view).offset(65)
        }

        viewRightLabel.snp.makeConstraints { make in
            make.right.equalTo(labelPasswordNote)
            make.width.equalTo(80)
            make.height.equalTo(0.5)
            make.bottom.equalTo(hstack).offset(-155)
            make.right.equalTo(view).offset(-65)
        }

        viewFacebook.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(30)
            make.bottom.equalTo(hstack).offset(-60)
            make.left.equalTo(view).offset(50)
        }

        viewTwitter.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(30)
            make.top.equalTo(hstack).offset(-60)
            make.right.equalTo(view).offset(-50)
        }

        hstack.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(30)
            make.bottom.equalTo(view).offset(-35)
        }
    }

    // MARK: - Actions

    @objc private func buttonPressed() {
        buttonLogin.backgroundColor = .systemPurple
    }

    @objc private func buttonFacebookPressed() {
        viewFacebook.backgroundColor = .blue
    }

    @objc private func buttonTwitterPressed() {
        viewTwitter.backgroundColor = .blue
    }

}

// MARK: - Extensions

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

extension UITextField  {
    func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 40, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 50, y: 0, width: 80, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        leftView?.tintColor = .systemGray3
    }
}

extension UITextField {
    func setRightIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
        rightView?.tintColor = .systemGreen
    }
}
