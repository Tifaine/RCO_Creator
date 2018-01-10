import QtQuick 2.0
import blocAND 1.0

Item {
    id:root
    width: 116
    height: 175

    property var fils:blocAnd
    signal modifTaille(int taille)

    function setParam(timeout)
    {
        teTimeOut.text = timeout
    }

    BlocAnd
    {
        id:blocAnd
    }

    Text {
        id: textTimeOut
        text: qsTr("TimeOut :")
        anchors.bottom: tfTimeOut.top
        anchors.bottomMargin: 5
        visible: true
        font.bold: true

        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Rectangle
    {
        id: tfTimeOut
        height: 30
        radius:7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teTimeOut
            height: 30
            text: qsTr("5000")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged: blocAnd.timeOut = text
        }
    }
}
