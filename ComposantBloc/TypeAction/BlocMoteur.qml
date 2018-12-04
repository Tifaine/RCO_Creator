import QtQuick 2.7
import QtQuick.Controls 2.1
import actionMoteur 1.0
import "../../Composant"

Item {
    id:root
    width: 116
    height: 125
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    signal modifTaille(int taille)
    property int taille:125
    property var fils:moteur

    function setParam(idMoteur,value)
    {
        cbMoteur.setIndice(idMoteur);
        teValue.text = value
    }

    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);

    }
    Component.onCompleted:
    {
        tailleChange(125)
    }

    Moteur
    {
        id:moteur
    }

    Text {
        id: textMoteur
        text: qsTr("Id :")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    ListModel
    {
        id:listMoteur
        ListElement{ nom:"Gauche"  }
        ListElement{ nom:"Droite"  }
    }

    CustomComboBox
    {
        id: cbMoteur
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textMoteur.bottom
        anchors.topMargin: 5
        _model: listMoteur
        onCustomCurrentIndexChanged:
        {
            moteur.idMoteur = indice
        }

    }

    Text {
        id: textValue
        text: qsTr("Value :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbMoteur.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    Rectangle
    {
        id: tfValue
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textValue.bottom
        anchors.topMargin: 3
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teValue
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                // dyna.idDyna = text
                moteur.valueMoteur = text
            }
        }
    }

}
