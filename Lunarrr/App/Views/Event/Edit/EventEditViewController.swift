//
//  EventEditViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/16.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class EventEditViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var modeLabel: UILabel!
  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var yearField: UITextField!
  @IBOutlet weak var monthField: UITextField!
  @IBOutlet weak var dayField: UITextField!
  @IBOutlet weak var createButton: UIButton!
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!

  var mode: EventEditMode = .new
  var current = Date() {
    didSet {
      let calendar = Calendar(identifier: .chinese)
      yearField.text = "\(calendar.component(.year, from: current))"
      monthField.text = "\(calendar.component(.month, from: current))"
      dayField.text = "\(calendar.component(.day, from: current))"
    }
  }

  private lazy var toolbar: UIToolbar = {
    let toolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.isTranslucent = true
    toolbar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
    toolbar.sizeToFit()

    let doneButton = UIBarButtonItem(
      title: "Done",
      style: .plain,
      target: self,
      action: #selector(EventEditViewController.endUpdateDate)
    )
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(
      title: "Cancel",
      style: .plain,
      target: self,
      action: #selector(EventEditViewController.cancelUpdateDate)
    )
    toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    return toolbar
  }()

  private lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.maximumDate = self.current
    datePicker.backgroundColor = .white
    datePicker.timeZone = .current
    datePicker.calendar = Calendar(identifier: .chinese)
    return datePicker
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
  }

  func setupSubviews() {
    containerView.backgroundColor = .white
    yearField.inputAccessoryView = toolbar
    yearField.inputView = datePicker
    monthField.inputAccessoryView = toolbar
    monthField.inputView = datePicker
    dayField.inputAccessoryView = toolbar
    dayField.inputView = datePicker

    modeLabel.text = mode.modeTitle
    titleField.text = mode.eventTitle
    current = mode.startDate
    createButton.isHidden = mode != .new
    editButton.isHidden = mode == .new
    deleteButton.isHidden = mode == .new
  }

  @IBAction func didTapClose(_ sender: Any) {
    dismiss(animated: true)
  }

  @IBAction func didTapCreate(_ sender: Any) {
  }

  @IBAction func didTapEdit(_ sender: Any) {
  }

  @IBAction func didTapDelete(_ sender: Any) {
  }

  @objc func endUpdateDate() {
    current = datePicker.date
    resignDateFields()
  }

  @objc func cancelUpdateDate() {
    resignDateFields()
  }

  func resignDateFields() {
    yearField.resignFirstResponder()
    monthField.resignFirstResponder()
    dayField.resignFirstResponder()
  }
}
