//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 17/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {

  //  var videos: [Video] = {
  //    var kanyeChannel = Channel()
  //    kanyeChannel.name = "KanyeIsTheBestChannel"
  //    kanyeChannel.profileImageName = "kanye_profile"
  //
  //    var blankSpace = Video()
  //    blankSpace.title = "Taylor Swift - Blank Space"
  //    blankSpace.thumbnailImageName = "taylor-swift-blank-space"
  //    blankSpace.channel = kanyeChannel
  //    blankSpace.numberOfViews = 234534534
  //
  //    var badBlood = Video()
  //    badBlood.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
  //    badBlood.thumbnailImageName = "taylor_swift_bad_blood"
  //    badBlood.channel = kanyeChannel
  //    badBlood.numberOfViews = 4423874234
  //
  //    return [blankSpace, badBlood]
  //  }()

  var videos: [Video]?

  func fetchVideos() {
    let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
              if error != nil {
                print("\(error)")
                return
              }

              do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                self.videos = [Video]()

                for dictionary in json as! [[String: AnyObject]] {

                  let channelDictionary = dictionary["channel"] as! [String: AnyObject]

                  let channel = Channel()
                  channel.name = channelDictionary["name"] as? String
                  channel.profileImageUrl = channelDictionary["profile_image_name"] as? String

                  let video = Video()
                  video.title = dictionary["title"] as? String
                  video.thumbnailImageUrl = dictionary["thumbnail_image_name"] as? String
                  video.channel = channel

                  self.videos?.append(video)
                }

                DispatchQueue.main.async {
                  self.collectionView?.reloadData()
                }

              } catch let jsonError {
                print(jsonError)
              }

            }.resume()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    fetchVideos()

    navigationItem.title = "Home"
    navigationController?.navigationBar.isTranslucent = false

    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "Home"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel

    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(VideCell.self, forCellWithReuseIdentifier: "CellId")

    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)

    setupMenuBar()
    setupNavBarButtons()
  }

  func setupNavBarButtons() {

    let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
  }

  lazy var settingsLauncher: SettingsLauncher = {
    let launcher = SettingsLauncher()
    launcher.homeController = self
    return launcher
  }()

  func handleMore() {
    settingsLauncher.showSettings()
  }

  func showControllerForSetting(_ setting: Setting) {
    let vc = UIViewController()
    vc.navigationItem.title = setting.name
    vc.view.backgroundColor = UIColor.white
    navigationController?.navigationBar.tintColor = UIColor.white
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func handleSearch() {
    print("handleSearch")
  }

  let menuBar: MenuBar = {
    let mb = MenuBar()
    return mb
  }()

  private func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithVisualFormat("H:|[v0]|", views: menuBar)
    view.addConstraintsWithVisualFormat("V:|[v0(50)]", views: menuBar)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! VideCell
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let cell = cell as? VideCell {
      cell.video = videos?[indexPath.item]
    }
  }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.width - 16 - 16
    let height = width * 9 / 16
    return CGSize(width: view.frame.width, height: height + 16 + 88)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
