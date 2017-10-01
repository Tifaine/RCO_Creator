import QtQuick 2.7
import QtQuick.Controls 2.1
import "../Composant"

Item {
    id:root
    width: 116
    height: 175
    property string nomSequence:" ";
    property bool tfValueEnable:false
    property bool tfVitesseEnable:false
    signal sequenceTailleChange(int taille)
    signal afficheTab(string nom);


    Component.onCompleted:
    {
        root.state = "ferme"
        sequenceTailleChange(70)

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
                nomSequence = tfId.text
                sequenceTailleChange(root.height+tfId.height+5)
            }
        }else
        {
            nomSequence = listSequence.get(0)._nomSeq
            if(tfId.visible===true)
            {
                tfId.visible = false;
                sequenceTailleChange(root.height-tfId.height-5)
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
                    nomSequence = tfId.text
                    sequenceTailleChange(root.height+tfId.height+5)
                }
            }else
            {
                nomSequence = listSequence.get(0)._nomSeq
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    sequenceTailleChange(root.height-tfId.height-5)
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
                afficheTab(nomSequence)
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
                    nomSequence = tfId.text
                    sequenceTailleChange(root.height+tfId.height+5)
                }
            }else
            {

                nomSequence = listSequence.get(indice)._nomSeq
                if(tfId.visible===true)
                {
                    tfId.visible = false;
                    sequenceTailleChange(root.height-tfId.height-5)
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
}
