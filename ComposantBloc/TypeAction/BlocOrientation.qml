import QtQuick 2.0
import QtQuick.Controls 2.2
import actionOrientation 1.0

Item {
    width: 186
    height: 182
    id:root
    property int taille:70
    signal modifTaille(int taille)
    property var fils:orientation
    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);

    }
    function setParam(orien)
    {
        tfAngle.text = orien

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
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 17
            font.pixelSize: 12
        }

        Rectangle {
            id: rectangle3
            color: "black"
            anchors.right: parent.right
            anchors.rightMargin: 79
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 79
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
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 17
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
                var tailleToSend = 182
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
        }
    ]
}
