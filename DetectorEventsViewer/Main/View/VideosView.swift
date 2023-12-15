//
//  ViewController.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class VideosView: UIViewController {
   
    private let videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom : 0, right: 4)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let searchField: UITextField = {
        let searchField = UITextField()
        searchField.placeholder = "search"
        return searchField
    }()
    
    private let closeTextButton: UIButton = {
        let closeTextButton = UIButton(type: .system)
        closeTextButton.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeTextButton.tintColor = .gray
        return closeTextButton
    }()
    
    private let viewModel: VideosViewModelInterface = VideosViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupBindings()
        setupTargets()
    }
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(videosCollectionView)
        view.addSubview(searchField)
        view.addSubview(closeTextButton)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.and.down.text.horizontal"), style: .plain, target: self, action: #selector(openSettings))
        rightButton.tintColor = .gray
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupSubviews() {
        videosCollectionView.dataSource = self
        videosCollectionView.delegate = self
        videosCollectionView.register(CameraCell.self, forCellWithReuseIdentifier: CameraCell.identifeier)
        
        searchField.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(closeTextButton.snp.left)
            make.height.equalTo(40)
        }
        closeTextButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(40)
        }
        videosCollectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchField.snp.bottom)
        }
    }
    
    private func setupBindings() {
        viewModel.model.videos.bind { [weak self] model in
            self?.videosCollectionView.reloadData()
        }.disposed(by: bag)
        searchField.rx.text.bind { [weak self] model in
            if model == "" {
                self?.viewModel.sortByStandart()
                self?.closeTextButton.isHidden = true
            } else {
                self?.viewModel.filterByText(filteredText: model ?? "")
                self?.closeTextButton.isHidden = false
            }
        }.disposed(by: bag)
    }
    
    private func setupTargets() {
        closeTextButton.addTarget(self, action: #selector(closeSearchText), for: .touchUpInside)
    }
    
    @objc
    private func openSettings() {
        let alert = UIAlertController(title: "Sorting", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sort by Name", style: .default, handler: { [weak self] _ in
            self?.viewModel.sortByName()
        }))
        alert.addAction(UIAlertAction(title: "Sort by ID", style: .default, handler: { [weak self] _ in
            self?.viewModel.sortById()
        }))
        alert.addAction(UIAlertAction(title: "Standart sort", style: .default, handler: { [weak self] _ in
            self?.viewModel.sortByStandart()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func closeSearchText() {
        searchField.text = ""
        viewModel.sortByStandart()
        closeTextButton.isHidden = true
    }

}

extension VideosView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.model.videos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CameraCell.identifeier, for: indexPath) as? CameraCell
        else { return UICollectionViewCell() }
        let camera = viewModel.model.videos.value[indexPath.row]
        cell.configure(camera: camera)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthForCell: Double = view.frame.width
        return CGSize(width: (widthForCell / 2) - 10, height: (widthForCell / 2) - 10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CameraCell,
              let camera = cell.camera
        else { return }
        let cameraView = CameraView()
        cameraView.configure(camera: camera)
        navigationController?.pushViewController(cameraView, animated: true)
    }
}
