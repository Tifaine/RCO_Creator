import QtQuick 2.0
import QtQuick.Controls 2.2
import actionOrientation 1.0
import "../../Composant"

Item {
    width: 200
    height: 350
    id:root
    property int taille:70
    signal modifTaille(int taille)
    property var fils:orientation
    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);

    }
    function setParam(orien, precision, timeout, vitesse)
    {
        tfAngle.text = orien
        tfPrecision.text = precision
        tfTimeOut.text = timeout

        switch(vitesse)
        {
        case "1000":
            cbVitesse.setIndice(0);
            break;
        case "700":
            cbVitesse.setIndice(1);
            break;
        case "300":
            cbVitesse.setIndice(2);
            break;
        default:
            cbVitesse.setIndice(3);
            tfVitesseEnable = true
            orientation.vitesse = true
            tfVitesse.visible = true
            tfVit.text = vitesse
            break;
        }
    }
    Component.onCompleted:
    {
        root.state = "ferme"
        tailleChange(60)
    }

    Orientation
    {
        id:orientation
        angle: tfAngle.text
    }

    Rectangle {
        id: rectangle2
        y: 128
        height: 90
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 13
        anchors.right: parent.right
        anchors.rightMargin: 13
        anchors.left: parent.left
        anchors.leftMargin: 13

        Text {
            id: text1
            x: 88
            text: qsTr("0°")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            font.pixelSize: 12
        }

        Text {
            id: text2
            height: 17
            text: qsTr("90°")
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 11
            anchors.left: parent.left
            anchors.leftMargin: 11
            font.pixelSize: 12
        }

        Rectangle {
            id: rectangle3
            width: 2
            color: "black"
            anchors.leftMargin: parent.width/2 -1
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: parent.left
        }

        Text {
            id: text3
            y: 83
            height: 17
            text: qsTr("-90°")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            horizontalAlignment: Text.AlignHCenter
            anchors.right: parent.right
            anchors.rightMargin: 11
            anchors.left: parent.left
            anchors.leftMargin: 11
            font.pixelSize: 12
        }

        Text {
            id: text4
            y: 42
            text: qsTr("180°")
            anchors.verticalCenterOffset: -11
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            font.pixelSize: 12
        }

        Rectangle {
            id: rectangle4
            x: -8
            y: 5
            color: "black"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 44
            anchors.bottomMargin: 44
        }


    }

    Text {
        id: textOrientation
        text: qsTr("Angle :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    TextField {
        id: tfAngle
        height: 30
        text: qsTr("180")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textOrientation.bottom
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
        id: textPreci
        x: 4
        text: qsTr("Précision :")
        anchors.left: parent.left
        anchors.top: tfAngle.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
        anchors.leftMargin: 5
    }

    Rectangle {
        id: tfPreci
        x: 1
        y: 5
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: textPreci.bottom
        visible: true
        TextEdit {
            id: tfPrecision
            height: 30
            color: "#ffffff"
            text: qsTr("3")
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            onTextChanged: orientation.precision = text
        }
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
    }

    Text {
        id: textVitesse
        text: qsTr("Vitesse :")
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: tfPreci.bottom
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
                    textTimeout.anchors.top = tfVitesse.bottom
                    tailleChange(root.height+tfVitesse.height+5)
                }
            }else
            {
                if(tfVitesse.visible===true)
                {

                    tfVitesseEnable = false
                    tfVitesse.visible = false;
                    textTimeout.anchors.top = cbVitesse.bottom
                    tailleChange(root.height-tfVitesse.height-5)
                }
            }
            switch(indice)
            {
            case 0:
                orientation.vitesse = 1000;
                break;
            case 1:
                orientation.vitesse = 700;
                break;
            case 2:
                orientation.vitesse = 300;
                break;
            case 3:
                orientation.vitesse = tfVit.text;
                break;
            }
        }
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
        anchors.top: cbVitesse.bottom
        anchors.topMargin: 5
        visible: false
        color:"#4a4545"

        TextEdit
        {
            id:tfVit
            height: 30
            text: qsTr("800")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                orientation.vitesse = text
            }
        }
    }

    Text {
        id: textTimeout
        x: -3
        y: 1
        text: qsTr("TimeOut :")
        anchors.left: parent.left
        anchors.top: cbVitesse.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
        anchors.leftMargin: 5
    }

    Rectangle {
        id: tfTimeout
        x: -6
        y: -2
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: textTimeout.bottom
        visible: true
        TextEdit {
            id: tfTimeOut
            height: 30
            color: "#ffffff"
            text: qsTr("5000")
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            onTextChanged: orientation.timeOut = text
        }
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
    }

    property bool tfVitesseEnable:false

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
                tailleChange(tailleToSend)

            }else
            {
                root.state = "ouvert"
                button.text = "^"

                if(cbVitesse.indice === 3)
                {
                    tfVit.visible = true
                }


                var tailleToSend = 330
                if(tfVitesseEnable===true)tailleToSend+=tfVitesse.height+5
                tailleChange(tailleToSend)
                nbClic = 0;
            }
        }
    }
    states: [
        State {
            name: "ouvert"
        },
        State {
            name: "ferme"

            PropertyChanges {
                target: rectangle2
                visible: false
            }

            PropertyChanges {
                target: textPreci
                visible: false
            }

            PropertyChanges {
                target: tfPreci
                visible: false
            }

            PropertyChanges {
                target: textTimeout
                visible: false
            }

            PropertyChanges {
                target: tfTimeout
                visible: false
            }

            PropertyChanges {
                target: tfVitesse
                visible: false
            }

            PropertyChanges {
                target: cbVitesse
                visible: false
            }

            PropertyChanges {
                target: textVitesse
                visible: false
            }
        }
    ]
}
