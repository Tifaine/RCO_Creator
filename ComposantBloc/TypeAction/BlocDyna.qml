import QtQuick 2.7
import QtQuick.Controls 2.1
import actionDyna 1.0
import "../../Composant"

Item {
    id:root
    width: 116
    height: 182
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    signal modifTaille(int taille)
    property var fils:dyna
    property int taille:70
    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);

    }

    function setParam(id, value, vitesse, nom)
    {
        for(var i = 0; i< gestDyna.getNbDyna();i++)
        {
            if(gestDyna.getNomDyna(i) === nom)
            {
                cbId.setIndice(i);
            }
        }

        for(var i = 0; i< gestDyna.getNbAction(cbId.indice);i++)
        {
            if(gestDyna.getValAction(cbId.indice,i) === parseInt(value))
            {
               cbValue.setIndice(i)
            }
        }
        for(var i = 0; i< gestDyna.getNbVitesse(cbId.indice);i++)
        {
            if(gestDyna.getValVitesse(cbId.indice,i) === parseInt(vitesse))
            {
               cbVitess.setIndice(i)
            }
        }
    }


    Dyna
    {
        id:dyna
    }

    Component.onCompleted:
    {
        root.state = "ferme"
        tailleChange(70)
        listDyna.clear()
        for(var i = 0; i< gestDyna.getNbDyna();i++)
        {
            listDyna.insert(listDyna.count,{"nom": gestDyna.getNomDyna(i)})
        }
        listDyna.insert(listDyna.count,{"nom": "Custom..."})

        if(gestDyna.getNbDyna()>0)
        {
            tfId.visible = false;
            textValue.anchors.top = cbId.bottom
            listValue.clear()
            for(var i = 0; i< gestDyna.getNbAction(0);i++)
            {
                listValue.insert(listValue.count,{"nom": gestDyna.getNomAction(0,i)+(" ("+gestDyna.getValAction(0,i)+") ")})
            }
            listValue.insert(listValue.count,{"nom": "Custom..."})
            listVitesse.clear()
            for(var i = 0; i< gestDyna.getNbVitesse(0);i++)
            {
                listVitesse.insert(listVitesse.count,{"nom": gestDyna.getNomVitesse(0,i)+(" ("+gestDyna.getValVitesse(0,i)+") ")})
            }
            listVitesse.insert(listVitesse.count,{"nom": "Custom..."})
            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false

            }
            if(listVitesse.count>0)
            {
                tfVitesse.visible = false;
                tfVitesseEnable = false
            }
        }
    }

    Component.onDestruction:
    {

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
    ListModel
    {
        id:listVitesse
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

                dyna.idDyna = -1;
                dyna.nomDyna = "custom"
                dyna.ValueDyna = -1;
                dyna.vitesseDyna = -1;
            }else
            {
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    textValue.anchors.top = cbId.bottom
                    tailleChange(root.height-tfId.height-5)
                }

                dyna.idDyna = gestDyna.getIdDyna(indice);
                dyna.nomDyna = gestDyna.getNomDyna(indice);

                if(gestDyna.getNbAction(indice)>0)
                {
                    dyna.ValueDyna=gestDyna.getValAction(indice,0);
                }else
                {
                    dyna.ValueDyna=0;
                }

                if(gestDyna.getNbVitesse(indice) > 0 )
                {
                    dyna.vitesseDyna = gestDyna.getValVitesse(indice,0);
                }else
                {
                    dyna.vitesseDyna = 0;
                }
            }

            if(indice === listDyna.count-1)
            {
                listValue.clear()
                listValue.insert(0,{"nom": "Custom..."})

                listVitesse.clear();
                listVitesse.insert(0,{"nom": "Custom..."})


            }else
            {
                listValue.clear()
                for(var i = 0; i< gestDyna.getNbAction(indice);i++)
                {
                    listValue.insert(listValue.count,{"nom": gestDyna.getNomAction(indice,i)+(" ("+gestDyna.getValAction(indice,i)+") ")})
                }
                listValue.append({"nom": "Custom..."})

                listVitesse.clear()
                for(var i = 0; i< gestDyna.getNbVitesse(indice);i++)
                {
                    listVitesse.insert(listVitesse.count,{"nom": gestDyna.getNomVitesse(indice,i)+(" ("+gestDyna.getValVitesse(indice,i)+") ")})
                }
                listVitesse.append({"nom": "Custom..."})
            }

            if(listValue.count>0)
            {
                tfValue.visible = false;
                tfValueEnable = false
                textVitesse.anchors.top = cbValue.bottom
            }

            if(listVitesse.count>0)
            {
                tfVitesse.visible = false;
                tfVitesseEnable = false
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
        visible: false
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
                dyna.idDyna = text
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
                    textVitesse.anchors.top = tfValue.bottom
                    tailleChange(root.height+tfValue.height+5)
                }
                dyna.ValueDyna = tfValue.text
            }else
            {
                if(tfValue.visible===true)
                {
                    tfValue.visible = false;
                    tfValueEnable = false
                    textVitesse.anchors.top = cbValue.bottom
                    tailleChange(root.height-tfValue.height-5)
                }
                dyna.ValueDyna = gestDyna.getValAction(cbId.indice,indice);
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
                dyna.ValueDyna = text
            }
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
        _model: listVitesse
        onCustomCurrentIndexChanged:
        {
            if(indice === listVitesse.count-1)
            {

                if(tfVitesse.visible===false)
                {
                    tfVitesse.visible = true;
                    tfVitesseEnable = true
                    tailleChange(root.height+tfVitesse.height+5)
                }
                dyna.vitesseDyna = tfVitesse.text
            }else
            {
                if(tfVitesse.visible===true)
                {
                    tfVitesse.visible = false;
                    tfVitesseEnable = false
                    tailleChange(root.height-tfVitesse.height-5)
                }
                dyna.vitesseDyna = gestDyna.getValVitesse(cbId.indice, indice)
            }
        }

    }

    Rectangle
    {
        id: tfVitesse
        height: 30
        radius:7
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbVitess.bottom
        anchors.topMargin: 5
        color:"#4a4545"

        TextEdit
        {
            id:teVitesse
            height: 30
            text: qsTr("5000")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged: dyna.vitesseDyna = text
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
                    tailleChange(tailleToSend+tfId.height)
                }else
                {
                    tailleChange(tailleToSend)
                }
            }else
            {

                root.state = "ouvert"
                button.text = "^"
                var tailleToSend = 182
                if(tfValueEnable===true)tailleToSend+=tfValue.height+5
                if(tfVitesseEnable===true)tailleToSend+=tfVitesse.height+5
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
