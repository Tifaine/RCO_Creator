import QtQuick 2.7
import QtQuick.Controls 2.1
import "../../Composant"
import attenteDyna 1.0

Item {
    id:root
    width: 116
    height: 175
    property bool tfValueEnable:false
    signal modifTaille(int taille)
    property int taille:70
    property var fils:attente

    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);
    }

    AttenteDyna
    {
        id:attente
    }

    Component.onCompleted:
    {
        root.state = "ferme"
        tailleChange(70)
        listDyna.clear();
        for(var i = 0; i< gestDyna.getNbDyna();i++)
        {
            listDyna.insert(listDyna.count,{"nom": gestDyna.getNomDyna(i)})
        }
        listDyna.insert(listDyna.count,{"nom": "Custom..."})

        if(listDyna.count>0)
        {
            tfId.visible = false;
            textValue.anchors.top = cbId.bottom
            listValue.clear()
            for(var i = 0; i< gestDyna.getNbAction(0);i++)
            {
                listValue.insert(listValue.count,{"nom": gestDyna.getNomAction(0,i)+(" ("+gestDyna.getValAction(0,i)+") ")})
            }
            listValue.insert(listValue.count,{"nom": "Custom..."})

            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false
                textTimeOut.anchors.top = cbValue.bottom
            }
        }
        if(gestDyna.getNbDyna()>0)
        {
            attente.nomDyna = gestDyna.getNomDyna(0);
            attente.idDyna = gestDyna.getIdDyna(0);

            if(gestDyna.getNbAction(0)>0)
            {
                attente.valueDyna = gestDyna.getValAction(0,0);
            }
        }
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
        id:listDyna
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
        _model: listDyna
        onCustomCurrentIndexChanged:
        {
            if(indice === listDyna.count-1)
            {
                if(tfId.visible===false)
                {
                    tfId.visible = true;
                    textValue.anchors.top = tfId.bottom
                    tailleChange(root.height+tfId.height+5)
                }

                attente.idDyna=-1;
                attente.nomDyna="custom";
                attente.valueDyna=-1;
            }else
            {
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    textValue.anchors.top = cbId.bottom
                    tailleChange(root.height-tfId.height-5)
                }
                attente.idDyna =gestDyna.getIdDyna(indice);
                attente.nomDyna=gestDyna.getNomDyna(indice);

                if(gestDyna.getNbAction(indice)>0)
                {
                    attente.valueDyna=gestDyna.getValAction(indice,0);
                }else
                {
                    attente.valueDyna=0;
                }
            }

            if(indice === listDyna.count-1)
            {
                listValue.clear()
                listValue.insert(0,{"nom": "Custom..."})
            }else
            {
                listValue.clear()
                for(var i = 0; i< gestDyna.getNbAction(indice);i++)
                {
                    listValue.insert(listValue.count,{"nom": gestDyna.getNomAction(indice,i)+(" ("+gestDyna.getValAction(indice,i)+") ")})
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
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                attente.idDyna = text
            }
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
                    tailleChange(root.height+tfValue.height+5)
                }
                attente.valueDyna = tfVal.text;
            }else
            {
                if(tfValue.visible===true)
                {
                    tfValue.visible = false;
                    tfValueEnable = false
                    textTimeOut.anchors.top = cbValue.bottom
                    tailleChange(root.height-tfValue.height-5)
                }
                attente.valueDyna = gestDyna.getValAction(cbId.indice,indice)
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
                attente.valueDyna = text
            }
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

    Rectangle
    {
        id: tfTimeOut
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textTimeOut.bottom
        anchors.topMargin: 5
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teTimeOut
            height: 30
            text: qsTr("5000")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged: attente.timeOut = text
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
                var tailleToSend = 175
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
