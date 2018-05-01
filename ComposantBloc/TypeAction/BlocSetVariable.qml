import QtQuick 2.5
import "../../Composant"
import actionSetVariable 1.0

Item {
    id:root
    width: 116
    height: 220
    property int taille:220
    signal modifTaille(int taille)
    property var fils:setVar
    Component.onCompleted:
    {
        modifTaille(220)
    }

    function setParam(nomVar, nomRobot, nomOpe, value)
    {
        teVariable.text = value;
        cbVariable.setIndice(nomVar);
        cbRobot.setIndice(nomRobot);
        cbOperation.setIndice(nomOpe);
    }
    SetVariable
    {
        id:setVar
    }
    Text {
        id: textVariable
        text: qsTr("Nom Variable :")
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: true
        font.bold: true

        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 12
    }



    ListModel
    {
        id:listVariable
        ListElement{ nom:"Checkpoints"  }
        ListElement{ nom:"Score"  }
        ListElement{ nom:"André"  }
        ListElement{ nom:"Bernadette"  }
        ListElement{ nom:"Carlos"  }
        ListElement{ nom:"Daniella"  }
        ListElement{ nom:"Eddy"  }
        ListElement{ nom:"Fernande"  }
        ListElement{ nom:"Gaston"  }
        ListElement{ nom:"HADRIEEEEEEENNE"  }


    }
    CustomComboBox
    {
        id: cbVariable
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textVariable.bottom
        anchors.topMargin: 2
        _model: listVariable
        onCustomCurrentIndexChanged:
        {
            setVar.nomVar = indice
        }
    }

    Text {
        id: textNomRobot
        x: -7
        y: -7
        text: qsTr("Nom Robot :")
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.right: parent.right
        visible: true
        anchors.rightMargin: 5
        anchors.top: cbVariable.bottom
        anchors.leftMargin: 5
        font.pixelSize: 12
        font.bold: true
    }

    ListModel
    {
        id:listRobot
        ListElement{ nom:"Moi"  }
        ListElement{ nom:"L'autre"  }
    }
    CustomComboBox {
        id: cbRobot
        x: -7
        y: -7
        height: 30
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: textNomRobot.bottom
        _model: listRobot
        anchors.leftMargin: 5
        onCustomCurrentIndexChanged:
        {
            setVar.nomRobot = indice
        }
    }

    Text {
        id: textOperation
        x: -4
        y: -4
        text: qsTr("Opération :")
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.right: parent.right
        visible: true
        anchors.rightMargin: 5
        anchors.top: cbRobot.bottom
        font.pixelSize: 12
        anchors.leftMargin: 5
        font.bold: true
    }

    ListModel
    {
        id:listOperation
        ListElement{ nom:"Set"  }
        ListElement{ nom:"Addition"  }
        ListElement{ nom:"Soustraction"  }
        ListElement{ nom:"Multiplication"  }
        ListElement{ nom:"Division"  }
    }
    CustomComboBox {
        id: cbOperation
        x: -4
        y: -4
        height: 30
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: textOperation.bottom
        _model: listOperation
        anchors.leftMargin: 5
        onCustomCurrentIndexChanged:
        {
            setVar.nomOperation = indice
        }
    }

    Rectangle
    {
        id: tfVariable
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbOperation.bottom
        anchors.topMargin: 3
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teVariable
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                setVar.variable = text
            }
        }
    }
}
