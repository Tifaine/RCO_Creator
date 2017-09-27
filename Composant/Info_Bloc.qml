import QtQuick 2.0
import QtQuick.Controls 2.2

import QtQuick.Controls.Styles 1.4
import "../Image"
import "../configAction"
Item {
    id:root
    width: 116
    height: 220
    signal tailleChange(int taille)
    property string _couleur:"#655e5e"


    Rectangle {

        id: rectangle //655e5e
        color: "#655e5e"
        border.color: _couleur
        border.width: 3
        opacity: 0.8 //655e5e
        anchors.fill: parent

        BlocDyna
        {
            id:blocDyna
            visible:false
            anchors.fill: parent
            onDynaTailleChange:
            {
                tailleChange(taille)
            }
        }
        BlocServo
        {
            id:blocServo
            visible:false
            anchors.fill: parent
            onServoTailleChange:
            {
                tailleChange(taille)
            }
        }
        BlocCapteur
        {
            id:blocCapteur
            visible:false
            anchors.fill: parent
            onCapteurTailleChange:
            {
                tailleChange(taille)
            }
        }
        BlocMoteur
        {
            id:blocMoteur
            visible:false
            anchors.fill: parent
            onMoteurTailleChange:
            {
                tailleChange(taille)
            }
        }
        BlocAutre
        {
            id:blocAutre
            visible:false
            anchors.fill: parent
            onAutreTailleChange:
            {
                tailleChange(taille)
            }
        }

        BlocPosition
        {
            id:blocPosition
            visible:false
            anchors.fill: parent
            onPositionTailleChange:
            {
                tailleChange(taille)
            }
        }
        BlocOrientation
        {
            id:blocOrientation
            visible:false
            anchors.fill: parent
            onOrientationTailleChange:
            {
                tailleChange(taille)
            }
        }
    }

    function setType(type)
    {
        switch(type)
        {
        case 0:
        {
            blocServo.visible = true
            break;
        }
        case 1:
        {
            blocDyna.visible = true;
            break;
        }
        case 2:
        {
            blocCapteur.visible = true;
            break;
        }
        case 3:
        {
            blocMoteur.visible = true;
            break;
        }
        case 4:
        {
            blocAutre.visible = true
            break;
        }
        case 5:
        {
            blocPosition.visible = true
            break;
        }
        case 6:
        {
            blocOrientation.visible = true
            break;
        }
        }
    }
}
