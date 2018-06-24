//
//  Constant.swift
//  Test-Yandex
//
//  Created by Oleg Tverdokhleb on 31/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

struct kServerAPI {
  static let categoriesList = "https://money.yandex.ru/api/categories-list"
}

struct kCellIdentifier {
  static let category = "CategoryCell"
  static let subCategory = "SubCategoryCell"
}

struct kUserDefaults {
  static let isFirstLaunch = "kFirstLaunch"
}

struct kController {
  static let category = "CategoryTableViewController"
  static let subCategory = "SubCategoryTableViewController"
}

struct kEntityName {
  static let allObjects = "OLTVObject"
  static let category = "Category"
  static let subCategory = "SubCategory"
}

struct kAlert {
  static let successTitle = "Отлично"
  static let successMessage = "Данные успешно загружены"
  static let errorTitle = "Ошибка"
  static let noInternetMessage = "Нет интернет соединения"
  static let serverErrorMessage = "К сожалению, сервер временно недоступен"
}
