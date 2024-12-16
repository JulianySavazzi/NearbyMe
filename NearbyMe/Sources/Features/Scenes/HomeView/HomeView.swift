//
//  HomeView.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 13/12/24.
//
 
import Foundation
import MapKit

//tela com mapa nativo do UIKit e TableView
class HomeView: UIView {
    
    private var filterButtonAction: ((PlaceCetegory) -> Void)?
    private var categories: [PlaceCetegory] = []
    private var selectedButton: UIButton?
    
    //mapa nativo do IOS
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    //adicionando scroll na tela -> a direçao padrao dele é horizontal, mas podemos mudar para vertical
    private let filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false //nao mostar o indicador de scroll
        scrollView.isUserInteractionEnabled = true //usuario conseguir interagir com o scroll
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //container para conter as PlaceTableViewCells - lista de locais
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.cornerRadius = 16 //borda arredondada
        view.clipsToBounds = true //para o cornerRadius funcionar corretamente
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = Colors.gray300
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore locais perto de você"
        label.font = Typography.textMD
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //pilha de botoes do filterScroll -> vai colocar os botoes na tela dentro do scroll
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal //direcao do botao na mesma direcao do eixo
        stackView.spacing = 9
        stackView.isUserInteractionEnabled = true
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //TableView - lista de elementos
    private let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier) //cada linha da tabela vai conter um PlaceTableViewCell
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var containerTopConstraint: NSLayoutConstraint! //forcando a usar -> assumo que essa var sempre vai existir

    private func setupUI() {
        addSubview(mapView)
        addSubview(filterScrollView)
        addSubview(containerView)
        //botoes que filtram os lugares no mapa
        filterScrollView.addSubview(filterStackView)
        //lista de locais com foto, descricao e cupons de desconto
        containerView.addSubview(dragIndicatorView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(placesTableView)
        
        setupPanGesture()
        setupConstraints()
    }

    private func setupConstraints() {
        //o constraint multiplier significa qual porcentagem da tela queremos que aquele elemento ocupe -> 0.65 = 65%
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            filterScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            filterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            filterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalTo: filterStackView.heightAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        //queremos que o height do nosso container seja dinamico, para isso vamos deixar seu topAnchor dinamico
        containerTopConstraint = containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16)
        containerTopConstraint.isActive = true
        //array de constraints dos elementos dentro do container
        NSLayoutConstraint.activate([
            dragIndicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            dragIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 80),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            
            descriptionLabel.topAnchor.constraint(equalTo: dragIndicatorView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
        
            placesTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            placesTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            placesTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            placesTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        placesTableView.delegate = delegate
        placesTableView.dataSource = dataSource
    }
    
    //reconhecer os gestos feitos na tela pelos usuarios
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture) //adicionando os gestos ao metodo
    }
    
    func updateFilterButtons(with categories: [PlaceCetegory], action: @escaping (PlaceCetegory) -> Void) {
        //usando icones da apple do UIkit
        let categoryIcons: [String: String] = [
            "Alimentação" : "fork.knife",
            "Compras" : "cart",
            "Hospedagem" : "bed.double",
            "Padaria" : "cup.and.saucer",
        ] //dicionario -> estrutura de dados em que a chave e valor sao String
     
        self.categories = categories
        self.filterButtonAction = action
        
        //atribuindo os icones a cada categoria e adicionando o botao de filtro
        for (index, category) in categories.enumerated() {
            let iconName = categoryIcons[category.name] ?? "questionmark.circle"
            let button = createFilterButton(title: category.name, iconName: iconName)
            button.tag = index
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            
            if category.name == "Alimentação" {
                updateButtonSelection(button: button)
            }
            
            filterStackView.addArrangedSubview(button)
        }
    }
    
    private func createFilterButton(title: String, iconName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.layer.cornerRadius = 8
        button.tintColor = Colors.gray600
        button.backgroundColor = Colors.gray100
        button.setTitleColor(Colors.gray600, for: .normal)
        button.titleLabel?.font = Typography.textSM
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.heightAnchor.constraint(equalToConstant: 13).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 13).isActive = true
//        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 8)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        
//        filterStackView.isLayoutMarginsRelativeArrangement = true
//        filterStackView.layoutMargins = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        
        return button
    }
    
    //mudar a cor do botao selecionado
    private func updateButtonSelection(button: UIButton) {
        if let previousButton = selectedButton {
            previousButton.backgroundColor = Colors.gray100
            previousButton.setTitleColor(Colors.gray600, for: .normal)
            previousButton.tintColor = Colors.gray600
        }
        
        button.backgroundColor = Colors.purpleBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.tintColor = Colors.gray100
        
        selectedButton = button
    }
    
    //expor a funcao de filtrar categoria para o ObjectiveC -> base do IOS
    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        let selectedCategory = categories[sender.tag]
        updateButtonSelection(button: sender)
        filterButtonAction?(selectedCategory)
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }
    
    //reconhecer cliques e toques na tela
    @objc
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            let newConstant = containerTopConstraint.constant + translation.y
            if newConstant <= 0 && newConstant >= frame.height * 0.5 {
                containerTopConstraint.constant = newConstant
                gesture.setTranslation(.zero, in: self)
            }
        case .ended:
            let halfScreenHeight = -frame.height * 0.25
            let finalPosition: CGFloat
            
            if velocity.y > 0 {
                finalPosition = 0
            } else {
                finalPosition = halfScreenHeight
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.containerTopConstraint.constant = finalPosition
                self.layoutIfNeeded() //atualizar o layout da tela
            })
        default:
            break
        }
        
    }
    
}
