import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 2.2
import retourOrientation 1.0
import "../../Composant"

Item {
    id: root
    width: 180
    height: 60
    signal modifTaille(int taille)
    property int taille:60
    property var fils:angle
    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);
    }

    function setParam(ori, preci,timeOut)
    {
        tfOrientation.text = ori
        tfPrecision.text = preci
        teTimeOut.text = timeOut
    }

    Component.onCompleted:
    {
        tailleChange(60)
    }

    RetourOrientation
    {
        id:angle
        orientation: tfOrientation.text
        precision: tfPrecision.text
    }

    Text {
        id: textOrientation
        text: qsTr("Orientation : ")
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pixelSize: 12
    }

    TextField {
        id: tfOrientation
        text: qsTr("0")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textOrientation.bottom
        anchors.topMargin: 5
        color: "white"
        height: 30
        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    Text {
        id: textPrecision
        text: qsTr("Precision :")
        visible: false
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: tfOrientation.bottom
        anchors.topMargin: 5
        font.pixelSize: 12
    }

    TextField {
        id: tfPrecision
        text: qsTr("5")
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textPrecision.bottom
        anchors.topMargin: 5
        color: "white"
        height: 30
        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    Text {
        id: textTimeOut
        text: qsTr("TimeOut :")
        visible: false
        font.bold: true
        anchors.top: tfPrecision.bottom
        anchors.topMargin: 5
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
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textTimeOut.bottom
        anchors.topMargin: 5
        visible: false
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
            onTextChanged: angle.timeOut = text
        }
    }

    Button {
        id: button
        x: -267
        width: 15
        height: 15
        text: qsTr("v")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        property int nbClic :1
        onClicked:
        {
            if(nbClic ===0)
            {
                nbClic = 1;
                root.state = "Ferme"
                button.text = "v"
                var tailleToSend = 60
                tailleChange(tailleToSend)

            }else
            {
                root.state = "Ouvert"
                button.text = "^"
                var tailleToSend = 176
                tailleChange(tailleToSend)
                nbClic = 0;
            }
        }
    }
    states: [
        State {
            name: "Ouvert"

            PropertyChanges {
                target: textPrecision
                visible: true
            }

            PropertyChanges {
                target: tfPrecision
                visible: true
            }

            PropertyChanges {
                target: textTimeOut
                visible: true
            }

            PropertyChanges {
                target: tfTimeOut
                visible: true
            }
        },
        State {
            name: "Ferme"
        }
    ]
}
