import QtQuick 2.0
import QtQuick.Controls 2.2

import QtQuick.Controls.Styles 1.4
import "../Image"
Item {
    id:root
    width: 116
    height: 250
    signal tailleChange(int taille)



    Rectangle {

        id: rectangle //655e5e
        color: "#655e5e"
        opacity: 0.8 //655e5e
        anchors.fill: parent
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
            _model: [ "Banana", "Apple", "Coconut" ]
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
        }

        Text {
            id: textValue
            text: qsTr("Value :")
            font.bold: true
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: tfId.bottom
            anchors.topMargin: 5
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
            _model: [ "Banana", "Apple", "Coconut" ]

        }

        TextField {
            id: tfValue
            height: 30
            text: qsTr("Text Field")
            visible: false
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: cbValue.bottom
            anchors.topMargin: 5
        }

        Text {
            id: textVitesse
            text: qsTr("Vitesse :")
            visible: false
            font.bold: true
            anchors.top: tfValue.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            font.pixelSize: 12
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
        }

        Button {
            id: buttonExtand
            x: -218
            width: 20
            height: 20
            text: qsTr("Button")
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 2

            property int nbClic :0
            onClicked:
            {
                if(nbClic ===0)
                {
                    nbClic = 1;
                    tailleChange(30)
                }else
                {
                    if(root.state === "Dyna")
                    {
                        tailleChange(350)

                    }else
                    {
                        tailleChange(250)
                    }
                    nbClic = 0;
                }
            }
        }

        CustomComboBox {
            id: cbVitess
            x: -297
            y: 151
            height: 30
            visible: false
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: textVitesse.bottom
            anchors.topMargin: 5
            _model: [ "Banana", "Pear", "Coconut" ]

        }

        Text {
            id: textTimout
            text: qsTr("Timeout :")
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: tfValue.bottom
            anchors.topMargin: 5
            font.bold: true
            font.pixelSize: 12
        }

        TextField {
            id: tfTimeout
            height: 30
            text: qsTr("1000")
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: textTimout.bottom
            anchors.topMargin: 5
        }
    }


    states: [
        State {
            name: "Dyna"

            PropertyChanges {
                target: root
                height: 350
            }

            PropertyChanges {
                target: textTimout
                anchors.topMargin: 105
            }

            PropertyChanges {
                target: textVitesse
                visible: true
            }

            PropertyChanges {
                target: cbVitess
                visible: true
            }
        }
    ]

}
