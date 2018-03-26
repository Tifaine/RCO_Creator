import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../Composant"
import attenteBlocage 1.0

Item {
    id:root
    width: 116
    height: 70
    property int taille:70
    property var fils:attente
    signal modifTaille(int taille)
    function setParam(timeOut)
    {
        tfTimeout.text = timeOut
    }

    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);

    }
    Component.onCompleted:
    {
        root.state = "ferme"
        tailleChange(70)
    }

    AttenteBlocage
    {
        id:attente
        timeOut: tfTimeout.text
    }

    TextField {
        id: tfTimeout
        height: 30
        color: "#ffffff"
        text: qsTr("0")
        anchors.rightMargin: 5
        visible: true
        anchors.right: parent.right
        anchors.left: parent.left
        background: Rectangle {
            color: "#4a4545"
            radius: 7
            anchors.fill: parent
        }
        anchors.top: textTimeout.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }

    Text {
        id: textTimeout
        x: 3
        text: qsTr("Timeout :")
        anchors.left: parent.left
        font.pixelSize: 12
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        anchors.leftMargin: 5
    }


}
