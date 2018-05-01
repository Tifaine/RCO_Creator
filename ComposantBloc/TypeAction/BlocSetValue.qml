import QtQuick 2.0
import "../../Composant"
import actionSetValeur 1.0
Item {
    id:root
    width: 116
    height: 84

    property var fils:setValeur
    property int taille:84
    signal modifTaille(int taille)

    function setParam(id,value)
    {
        if(id>0 && id <6)
        {
            cbCapteur.setIndice(id-1)
            teCapteur.text = value
        }
    }


    SetValeur{
        id:setValeur;
    }

    Text {
        id: textCapteur
        text: qsTr("Paramètres :")
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
        id:listCap
        ListElement{ nom:"X robot"  }
        ListElement{ nom:"Y robot"  }
        ListElement{ nom:"Orientation"  }
        ListElement{ nom:"Vitesse linéaire"  }
        ListElement{ nom:"Vitesse angulaire"  }
        ListElement{ nom:"Désactiver détection"  }
        ListElement{ nom:"Activer lidar"  }
    }

    CustomComboBox
    {
        id: cbCapteur
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textCapteur.bottom
        anchors.topMargin: 1
        _model: listCap
        onCustomCurrentIndexChanged:
        {
            setValeur.idValeur = indice+1
        }
    }

    Rectangle
    {
        id: tfCapteur
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbCapteur.bottom
        anchors.topMargin: 3
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:teCapteur
            height: 30
            text: qsTr("0")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                // dyna.idDyna = text
                setValeur.valueValeur = text
            }
        }
    }
}
