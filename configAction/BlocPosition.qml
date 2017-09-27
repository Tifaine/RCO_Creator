import QtQuick 2.0
import QtQuick.Controls 2.2
import "../Composant"

Item {
    id: root
    width: 180
    height: 275
    signal positionTailleChange(int taille)

    property bool tfVitesseEnable:false
    property bool tfAccEnable:false
    property bool tfDecEnable:false
    Component.onCompleted:
    {
        root.state = "ferme"
        positionTailleChange(60)
    }

    TextField {
        id: tfX
        width: 50
        height: 30
        text: qsTr("2000")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textX.bottom
        anchors.topMargin: 5
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    TextField {
        id: tfY
        x: 64
        width: 50
        height: 30
        text: qsTr("2000")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: textY.bottom
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
        id: textX
        text: qsTr("X :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    Text {
        id: textY
        x: 125
        text: qsTr("Y :")
        anchors.right: parent.right
        anchors.rightMargin: 41
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    Text {
        id: textVitesse
        text: qsTr("Vitesse :")
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: tfX.bottom
        anchors.topMargin: 5
        font.pixelSize: 12
    }

    CustomComboBox
    {
        id: cbVitesse
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textVitesse.bottom
        anchors.topMargin: 5
        _model: [ "Forte (1000 mm/s)", "Moyenne (700 mm/s)", "Faible (300 mm/s)", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 3)
            {
                if(tfVitesse.visible===false)
                {
                    tfVitesseEnable = true
                    tfVitesse.visible = true;
                    textAcc.anchors.top = tfVitesse.bottom
                    positionTailleChange(root.height+tfVitesse.height+5)
                }
            }else
            {
                if(tfVitesse.visible===true)
                {
                    tfVitesseEnable = false
                    tfVitesse.visible = false;
                    textAcc.anchors.top = cbVitesse.bottom
                    positionTailleChange(root.height-tfVitesse.height-5)
                }
            }
        }
    }

    TextField {
        id: tfVitesse
        height: 30
        text: qsTr("800")
        visible:false
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbVitesse.bottom
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
        id: textAcc
        text: qsTr("Accélération :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbVitesse.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }



    CustomComboBox
    {
        id: cbAcc
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textAcc.bottom
        anchors.topMargin: 5
        _model: [ "Forte (1000 mm/s)", "Moyenne (700 mm/s)", "Faible (300 mm/s)", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 3)
            {
                if(tfAcc.visible===false)
                {
                    tfAccEnable = true
                    tfAcc.visible = true;
                    textDec.anchors.top = tfAcc.bottom
                    positionTailleChange(root.height+tfAcc.height+5)
                }
            }else
            {
                if(tfAcc.visible===true)
                {
                    tfAccEnable = false
                    tfAcc.visible = false;
                    textDec.anchors.top = cbAcc.bottom
                    positionTailleChange(root.height-tfAcc.height-5)
                }
            }
        }
    }

    TextField {
        id: tfAcc
        height: 30
        text: qsTr("200")
        anchors.right: parent.right
        anchors.rightMargin: 5
        visible:false
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbAcc.bottom
        anchors.topMargin: 5
        horizontalAlignment: Text.AlignHCenter
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }



    Text {
        id: textDec
        text: qsTr("Décélération :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbAcc.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }



    CustomComboBox
    {
        id: cbDec
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textDec.bottom
        anchors.topMargin: 5
        _model: [ "Forte (1000 mm/s)", "Moyenne (700 mm/s)", "Faible (300 mm/s)", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 3)
            {
                if(tfDec.visible===false)
                {
                    tfDecEnable = true
                    tfDec.visible = true;
                    switchSens.anchors.top = tfDec.bottom
                    positionTailleChange(root.height+tfDec.height+5)
                }
            }else
            {
                if(tfDec.visible===true)
                {
                    tfDecEnable = false
                    tfDec.visible = false;
                    switchSens.anchors.top = cbDec.bottom
                    positionTailleChange(root.height-tfDec.height-5)
                }
            }
        }
    }

    TextField {
        id: tfDec
        height: 30
        visible:false
        text: qsTr("200")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbDec.bottom
        anchors.topMargin: 5
        horizontalAlignment: Text.AlignHCenter
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    Switch {
        id: switchSens
        text: qsTr("Marche avant")
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbDec.bottom
        anchors.topMargin: 5
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

                var tailleToSend = 60

                positionTailleChange(tailleToSend)

            }else
            {

                root.state = "ouvert"
                button.text = "^"
                var tailleToSend = 275
                if(tfVitesseEnable===true)tailleToSend+=tfVitesse.height+5
                if(tfAccEnable===true)tailleToSend+=tfAcc.height+5
                if(tfDecEnable===true)tailleToSend+=tfDec.height+5;
                positionTailleChange(tailleToSend)
                nbClic = 0;
            }
        }
    }
    states: [
        State {
            name: "ouvert"

            PropertyChanges {
                target: textVitesse
                visible: true
            }

            PropertyChanges {
                target: cbVitesse
                visible: true
            }

            PropertyChanges {
                target: textAcc
                visible: true
            }

            PropertyChanges {
                target: cbAcc
                visible: true
            }

            PropertyChanges {
                target: textDec
                visible: true
            }

            PropertyChanges {
                target: cbDec
                visible: true
            }

            PropertyChanges {
                target: switchSens
                visible: true
            }
        },
        State {
            name: "ferme"

            PropertyChanges {
                target: textVitesse
                visible: false
            }

            PropertyChanges {
                target: cbVitesse
                visible: false
            }

            PropertyChanges {
                target: tfVitesse
                visible: false
            }

            PropertyChanges {
                target: textAcc
                visible: false
            }

            PropertyChanges {
                target: cbAcc
                visible: false
            }

            PropertyChanges {
                target: tfAcc
                visible: false
            }

            PropertyChanges {
                target: textDec
                visible: false
            }

            PropertyChanges {
                target: cbDec
                visible: false
            }

            PropertyChanges {
                target: tfDec
                visible: false
            }

            PropertyChanges {
                target: switchSens
                visible: false
            }
        }
    ]
}
