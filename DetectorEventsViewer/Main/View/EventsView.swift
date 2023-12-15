//
//  EventsView.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import UIKit
import RxSwift
import RxCocoa

class EventsView: UIViewController {
    
    private let eventsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let viewModel: EventsViewModelInterface = EventsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupBindings()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.viewModel.loadEventsFromAPI()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(eventsCollectionView)
    }
    
    private func setupSubviews() {
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifeier)
        eventsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupBindings() {
        viewModel.model.events.bind { [weak self] model in
            self?.eventsCollectionView.reloadData()
        }
    }
    
}

extension EventsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.model.events.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifeier, for: indexPath) as? EventCell
        else { return UICollectionViewCell() }
        cell.configure(event: viewModel.model.events.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthForCell: Double = view.frame.width
        return CGSize(width: widthForCell, height: 100)
    }
}
