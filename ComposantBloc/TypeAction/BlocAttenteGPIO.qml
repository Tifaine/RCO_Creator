import QtQuick 2.5
import "../../Composant"
import retourGPIO 1.0

Item {
    id:root
    width: 116
    height: 146

    property var fils:retourGPIO
    property int taille:146
    signal modifTaille(int taille)
    function setParam(idGPIO,value,timeout)
    {
        cbGPIO.setIndice(idGPIO);
        teGPIO.text = value
        teTimeout.text = timeout
    }

    RetourGPIO
    {
        id:retourGPIO
    }

    ListModel
    {
        id:listGPIO
        ListElement{ nom:"Avant gauche Noir"  }
        ListElement{ nom:"1"  }
        ListElement{ nom:"Jack rose"  }
        ListElement{ nom:"Avant droit Noir"  }
        ListElement{ nom:"Switch avant dernier noir"  }
        ListElement{ nom:"Switch cube milieu Noir"  }
        ListElement{ nom:"Switch couleur noir"  }
        ListElement{ nom:"Jack noir"  }
    }

    Text {
        id: textGPIO
        text: qsTr("Nom GPIO :")
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

    CustomComboBox
    {
        id: cbGPIO
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textGPIO.bottom
        anchors.topMargin: 2
        _model: listGPIO
        onCustomCurrentIndexChanged:
        {
            retourGPIO.idGPIO = indice
        }
    }

    Rectangle
    {
        id: tfGpio
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbGPIO.bottom
        anchors.topMargin: 3
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teGPIO
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                // dyna.idDyna = text
                retourGPIO.valueGPIO = text
            }
        }
    }

    Text {
        id: texTimeout
        text: qsTr("Timeout :")
        anchors.left: parent.left
        visible: true
        anchors.leftMargin: 5
        font.pixelSize: 12
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.top: tfGpio.bottom
        anchors.rightMargin: 5
        font.bold: true
    }

    Rectangle {
        id: tfTimeout
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.left: parent.left
        anchors.leftMargin: 5
        visible: true
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.top: texTimeout.bottom
        anchors.rightMargin: 5
        TextEdit {
            id: teTimeout
            height: 30
            color: "#ffffff"
            text: qsTr("5000")
            anchors.fill: parent
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            onTextChanged: retourGPIO.timeOut = text
        }
    }
}
