//
//  ViewController.swift
//  UIKit-Practice
//
//  Created by Kyungsoo Lee on 2023/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     lazy를 사용하여 초기화 시점 조절 가능(지연 초기화)
     lazy를 사용하면 변수의 초기화 시점을 viewController가 초기화 된 이후로 늦출 수 있다.
     그럼 왜 초기화를 늦춰야 할까?
     -> #selector부분에서 self를 사용할 때 초기화를 늦춰야만 ViewController에 접근이 가능하다.
     (또한, lazy를 사용할 때는 반드시 var를 사용해야한다.)
     */
    
    private lazy var loginLabel: UILabel = {
       let label = UILabel()
        label.text = "로그인"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Item2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemGray
        
        // 뷰 추가(아직 layout 설정 안된 상태)
        view.addSubview(loginLabel)
        view.addSubview(testButton)
        
        
        
        
        setLayout()
        

        
    }
    
    // 컴포넌트들의 레이아웃을 설정한다
    private func setLayout() {
        // 프레임 기반의 레이아웃을 비활성화 하여 오토 레이아웃을 기반으로 설정할 수 있도록 한다.
        
        let loginLabelConstraint = [
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let testButtonConstraint = [
            // 다른 컴포넌트의 상대적인 위치로 제약조건을 설정할 수도 있다.
            testButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            testButton.centerXAnchor.constraint(equalTo: loginLabel.centerXAnchor)
        ]

        
        // 제약 조건을 활성화 시켜 오토 레이아웃 설정한다.
        NSLayoutConstraint.activate(loginLabelConstraint)
        /*
         위 방식과 동일한 코드(서로 방식만 다름)
         loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         */
        
        NSLayoutConstraint.activate(testButtonConstraint)

        
        

    }

}


// UIKit으로 짠 화면을 SwiftUI로 바로 볼 수 있게 해주는 코드
import SwiftUI

struct ViewControllerResentable: UIViewControllerRepresentable {
    // typealias : 타입의 별칭을 정하는데 사용
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct ViewPreView: PreviewProvider {
    static var previews: some View {
        ViewControllerResentable()
    }
}
