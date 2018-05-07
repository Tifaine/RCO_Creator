import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../Composant"
import attenteBlocage 1.0

Item {
    id:root
    width: 116
    height: 130
    property int taille:130
    property var fils:attente
    signal modifTaille(int taille)
    function setParam(timeOut, sensibilite)
    {
        tfTimeout.text = timeOut
        tfSensibilite.text = sensibilite
    }

    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);
    }
    Component.onCompleted:
    {
        root.state = "ferme"
        tailleChange(130)
    }

    AttenteBlocage
    {
        id:attente
        timeOut: tfTimeout.text
        sensibilite: tfSensibilite.text
    }

    TextField {
        id: tfTimeout
        height: 30
        color: "#ffffff"
        text: qsTr("500")
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
        anchors.top: tfSensibilite.bottom
        anchors.topMargin: 5
        font.bold: true
        anchors.leftMargin: 5
    }

    TextField {
        id: tfSensibilite
        x: -3
        y: -3
        height: 30
        color: "#ffffff"
        text: qsTr("100")
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.rightMargin: 5
        background: Rectangle {
            color: "#4a4545"
            radius: 7
            anchors.fill: parent
        }
        anchors.top: textSensibilite.bottom
        anchors.right: parent.right
        visible: true
        anchors.leftMargin: 5
    }

    Text {
        id: textSensibilite
        x: 0
        y: -3
        text: qsTr("Sensibilite :")
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: parent.top
        font.bold: true
        font.pixelSize: 12
        anchors.leftMargin: 5
    }


}
