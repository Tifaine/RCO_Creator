import QtQuick 2.5
import retourVariable 1.0
import "../../Composant"

Item {
    id:root
    width: 116
    height: 270
    property int taille:270
    signal modifTaille(int taille)
    property var fils:retVar
    Component.onCompleted:
    {
        modifTaille(270)
    }

    function setParam(nomVar, nomRobot, nomOpe, value, timeout)
    {
        teVariable.text = value;
        cbVariable.setIndice(nomVar);
        cbRobot.setIndice(nomRobot);
        cbOperation.setIndice(nomOpe-1);
        tfTimeOut.text = timeout
    }

    RetourVar
    {
        id:retVar
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
        ListElement{ nom:"Cube dans chatte"  }
        ListElement{ nom:"Attente autre robot"  }
        ListElement{ nom:"Cube bloqué"  }
        ListElement{ nom:"Daniella"  }//5
        ListElement{ nom:"Eddy"  }
        ListElement{ nom:"Fernande"  }
        ListElement{ nom:"Gaston"  }
        ListElement{ nom:"HADRIEEEEEEENNE"  }//9
        ListElement{ nom:"Lidar arriere gauche"  }
        ListElement{ nom:"Lidar arriere droite"  }
        ListElement{ nom:"Lidar avant gauche"  }
        ListElement{ nom:"Lidar avant droite"}//13
        ListElement{ nom:"X robot"  }
        ListElement{ nom:"Y robot"  }
        ListElement{ nom:"Orientation robot"}//16

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
            retVar.nomVar = indice
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
            retVar.nomRobot = indice
        }
    }
    Text {
        id: textOperation

        text: qsTr("Condition :")
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
        ListElement{ nom:"<"  }
        ListElement{ nom:"=="  }
        ListElement{ nom:">"  }
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
            retVar.nomCondition = indice+1
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
                retVar.variable = text
            }
        }
    }

    Text {
        id: textTimeout
        x: -3
        y: 1
        text: qsTr("TimeOut :")
        anchors.left: parent.left
        anchors.top: tfVariable.bottom
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
            onTextChanged: retVar.timeOut = text
        }
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
    }
}
