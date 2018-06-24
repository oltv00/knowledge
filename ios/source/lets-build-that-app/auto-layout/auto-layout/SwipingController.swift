import UIKit

class SwipingController: UIViewController {

    // MARK: - Data

    fileprivate let pages = [
        Page(imageName: "bear_first",
             headerText: "Join use today in our fun and games!",
             bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),

        Page(imageName: "heart_second",
             headerText: "Subscribe and get coupons on our daily events",
             bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),

        Page(imageName: "leaf_third",
             headerText: "VIP members special services",
             bodyText: "")
    ]

    // MARK: - UI elements

    private lazy var collectionViewController: UICollectionViewController = {
        $0.view.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UICollectionViewController(collectionViewLayout: flowLayout))

    private let flowLayout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())

    private var collectionView: UICollectionView? {
        return collectionViewController.collectionView
    }

    private let bottomControlsStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())

    private lazy var pageControl: UIPageControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.currentPage = 0
        $0.numberOfPages = pages.count
        $0.pageIndicatorTintColor = .azalea
        $0.currentPageIndicatorTintColor = .pink
        return $0
    }(UIPageControl())

    private let nextButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("NEXT", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitleColor(.pink, for: .normal)
        $0.addTarget(self, action: #selector(nextButtonDidPress), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))

    private let previousButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("PREV", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitleColor(.gray, for: .normal)
        $0.addTarget(self, action: #selector(previousButtonDidPress), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))

    // MARK: - Managing the View

    override func loadView() {
        super.loadView()
        view = UIView()
        view.addSubview(collectionViewController.view)
        addChildViewController(collectionViewController)
        setupView()
        collectionViewController.didMove(toParentViewController: self)
    }

    private func setupView() {
        setupCollectionView()
        setupSubviews()
        setupConstraints()
    }

    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self,
                                 forCellWithReuseIdentifier: PageCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }

    private func setupSubviews() {
        [
            bottomControlsStackView,
        ].forEach(view.addSubview)

        [
            previousButton,
            pageControl,
            nextButton,
        ].forEach(bottomControlsStackView.addArrangedSubview)
    }

    private func setupConstraints() {
        let constraints = [
            collectionViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            collectionViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Responding to Environment Changes

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.collectionView?.collectionViewLayout.invalidateLayout()

            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                self.moveScrollToIndex(self.pageControl.currentPage)
            }
        })
    }

    // MARK: - Actions

    @objc
    private func nextButtonDidPress(_ sender: UIButton) {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        moveScrollToIndex(nextIndex)
    }

    @objc
    private func previousButtonDidPress(_ sender: UIButton) {
        let previousIndex = max(pageControl.currentPage - 1, 0)
        moveScrollToIndex(previousIndex)
    }

    private func moveScrollToIndex(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        pageControl.currentPage = index
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}

// MARK: - UICollectionViewDataSource

extension SwipingController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PageCell = collectionView.cell(withReuseIdentifier: PageCell.identifier, for: indexPath)
        cell.page = pages[indexPath.item]
        return cell
    }

}

// MARK: - UIScrollViewDelegate

extension SwipingController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SwipingController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
