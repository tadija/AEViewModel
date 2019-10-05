/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct CellsDataSource: DataSource {
    public enum Id: String {
        case basic
        case subtitle
        case leftDetail
        case rightDetail
        case toggle
        case toggleWithSubtitle
        case slider
        case sliderWithLabels
        case textField
        case textView
        case button
        case spinner
    }

    var title: String? = "Cells"
    var sections: [Section]

    init() {
        sections = [
            BasicSection(header: "Base", items: [
                BasicItem(identifier: Id.basic.rawValue, title: "Basic"),
                BasicItem(identifier: Id.subtitle.rawValue, title: "Subtitle", detail: "Subtitle"),
                BasicItem(identifier: Id.leftDetail.rawValue, title: "Left", detail: "Detail"),
                BasicItem(identifier: Id.rightDetail.rawValue, title: "Right", detail: "Detail"),
            ]),
            BasicSection(header: "Custom", items: [
                BasicItem(identifier: Id.toggle.rawValue,
                          viewModel: TableCellToggle.ViewModel(title: "Title", isOn: true)),
                BasicItem(identifier: Id.toggleWithSubtitle.rawValue,
                          viewModel: TableCellToggleWithSubtitle.ViewModel(title: "Title",
                                                                           subtitle: "Subtitle",
                                                                           isOn: false)),
                BasicItem(identifier: Id.slider.rawValue, viewModel: TableCellSlider.ViewModel(value: 0.5)),
                BasicItem(identifier: Id.sliderWithLabels.rawValue,
                          viewModel: TableCellSliderWithLabels.ViewModel(leftText: "Left",
                                                                         centerText: "Center",
                                                                         rightText: "Right",
                                                                         value: 0.75)),
                BasicItem(identifier: Id.textField.rawValue, title: "Text Input"),
                BasicItem(identifier: Id.textView.rawValue, title: "Text View", detail: "with some text on it..."),
                BasicItem(identifier: Id.button.rawValue, title: "Button"),
                BasicItem(identifier: Id.spinner.rawValue, title: "Spinner"),
            ]),
        ]
    }
}
