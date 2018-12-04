import QtQuick 2.0
import "TypeAction"

Item {
    signal iFTailleChange(int taille)
    signal finCreation(var bloc)
    property int typeBloc:-1
    width: 116
    height: 220
    z:1
    property string _couleur:"#655e5e"
    Component.onCompleted:
    {
        createSpriteObjects(typeBloc,0,0)
    }

    Rectangle
    {
        id: rectangle //655e5e
        color: "#655e5e"
        border.color: _couleur
        border.width: 3
        opacity: 0.8 //655e5e
        anchors.fill: parent
    }

    property var component;
    property var sprite;

    function createSpriteObjects(type, x, y) {

        switch(type)
        {
        case -1: //Init
            break;
        case 0: //Servomoteur
        {
            component = Qt.createComponent("TypeAction/BlocServo.qml");
            break;
        }
        case 1: //Dynamixel
        {
            component = Qt.createComponent("TypeAction/BlocDyna.qml");
            break;
        }
        case 2: //Capteur
        {
            component = Qt.createComponent("TypeAction/BlocCapteur.qml");
            break;
        }
        case 3: //Moteur
        {
            component = Qt.createComponent("TypeAction/BlocMoteur.qml");
            break;
        }
        case 4: //Autre
        {
            component = Qt.createComponent("TypeAction/BlocAutre.qml");
            break;
        }
        case 5: //Position
        {
            component = Qt.createComponent("TypeAction/BlocPosition.qml");
            break;
        }
        case 6: //Orientation
        {
            component = Qt.createComponent("TypeAction/BlocOrientation.qml");
            break;
        }
        case 7: //Sequence
        {
            component = Qt.createComponent("TypeAction/BlocSequence.qml");
            break;
        }
        case 9: //Depart Sequence
        {
            //component = Qt.createComponent("Point.qml");
            break;
        }
        }
        if(type!==-1)
        {
            if (component.status === Component.Ready)
                finishCreation(type, x,y);
            else
                component.statusChanged.connect(finishCreation(x,y));
        }


    }

    function finishCreation(type, x, y) {

        if (component.status == Component.Ready) {
            x = parseInt(x);
            y = parseInt(y);
            sprite = component.createObject(rectangle, {"x": 0, "y": 0});
            if (sprite === null) {
                // Error Handling
                console.log("Error creating object");
            }else
            {
                sprite.anchors.fill = rectangle;
                sprite.modifTaille.connect(modifTaille)
                modifTaille(70)
                finCreation(sprite.fils)

            }

        } else if (component.status == Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    function modifTaille(taille)
    {
        iFTailleChange(taille)
    }



}
