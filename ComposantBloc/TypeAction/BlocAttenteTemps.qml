import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../Composant"
import attenteTemps 1.0

Item {
    id:root
    width: 116
    height: 70
    property int taille:70
    property var fils:attente
    signal modifTaille(int taille)
    function setParam(temps)
    {
        tfAttente.text=temps
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

    AttenteTemps
    {
        id:attente
        temps: tfAttente.text
    }

    TextField {
        id: tfAttente
        x: 5
        height: 30
        text: qsTr("0")
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textValue.bottom
        anchors.topMargin: 5
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    Text {
        id: textValue
        text: qsTr("Value :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }


}
