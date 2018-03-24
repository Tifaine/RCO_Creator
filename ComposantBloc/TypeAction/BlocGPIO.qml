import QtQuick 2.5
import "../../Composant"
import actionGPIO 1.0

Item {
    id:root
    width: 116
    height: 84

    property var fils:actGPIO
    property int taille:84
    signal modifTaille(int taille)
    function setParam(idGPIO,value)
    {
        cbGPIO.setIndice(idGPIO);
        teGPIO.text = value
    }

    ActionGPIO
    {
        id:actGPIO
    }

    ListModel
    {
        id:listGPIO
        ListElement{ nom:"Jack"  }
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
            actGPIO.idGPIO = indice
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
                actGPIO.valueGPIO = text
            }
        }
    }
}
