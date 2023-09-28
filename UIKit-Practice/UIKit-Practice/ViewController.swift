//
//  ViewController.swift
//  UIKit-Practice
//
//  Created by Kyungsoo Lee on 2023/09/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {
    /*
     lazy를 사용하여 초기화 시점 조절 가능(지연 초기화)
     lazy를 사용하면 변수의 초기화 시점을 viewController가 초기화 된 이후로 늦출 수 있다.
     그럼 왜 초기화를 늦춰야 할까?
     -> #selector부분에서 self를 사용할 때 초기화를 늦춰야만 ViewController에 접근이 가능하다.
     (또한, lazy를 사용할 때는 반드시 var를 사용해야한다.)
     */
    
    // MARK: - UILable
    private lazy var uiLable: UILabel = {
        let label = UILabel()
        label.text = "UILabel"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - UIButton
    private lazy var uiButton: UIButton = {
        let button = UIButton()
        button.setTitle("UIButton", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray2
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - UIButton이 눌렸을 때 호출되는 액션 함수
    @objc func buttonTapped() {
        print("버튼이 눌렸습니다.")
    }
    
    // MARK: - UITextField
    private lazy var uiTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "글자를 입력하세요."
        textField.backgroundColor = .lightGray
        textField.textColor = .black
        // UITextField가 속한 컨트롤러에 "UITextFieldDelegate" 프로토콜을 추가해야 한다.
        // 사용자와 상호 작용하고 입력 이벤트를 처리하기 위해 프로토콜을 추가
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: - UITextView
    private lazy var uiTextView: UITextView = {
        let textView = UITextView()
        textView.text = "UITextView"
        textView.textAlignment = .center
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 24, weight: .medium)
        textView.layer.borderWidth = 5
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.isEditable = true
        // UITextView가 속한 컨트롤러에 "UITextViewDelegate" 프로토콜을 추가해야 한다.
        // 사용자와 상호 작용하고 입력 이벤트를 처리하기 위해 프로토콜을 추가
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    // MARK: - UIImageView
    private lazy var uiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "INHA-UMC-5th")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - UITableView
    private lazy var uiTableView: UITableView = {
        let tableView = UITableView()
        // UITableView의 설정
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // UITableView가 속한 컨트롤러에 "UITableViewDataSource" 프로토콜을 추가해야 한다.
        // "UITableViewDataSource" 프로토콜을 따르기 위해선 tableView()을 반드시 선언해야 한다.
        tableView.dataSource = self
        // UITableView가 속한 컨트롤러에 "UITableViewDelegate" 프로토콜을 추가해야 한다.
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - UITableViewDataSource 메서드
    
    // 테이블 뷰에 표시할 데이터 배열
    private let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    // 섹션당 행의 개수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // 각 행의 셀을 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // (Option) 특정 행을 선택했을 때 실행되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        print("선택된 항목: \(selectedItem)")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemGray
        
        // 뷰 추가(아직 layout 설정 안된 상태)
        //        self.view.addSubview(uiLable)
        //        self.view.addSubview(uiButton)
        //        self.view.addSubview(uiTextField)
        //        self.view.addSubview(self.uiTextView)
        //        self.view.addSubview(self.uiImageView)
        self.view.addSubview(self.uiTableView)
        
        setLayout()
    }
    
    // MARK: - UILabel 제약조건
    private func setUILableLayout() {
        let uiLabelConstraint = [
            uiLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiLable.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        // 제약 조건을 활성화 시켜 오토 레이아웃 설정한다.
        NSLayoutConstraint.activate(uiLabelConstraint)
        /*
         위 방식과 동일한 코드(서로 방식만 다름)
         uiLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         uiLable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         */
    }
    
    // MARK: - UIButton 제약조건
    private func setUIButtonLayout() {
        let uiButtonConstraint = [
            // 다른 컴포넌트의 상대적인 위치로 제약조건을 설정할 수도 있다.
            uiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(uiButtonConstraint)
    }
    
    // MARK: - UITextField 제약조건
    private func setUITextFieldLayout() {
        let uiTextFieldConstraint = [
            // 다른 컴포넌트의 상대적인 위치로 제약조건을 설정할 수도 있다.
            uiTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(uiTextFieldConstraint)
    }
    
    // MARK: - UITextView 제약 조건
    private func setUITextViewLayout() {
        let uiTextViewConstraint = [
            // 다른 컴포넌트의 상대적인 위치로 제약조건을 설정할 수도 있다.
            uiTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiTextView.widthAnchor.constraint(equalToConstant: 200), // 너비 제약 조건 추가
            uiTextView.heightAnchor.constraint(equalToConstant: 200) // 높이 제약 조건 추가
        ]
        NSLayoutConstraint.activate(uiTextViewConstraint)
    }
    
    // MARK: - UIImageView 제약 조건
    private func setUIImageViewLayout() {
        let uiImageViewConstraint = [
            // 다른 컴포넌트의 상대적인 위치로 제약조건을 설정할 수도 있다.
            uiImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiImageView.widthAnchor.constraint(equalToConstant: 200), // 너비 제약 조건 추가
            uiImageView.heightAnchor.constraint(equalToConstant: 200) // 높이 제약 조건 추가
        ]
        NSLayoutConstraint.activate(uiImageViewConstraint)
    }
    
    // MARK: - UITableView 제약 조건
    private func setUITableViewLayout() {
        let UITableViewConstraint = [
            // 다른 컴포넌트의 상대적인 위치로 제약조건을 설정할 수도 있다.
            uiTableView.topAnchor.constraint(equalTo: view.topAnchor),
            uiTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(UITableViewConstraint)
        
    }
    // MARK: - 전체 제약조건 설정
    // 컴포넌트들의 레이아웃을 설정한다
    private func setLayout() {
        // 프레임 기반의 레이아웃을 비활성화 하여 오토 레이아웃을 기반으로 설정할 수 있도록 한다.
        
        // UILabel 제약조건 설정
        //        setUILableLayout()
        
        // UIButton 제약조건 설정
        //        setUIButtonLayout()
        
        // UITextField 제약조건 설정
        //        setUITextFieldLayout()
        
        // UITextView 제약조건 설정
        //        setUITextViewLayout()
        
        // UIImageView 제약조건 설정
        //        setUIImageViewLayout()
        
        // UITableView 제약조건 설정
        setUITableViewLayout()
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
