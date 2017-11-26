import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../Composant"
import actionServo 1.0

Item {
    id:root
    width: 116
    height: 125
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    signal modifTaille(int taille)
    property int taille:70
    property var fils:servo

    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);
    }

    function setParam(id, value, nom)
    {
        var idFound = false;
        for(var i = 0; i< gestServo.getNbServo();i++)
        {
            if(gestServo.getNomServo(i) === nom)
            {
                cbId.setIndice(i);
                idFound = true
            }
        }
        if(idFound === false)
        {
            cbId.setIndice(listServo.count-1)

            servo.idServo=id;
            servo.nomServo="custom";
            servo.valueServo=value;
            teId.text = id
            tfValueEnable = true
            cbValue.setIndice(listValue.count-1);
            tfVal.text = value
            tfValue.visible = false
            var tailleToSend = 125
            tailleChange(tailleToSend)

        }else
        {
            var valFound = false
            for(var i = 0; i< gestServo.getNbAction(cbId.indice);i++)
            {
                if(gestServo.getValAction(cbId.indice,i) === parseInt(value))
                {
                    cbValue.setIndice(i)
                    valFound = true
                }
            }
            if(valFound === false)
            {
                servo.valueServo=value;
                cbValue.setIndice(listValue.count-1);
                tfVal.text = value
                tfValue.visible = false
            }
        }


    }

    Component.onCompleted:
    {
        root.state = "ferme"
        tailleChange(70)
        listServo.clear();
        for(var i = 0; i< gestServo.getNbServo();i++)
        {
            listServo.insert(listServo.count,{"nom": gestServo.getNomServo(i)})
        }
        listServo.insert(listServo.count,{"nom": "Custom..."})

        if(listServo.count>0)
        {
            tfId.visible = false;
            textValue.anchors.top = cbId.bottom
            listValue.clear()
            for(var i = 0; i< gestServo.getNbAction(0);i++)
            {
                listValue.insert(listValue.count,{"nom": gestServo.getNomAction(0,i)+(" ("+gestServo.getValAction(0,i)+") ")})
            }
            listValue.insert(listValue.count,{"nom": "Custom..."})

            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false
            }
        }
        if(gestServo.getNbServo()>0)
        {
            servo.nomServo = gestServo.getNomServo(0);
            servo.idServo = gestServo.getIdServo(0);

            if(gestServo.getNbAction(0)>0)
            {
                servo.valueServo = gestServo.getValAction(0,0);
            }
        }
    }

    Servo
    {
        id:servo
    }

    function willDelete()
    {
        gestServo.mustDelete();
    }

    Text {
        id: textId
        text: qsTr("Id :")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
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
                    tailleChange(root.height+tfId.height+5)
                }

                servo.idServo=-1;
                servo.nomServo="custom";
                servo.valueServo=-1;
            }else
            {
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    textValue.anchors.top = cbId.bottom
                    tailleChange(root.height-tfId.height-5)
                }
                servo.idServo=gestServo.getIdServo(indice);
                servo.nomServo=gestServo.getNomServo(indice);

                if(gestServo.getNbAction(indice)>0)
                {
                    servo.valueServo=gestServo.getValAction(indice,0);
                }else
                {
                    servo.valueServo=0;
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
                    listValue.insert(listValue.count,{"nom": gestServo.getNomAction(indice,i)+(" ("+gestServo.getValAction(indice,i)+") ")})
                }
                listValue.append({"nom": "Custom..."})
            }

            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false
            }

        }
    }

    Rectangle
    {
        id: tfId
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbId.bottom
        anchors.topMargin: 5
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teId
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                servo.idServo = text
            }
        }
    }



    Text {
        id: textValue
        text: qsTr("Angle :")
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
                    tailleChange(root.height+tfValue.height+5)
                }
                servo.valueServo = tfVal.text;
            }else
            {
                if(tfValue.visible===true)
                {
                    tfValue.visible = false;
                    tfValueEnable = false
                    tailleChange(root.height-tfValue.height-5)
                }
                servo.valueServo = gestServo.getValAction(cbId.indice,indice)
            }
        }
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
        anchors.top: cbValue.bottom
        anchors.topMargin: 5
        visible: false
        z:1
        color:"#4a4545"
        property string text:"0"

        TextEdit {
            id:tfVal
            height: 30
            verticalAlignment: Text.AlignVCenter
            text: qsTr("1000")
            anchors.leftMargin: 10

            anchors.fill: parent
            color: "white"
            onTextChanged:
            {
                servo.valueServo = text
            }
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
                if(cbValue.indice == (listValue.count-1))
                {
                    tfValue.visible = true
                }

                var tailleToSend = 125
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
