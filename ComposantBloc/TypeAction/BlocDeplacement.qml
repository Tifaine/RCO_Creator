import QtQuick 2.0
import "../../Composant"
import actionDeplacement 1.0

Item {
    id:root
    width: 116
    height: 202

    property var fils:depl
    property int taille:202
    signal modifTaille(int taille)

    function setParam(id,value,vitesse ,timeOut)
    {
        if(id>0 && id <3)
        {
            cbCapteur.setIndice(id-1)
            teCapteur.text = value
            teTimeout.text = timeOut
            teVitesse.text = vitesse
        }
    }

    Deplacement
    {
        id:depl;
    }

    Text
    {
        id: textCapteur
        text: qsTr("Paramètres :")
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: true
        font.bold: true

        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    ListModel
    {
        id:listCap
        ListElement{ nom:"Avancer de"  }
        ListElement{ nom:"Tourner de"  }
    }

    CustomComboBox
    {
        id: cbCapteur
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textCapteur.bottom
        anchors.topMargin: 1
        _model: listCap
        onCustomCurrentIndexChanged:
        {
            depl.idValeur = indice+1
        }
    }

    Rectangle
    {
        id: tfCapteur
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbCapteur.bottom
        anchors.topMargin: 3
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teCapteur
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                // dyna.idDyna = text
                depl.valueValeur = text
            }
        }
    }

    Text {
        id: textTimeOut
        x: -5
        y: -1
        text: qsTr("Timeout :")
        anchors.rightMargin: 5
        visible: true
        anchors.right: parent.right
        anchors.left: parent.left
        font.pixelSize: 12
        anchors.top: tfVitesse.bottom
        anchors.topMargin: 5
        font.bold: true
        anchors.leftMargin: 5
    }

    Rectangle {
        id: tfTimeOut
        x: -8
        y: 0
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.rightMargin: 5
        visible: true
        TextEdit {
            id: teTimeout
            height: 30
            color: "#ffffff"
            text: qsTr("5000")
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            anchors.fill: parent
            onTextChanged:
            {
                depl.timeOut = text
            }
        }
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: textTimeOut.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }

    Text {
        id: textVitesse
        x: 2
        y: 0
        text: qsTr("Vitesse :")
        anchors.rightMargin: 5
        visible: true
        anchors.right: parent.right
        anchors.left: parent.left
        font.pixelSize: 12
        anchors.top: tfCapteur.bottom
        anchors.topMargin: 5
        font.bold: true
        anchors.leftMargin: 5
    }

    Rectangle {
        id: tfVitesse
        x: -7
        y: 5
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.rightMargin: 5
        visible: true
        TextEdit {
            id: teVitesse
            height: 30
            color: "#ffffff"
            text: qsTr("0")
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            anchors.fill: parent
            onTextChanged:
            {
                depl.vitesse = text
            }
        }
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: textVitesse.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }
}
