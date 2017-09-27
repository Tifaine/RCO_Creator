import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    property var _model : null
    ComboBox {
        id: customCombo
        height: 30
        anchors.fill: parent
        model: _model

        indicator: Image {
            x: (parent.mirrored ? parent.padding : parent.width - width - parent.padding)
            y: parent.topPadding + (parent.availableHeight - height) / 2
            source: "image://default/double-arrow/" + (!parent.editable && parent.visualFocus ? "grey" : "grey")
            sourceSize.width: width
            sourceSize.height: height
            opacity: enabled ? 1 : 0.3
        }
        background: Rectangle {
            anchors.fill: parent
            color:"#4a4545"
            radius:7
        }
        contentItem: TextField {
            leftPadding: !parent.mirrored ? 8 : parent.editable && activeFocus ? 3 : 1
            rightPadding: parent.mirrored ? 8 : parent.editable && activeFocus ? 3 : 1
            topPadding: 6 - parent.padding
            bottomPadding: 6 - parent.padding

            text: parent.editable ? parent.editText : parent.displayText

            enabled: parent.editable
            autoScroll: parent.editable
            readOnly: parent.popup.visible
            inputMethodHints: parent.inputMethodHints
            validator: parent.validator

            font: parent.font
            color: /*!cbId.editable && cbId.visualFocus ? "black" : "blue"*/"white"
            selectionColor: "grey"
            selectedTextColor: "blue"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            opacity: parent.enabled ? 1 : 0.3

            background: Rectangle {
                //visible: cbId.editable && !cbId.flat
                color:"#4a4545"
                radius:7

            }

        }
    }
}
