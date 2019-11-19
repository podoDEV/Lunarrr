//
//  EventEditViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/16.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class EventEditViewController: BaseViewController, UITextFieldDelegate {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var modeLabel: UILabel!
  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var yearField: UITextField!
  @IBOutlet weak var monthField: UITextField!
  @IBOutlet weak var dayField: UITextField!
  @IBOutlet weak var createButton: UIButton!
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!

  var dataSource: CalendarDataSource?

  var mode: EventEditMode = .new
  var current = Date() {
    didSet {
      yearField.text = "\(Calendar.gregorian.component(.year, from: current))"
      monthField.text = "\(Calendar.chinese.component(.month, from: current))"
      dayField.text = "\(Calendar.chinese.component(.day, from: current))"
      datePicker.date = current
    }
  }

  var didEditFinish: (() -> Void)?

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
      action: #selector(endUpdateDate)
    )
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(
      title: "Cancel",
      style: .plain,
      target: self,
      action: #selector(cancelUpdateDate)
    )
    toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    return toolbar
  }()

  private lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.backgroundColor = .white
    datePicker.timeZone = .current
    datePicker.calendar = Calendar.chinese
    return datePicker
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
  }

  func setupSubviews() {
    containerView.backgroundColor = UIColor(named: "background")
    yearField.inputAccessoryView = toolbar
    yearField.inputView = datePicker
    monthField.inputAccessoryView = toolbar
    monthField.inputView = datePicker
    dayField.inputAccessoryView = toolbar
    dayField.inputView = datePicker

    modeLabel.text = mode.modeTitle
    titleField.text = mode.eventTitle
    current = mode.startDate
    switch mode {
    case .new:
      analytics.log(.create_view)
      editButton.isHidden = true
      deleteButton.isHidden = true
      enableButton(button: createButton, enable: false)
    case .edit(let event):
      analytics.log(.edit_view(event))
      createButton.isHidden = true
      enableButton(button: editButton, enable: false)
    }
  }

  @IBAction func closingWasTapped(_ sender: Any) {
    navigator?.pop(isModal: true)
  }

  @IBAction func createWasTapped(_ sender: Any) {
    guard let eventTitle = titleField.text else { return }
    let event = Event(title: eventTitle, date: current)
    dataSource?.newEvent(event: event)
    didEditFinish?()
    navigator?.pop(isModal: true)
  }

  @IBAction func editWasTapped(_ sender: Any) {
    guard let eventTitle = titleField.text else { return }
    guard case let .edit(event) = mode else { return }
    event.title = eventTitle
    event.date = current
    dataSource?.updateEvent(event: event)
    didEditFinish?()
    navigator?.pop(isModal: true)
  }

  @IBAction func deleteWasTapped(_ sender: Any) {
    guard case let .edit(event) = mode else { return }
    guard let id = event.id else { return }
    dataSource?.deleteEvent(id: id)
    didEditFinish?()
    navigator?.pop(isModal: true)
  }

  @IBAction func textFieldDidChange(_ sender: Any) {
    validate(text: titleField.text, date: current)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  @objc func endUpdateDate() {
    current = datePicker.date
    validate(text: titleField.text, date: current)
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

  func validate(text currentText: String?, date: Date) {
    switch mode {
    case .new:
      let enable = currentText?.isEmpty == false
      enableButton(button: createButton, enable: enable)
    case .edit(let event):
      let enable = currentText?.isEmpty == false
        && (date != event.date || currentText != event.title)
      enableButton(button: editButton, enable: enable)
    }
  }

  func enableButton(button: UIButton, enable: Bool) {
    if enable {
      let color = UIColor(named: "title")
      button.isEnabled = true
      button.setTitleColor(color, for: .normal)
      button.layer.borderColor = color?.cgColor
    } else {
      let color = UIColor(named: "title_disable")
      button.isEnabled = false
      button.setTitleColor(color, for: .normal)
      button.layer.borderColor = color?.cgColor
    }
  }
}
