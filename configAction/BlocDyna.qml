import QtQuick 2.7
import QtQuick.Controls 2.1
import "../Composant"

Item {
    id:root
    width: 116
    height: 180
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    signal dynaTailleChange(int taille)
    Component.onCompleted:
    {
        root.state = "ferme"
        dynaTailleChange(70)
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
                    dynaTailleChange(root.height+tfId.height)
                }
            }else
            {
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    textValue.anchors.top = cbId.bottom
                    dynaTailleChange(root.height-tfId.height)
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
                    textVitesse.anchors.top = tfValue.bottom
                    dynaTailleChange(root.height+tfValue.height)
                }
            }else
            {
                if(tfValue.visible===true)
                {
                    tfValue.visible = false;
                    tfValueEnable = false
                    textVitesse.anchors.top = cbValue.bottom
                    dynaTailleChange(root.height-tfValue.height)
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

    Text {
        id: textVitesse
        text: qsTr("Vitesse :")
        visible: true
        font.bold: true
        anchors.top: cbValue.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }

    CustomComboBox {
        id: cbVitess
        x: -297
        y: 151
        height: 30
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textVitesse.bottom
        anchors.topMargin: 5
        _model: [ "Ouvert", "Fermé", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 2)
            {

                if(tfVitesse.visible===false)
                {
                    tfVitesse.visible = true;
                    tfVitesseEnable = true
                    dynaTailleChange(root.height+tfVitesse.height)
                }
            }else
            {
                if(tfVitesse.visible===true)
                {
                    tfVitesse.visible = false;
                    tfVitesseEnable = false
                    dynaTailleChange(root.height-tfVitesse.height)
                }
            }
        }

    }

    TextField {
        id: tfVitesse
        height: 30
        text: qsTr("0")
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbVitess.bottom
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
                    dynaTailleChange(tailleToSend+tfId.height)
                }else
                {
                    dynaTailleChange(tailleToSend)
                }
            }else
            {

                root.state = "ouvert"
                button.text = "^"
                var tailleToSend = 188
                if(tfValueEnable===true)tailleToSend+=tfValue.height
                if(tfVitesseEnable===true)tailleToSend+=tfVitesse.height
                if(tfId.visible===true)tailleToSend+=tfId.height;
                dynaTailleChange(tailleToSend)
                console.log(tailleToSend)

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

            PropertyChanges {
                target: cbVitess
                visible: true
            }

            PropertyChanges {
                target: textVitesse
                visible: true
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
                target: textVitesse
                visible: false
            }

            PropertyChanges {
                target: cbVitess
                visible: false
            }

            PropertyChanges {
                target: tfValue
                visible: false
            }

            PropertyChanges {
                target: tfVitesse
                visible: false
            }

            PropertyChanges {
                target: root
                height: 80
            }
        }
    ]
}
