import QtQuick 2.7
import QtQuick.Controls 2.1
import actionSequence 1.0
import "../../Composant"

Item {
    id:root
    width: 116
    height: 175
    property string nomSequence:" ";
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    property var fils:sequence
    signal modifTaille(int taille)
    property int taille:70
    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);
    }
    function setParam(nomSequ)
    {
        var nomFound = false
        for(var i=0;i<gestSequence.getNbFile();i++)
        {
            if(nomSequ === gestSequence.getNameFile(i))
            {
                nomFound = true
                cbId.setIndice(i)
            }
        }
        if(nomFound === false)
        {
            tfNomSeq.text = nomSequ
            cbId.indice = listSequence.count - 1
            tfId.visible = true;
        }
    }
    signal afficheTab(string nom);

    Sequence
    {
        id:sequence
        _nomSequence: nomSequence
    }

    Component.onCompleted:
    {
        root.state = "ferme"
        listSequence.clear()
        for(var i=0;i<gestSequence.getNbFile();i++)
        {
            listSequence.append({"_nomSeq": gestSequence.getNameFile(i)})
        }
        listSequence.append({"_nomSeq":"Custom..."})

        if(listSequence.count===1)
        {
            if(tfId.visible===false)
            {
                tfId.visible = true;
                nomSequence = tfNomSeq.text
                tailleChange(95)
            }
        }else
        {
            nomSequence = listSequence.get(0)._nomSeq
            if(tfId.visible===true)
            {
                tfId.visible = false;
                tailleChange(70)
            }
        }
    }

    Connections
    {
        target:gestSequence
        onChange:
        {
            listSequence.clear()
            for(var i=0;i<gestSequence.getNbFile();i++)
            {
                listSequence.append({"_nomSeq": gestSequence.getNameFile(i)})
            }
            listSequence.append({"_nomSeq":"Custom..."})

            if(listSequence.count===1)
            {
                if(tfId.visible===false)
                {
                    tfId.visible = true;
                    nomSequence = tfNomSeq.text
                    tailleChange(95)
                }
            }else
            {
                nomSequence = listSequence.get(0)._nomSeq
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    tailleChange(70)
                }
            }


        }
    }

    MouseArea
    {
        id:mouseArea3

        anchors.fill: parent
        propagateComposedEvents:true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onDoubleClicked:
        {
            if(mouse.button === Qt.LeftButton)
            {
                gestSequence.afficheTab(nomSequence)
            }
        }
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
        id:listSequence

        ListElement{ _nomSeq:"Init" }
        ListElement{ _nomSeq:"Prise eau verte" }
        ListElement{ _nomSeq:"Prise eau orange" }
        ListElement{ _nomSeq:"Custom..." }
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
        _model: listSequence
        onCustomCurrentIndexChanged:
        {
            if(indice === listSequence.count-1)
            {
                if(tfId.visible===false)
                {
                    tfId.visible = true;
                    nomSequence = tfNomSeq.text
                    tailleChange(95)
                }
            }else
            {
                nomSequence = listSequence.get(indice)._nomSeq
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    tailleChange(70)
                }
            }
        }
    }

    Rectangle
    {
        id: tfId
        height: 30
        radius:7
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbId.bottom
        anchors.topMargin: 5

        color:"#4a4545"

        TextEdit
        {
            id:tfNomSeq
            height: 30
            text: qsTr("800")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                nomSequence = text
            }
        }
    }
}
