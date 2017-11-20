import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../Composant"
import actionAutre 1.0

Item {
    id:root
    width: 116
    height: 130
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    property int taille:70
    property var fils:autre
    signal modifTaille(int taille)

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

    Autre
    {
        id:autre
    }

    Text {
        id: textId
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

    CustomComboBox
    {
        id: cbId
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textId.bottom
        anchors.topMargin: 5
        _model: [ "Bras Droit", "bras Gauche", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 2)
            {

                if(tfId.visible===false)
                {
                    tfId.visible = true;
                    textValue.anchors.top = tfId.bottom
                    tailleChange(root.height+tfId.height+5)
                }
            }else
            {
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    textValue.anchors.top = cbId.bottom
                    tailleChange(root.height-tfId.height-5)
                }
            }
        }
    }

    TextField {
        id: tfId
        x: 5
        y: 171
        height: 30
        text: qsTr("0")
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbId.bottom
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
        anchors.top: cbId.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    CustomComboBox {
        id: cbValue
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textValue.bottom
        anchors.topMargin: 5
        _model: [ "Ouvert", "Fermé", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 2)
            {

                if(tfValue.visible===false)
                {
                    tfValue.visible = true;
                    tfValueEnable = true
                    tailleChange(root.height+tfValue.height+5)
                }
            }else
            {
                if(tfValue.visible===true)
                {
                    tfValue.visible = false;
                    tfValueEnable = false
                    tailleChange(root.height-tfValue.height-5)
                }
            }
        }
    }

    TextField {
        id: tfValue
        height: 30
        text: qsTr("1000")
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbValue.bottom
        anchors.topMargin: 5
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
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
                root.state = "ferme"
                button.text = "v"

                var tailleToSend = 70
                if(tfId.visible === true)
                {
                    tailleChange(tailleToSend+tfId.height+5)
                }else
                {
                    tailleChange(tailleToSend)
                }
            }else
            {

                root.state = "ouvert"
                button.text = "^"
                var tailleToSend = 130
                if(tfValueEnable===true)tailleToSend+=tfValue.height+5
                if(tfId.visible===true)tailleToSend+=tfId.height+5;
                tailleChange(tailleToSend)
                nbClic = 0;
            }
        }
    }


    states: [
        State {
            name: "ouvert"

            PropertyChanges {
                target: cbId
                visible: true
            }

            PropertyChanges {
                target: textValue
                visible: true
            }

            PropertyChanges {
                target: cbValue
                visible: true
            }

            PropertyChanges {
            }
        },
        State {
            name: "ferme"

            PropertyChanges {
                target: textValue
                visible: false
            }

            PropertyChanges {
                target: cbValue
                visible: false
            }

            PropertyChanges {
                target: tfValue
                visible: false
            }

            PropertyChanges {
                target: root
                height: 80
            }
        }
    ]
}
