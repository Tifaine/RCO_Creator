import QtQuick 2.7
import QtQuick.Controls 2.1
import "../Composant"
//import gestServo 1.0

Item {
    id:root
    width: 116
    height: 175
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    signal servoTailleChange(int taille)
    Component.onCompleted:
    {
        root.state = "ferme"
        servoTailleChange(70)
        for(var i = 0; i< gestServo.getNbServo();i++)
        {
            listServo.insert(0,{"nom": gestServo.getNomServo(i)})
        }

        if(listServo.count>0)
        {
            tfId.visible = false;
            textValue.anchors.top = cbId.bottom
            for(var i = 0; i< gestServo.getNbAction(0);i++)
            {
                listValue.insert(0,{"nom": gestServo.getNomAction(0,i)+(" ("+gestServo.getIdAction(0,i)+") ")})
            }

            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false
                textTimeOut.anchors.top = cbValue.bottom
            }

        }
    }

    function willDelete()
    {
        gestServo.mustDelete();
    }

   /* GestionServo
    {
        id:gestServo
    }*/

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

    ListModel
    {
        id:listServo
        ListElement{ nom:"Custom..."  }
    }
    ListModel
    {
        id:listValue
        ListElement{ nom:"Custom..."  }
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
        _model: listServo
        onCustomCurrentIndexChanged:
        {
            if(indice === listServo.count-1)
            {

                if(tfId.visible===false)
                {
                    tfId.visible = true;
                    textValue.anchors.top = tfId.bottom
                    servoTailleChange(root.height+tfId.height+5)
                }
            }else
            {
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    textValue.anchors.top = cbId.bottom
                    servoTailleChange(root.height-tfId.height-5)
                }
            }

            if(indice === listServo.count-1)
            {
                listValue.clear()
                listValue.insert(0,{"nom": "Custom..."})
            }else
            {
                listValue.clear()
                for(var i = 0; i< gestServo.getNbAction(indice);i++)
                {
                    listValue.insert(0,{"nom": gestServo.getNomAction(indice,i)+(" ("+gestServo.getIdAction(indice,i)+") ")})
                }
                listValue.append({"nom": "Custom..."})
            }

            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false
                textTimeOut.anchors.top = cbValue.bottom
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
        _model: listValue
        onCustomCurrentIndexChanged:
        {
            if(indice === listValue.count-1)
            {

                if(tfValue.visible===false)
                {
                    tfValue.visible = true;
                    tfValueEnable = true
                    textTimeOut.anchors.top = tfValue.bottom
                    servoTailleChange(root.height+tfValue.height+5)
                }
            }else
            {
                if(tfValue.visible===true)
                {
                    tfValue.visible = false;
                    tfValueEnable = false
                    textTimeOut.anchors.top = cbValue.bottom
                    servoTailleChange(root.height-tfValue.height-5)
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
        id: textTimeOut
        text: qsTr("TimeOut :")
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

    TextField {
        id: tfTimeOut
        height: 30
        text: qsTr("0")
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textTimeOut.bottom
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
                    servoTailleChange(tailleToSend+tfId.height+5)
                }else
                {
                    servoTailleChange(tailleToSend)
                }
            }else
            {

                root.state = "ouvert"
                button.text = "^"
                var tailleToSend = 175
                if(tfValueEnable===true)tailleToSend+=tfValue.height+5
                if(tfId.visible===true)tailleToSend+=tfId.height+5;
                servoTailleChange(tailleToSend)
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
                target: tfTimeOut
                visible: true
            }

            PropertyChanges {
                target: textTimeOut
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
                target: tfValue
                visible: false
            }

            PropertyChanges {
                target: root
                height: 80
            }

            PropertyChanges {
                target: textTimeOut
                visible: false
            }

            PropertyChanges {
                target: tfTimeOut
                visible: false
            }
        }
    ]
}
