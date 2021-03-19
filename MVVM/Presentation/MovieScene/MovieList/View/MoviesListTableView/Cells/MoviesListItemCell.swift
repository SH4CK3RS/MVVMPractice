//
//  MoviesListItemCell.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import UIKit

final class MoviesListItemCell: UITableViewCell {
  static let reuseIdentifier = String(describing: MoviesListItemCell.self)
  static let height = CGFloat(130)
  
  
  private var viewModel: MoviesListItemViewModel!
  private var posterImagesRepository: PosterImagesRepository?
  private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Title"
    label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    return label
  }()
  
  private var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Release Date"
    label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    return label
  }()
  
  private var overviewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Overview"
    label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    return label
  }()
  
  private var posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func fill(
    with viewModel: MoviesListItemViewModel,
    posterImagesRepository: PosterImagesRepository?
  ) {
    self.viewModel = viewModel
    self.posterImagesRepository = posterImagesRepository
    
    titleLabel.text = viewModel.title
    dateLabel.text = viewModel.releaseDate
    overviewLabel.text = viewModel.overview
    
  }
  
  // MARK: - Private
  
  private func setupViews() {
    [titleLabel, dateLabel, overviewLabel, posterImageView].forEach {
      self.contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
      posterImageView.widthAnchor.constraint(equalToConstant: 80)
    ])
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: posterImageView.leadingAnchor, constant: -8)
    ])
    
    NSLayoutConstraint.activate([
      dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.5),
      dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: posterImageView.leadingAnchor, constant: -8)
    ])
    
    NSLayoutConstraint.activate([
      overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      overviewLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
      overviewLabel.trailingAnchor.constraint(lessThanOrEqualTo: posterImageView.leadingAnchor, constant: -8),
      overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -11)
    ])
  }
  
  private func updatePosterImage(width: Int) {
    posterImageView.image = nil
    guard let posterImagePath = viewModel.posterImagPath else { return }
    
    imageLoadTask = posterImagesRepository?.fetchImage(
      with: posterImagePath,
      width: width) { [weak self] result in
      guard let self = self else { return }
      guard self.viewModel.posterImagPath == posterImagePath else { return }
      if case let .success(data) = result {
        self.posterImageView.image = UIImage(data: data)
      }
    }
  }
  
  
}
