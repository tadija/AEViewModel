/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct CellsViewModel: ViewModel {
    public enum Id: String {
        case basic
        case subtitle
        case leftDetail
        case rightDetail
        case textInput
        case slider
        case toggleBasic
        case toggleSubtitle
        case button
    }

    var title: String? = "Cells"
    var sections: [Section]

    init() {
        sections = [
            BasicSection(header: "System", items: [
                BasicItem(identifier: Id.basic.rawValue, title: "Basic"),
                BasicItem(identifier: Id.subtitle.rawValue, title: "Subtitle", detail: "Subtitle"),
                BasicItem(identifier: Id.leftDetail.rawValue, title: "Left", detail: "Detail"),
                BasicItem(identifier: Id.rightDetail.rawValue, title: "Right", detail: "Detail"),
            ]),
            BasicSection(header: "Input", items: [
                BasicItem(identifier: Id.textInput.rawValue, title: "Text Input"),
                BasicItem(identifier: Id.slider.rawValue),
            ]),
            BasicSection(header: "Actions", items: [
                BasicItem(identifier: Id.toggleBasic.rawValue, title: "Toggle"),
                BasicItem(identifier: Id.toggleSubtitle.rawValue, title: "Togle", detail: "Subtitle"),
                BasicItem(identifier: Id.button.rawValue, title: "Button"),
            ]),
        ]
    }
}
