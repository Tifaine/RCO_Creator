import QtQuick 2.0
import "../../Composant"
import QtQuick.Controls 2.2
import actionCourbe 1.0

Item {
    id:root
    width: 120
    height: 335

    signal modifTaille(int taille)
    property var fils:courbe

    property int taille:335

    Component.onCompleted:
    {
        modifTaille(335)
    }

    function setParam(vitesse, angle, rayon, precision, sens, timeOut)
    {
        teVitesse.text = vitesse
        teAngle.text = angle
        teRayon.text = rayon
        tePrecision.text = precision

        teTimeOut.text = timeOut

        if(sens === "0")
        {
            switchSens.checked = false
        }else
        {
            switchSens.checked = true
        }
    }

    Courbe
    {
        id:courbe
    }

    Text {
        id: textVitesse
        text: qsTr("Vitesse : ")
        font.bold: true
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pixelSize: 12
    }

    Rectangle
    {
        id: tfVitesse
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textVitesse.bottom
        anchors.topMargin: 5
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teVitesse
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                courbe.vitesse = text
            }
        }
    }

    Text {
        id: textRayon
        x: -1
        y: -8
        text: qsTr("Rayon : ")
        font.bold: true
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: tfVitesse.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Rectangle {
        id: tfRayon
        x: -2
        y: 4
        height: 30
        color: "#4a4545"
        radius: 7
        TextEdit {
            id: teRayon
            height: 30
            color: "#ffffff"
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            anchors.leftMargin: 10
            onTextChanged:
            {
                courbe.rayon = text
            }
        }
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: textRayon.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        visible: true
    }

    Text {
        id: textAngle
        x: 3
        y: -3
        text: qsTr("Angle : ")
        font.bold: true
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: tfRayon.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Rectangle {
        id: tfAngle
        x: 7
        y: 2
        height: 30
        color: "#4a4545"
        radius: 7
        TextEdit {
            id: teAngle
            height: 30
            color: "#ffffff"
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            anchors.leftMargin: 10
            onTextChanged:
            {
                courbe.angle = text
            }
        }
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: textAngle.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        visible: true
    }

    Text {
        id: textPrecision
        x: 0
        y: -4
        text: qsTr("Précision : ")
        font.bold: true
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: tfAngle.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Rectangle {
        id: tfPrecision
        x: -1
        y: -4
        height: 30
        color: "#4a4545"
        radius: 7
        TextEdit {
            id: tePrecision
            height: 30
            color: "#ffffff"
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            anchors.leftMargin: 10
            onTextChanged:
            {
                courbe.precision = text
            }
        }
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: textPrecision.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        visible: true
    }

    Switch {
        id: switchSens
        text: checked===true? "Arrière":"Avant"
        anchors.top: tfPrecision.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        onClicked:
        {
            courbe.sens = checked
        }
    }

    Text {
        id: textTimeOut
        x: -2
        y: -2
        text: qsTr("Timeout : ")
        font.bold: true
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: switchSens.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    Rectangle {
        id: tfTimeOut
        x: -7
        y: 2
        height: 30
        color: "#4a4545"
        radius: 7
        TextEdit {
            id: teTimeOut
            height: 30
            color: "#ffffff"
            text: qsTr("5000")
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            anchors.leftMargin: 10
            onTextChanged: courbe.timeOut = text
        }
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.top: textTimeOut.bottom
        anchors.right: parent.right
        anchors.leftMargin: 5
        visible: true
    }
}
