import QtQuick 2.0
import QtQuick.Controls 1.4
import "../ComposantBloc"
import "../ComposantBloc/TypeAction"

Item {
    id:root
    property string title
    property int indice
    property int type
    property string _couleurInfoBloc : "#655e5e"

    property var listSortie_ : gridSortie
    property var listEntree_ : gridEntree
    property var bloc : null
    signal iWantToDie()
    signal creationComplete(var bloc)
    signal ajouterTab(var nom);
    signal click()
    signal xChange(int value)
    signal yChange(int value)

    property bool inhibeMoveXY :false
    property var listPere:null;
    property var listFils:null;
    property var listTimeOut:null;
    objectName: "BlocAction"
    width: 200
    height: 92

    Component.onCompleted:
    {
        switch(type)
        {
        case -1: //Init
            mouseArea3.enabled=false
        case 9: //Depart Sequence
            listEntree.clear();
            listSortie.clear();
            listSortie.append({_x:188,_y:30,_indice:0,_color:"yellow"})
            break;

        case 0: //Servomoteur
        case 1: //Dynamixel
        case 2: //Capteur
        case 3: //Moteur
        case 4: //Autre
        case 7: //Sequence
        case 12://attente temps
        case 19://SetValue
        case 17://GPIO
        {
            listEntree.clear();
            listEntree.append({_x:2,_y:30,_indice:0,_color:"yellow"})
            listSortie.clear();
            listSortie.append({_x:188,_y:30,_indice:0,_color:"yellow"})
            break;
        }
        case 5: //Position
        case 6: //Orientation
        case 10://attente servo
        case 11://attente dyna
        case 13://Retour déplacement
        case 14://Retour orientation
        case 15://Retour position
        case 16://Retour GPIO
        case 18://Bloc AND
        case 20://Bloc Courbe
        {
            listEntree.clear();
            listEntree.append({_x:2,_y:30,_indice:0,_color:"yellow"})
            listSortie.clear();
            listSortie.append({_x:188,_y:30,_indice:0,_color:"yellow"})
            listSortie.append({_x:188,_y:50,_indice:1,_color:"yellow"})
            break;
        }

        }
    }

    property int oldX: 0
    property int oldY: 0
    onXChanged:
    {
        if(inhibeMoveXY===false)
        {
            xChange(root.x-oldX);
            oldX = root.x
        }


        if(bloc!==null)
        {
            bloc.xBloc = root.x;
        }
        for(var i=0;i<listEntree.count;i++)
        {
            if(gridEntree.itemAt(i)!==null)
            {
                for(var j=0;j<gridEntree.itemAt(i).tabPere.length;j++)
                {
                    gridEntree.itemAt(i).tabPere[j].filsBouge(gridEntree.itemAt(i),
                                                              root.x+gridEntree.itemAt(i).x+5 - gridEntree.itemAt(i).tabPere[j].parent.x - gridEntree.itemAt(i).tabPere[j].x,
                                                              root.y+gridEntree.itemAt(i).y+5 - gridEntree.itemAt(i).tabPere[j].parent.y - gridEntree.itemAt(i).tabPere[j].y)
                }
            }
        }

        for(var i=0;i<listNumberIn.count;i++)
        {
            if(gridNumberIn.itemAt(i)!==null)
            {
                for(var j=0;j<gridNumberIn.itemAt(i).tabPere.length;j++)
                {
                    gridNumberIn.itemAt(i).tabPere[j].filsBouge(gridNumberIn.itemAt(i),
                                                              root.x+gridNumberIn.itemAt(i).x+5 - gridNumberIn.itemAt(i).tabPere[j].parent.x - gridNumberIn.itemAt(i).tabPere[j].x,
                                                              root.y+gridNumberIn.itemAt(i).y+5 - gridNumberIn.itemAt(i).tabPere[j].parent.y - gridNumberIn.itemAt(i).tabPere[j].y)
                }
            }
        }

        for(var i=0;i<listNumberOut.count;i++)
        {
            if(gridNumberOut.itemAt(i)!==null)
            {
                gridNumberOut.itemAt(i).pereBouge(root.x,root.y)
            }
        }

        for(var i=0;i<listSortie.count;i++)
        {
            if(gridSortie.itemAt(i)!==null)
            {
                gridSortie.itemAt(i).pereBouge(root.x,root.y)
            }
        }
    }

    onYChanged:
    {
        if(inhibeMoveXY===false)
        {
            yChange(root.y-oldY);
            oldY = root.y
        }
        if(bloc!==null)
        {
            bloc.yBloc = root.y;
        }
        for(var i=0;i<listEntree.count;i++)
        {
            if(gridEntree.itemAt(i)!==null)
            {
                for(var j=0;j<gridEntree.itemAt(i).tabPere.length;j++)
                {
                    gridEntree.itemAt(i).tabPere[j].filsBouge(gridEntree.itemAt(i),
                                                              root.x+gridEntree.itemAt(i).x+5 - gridEntree.itemAt(i).tabPere[j].parent.x - gridEntree.itemAt(i).tabPere[j].x,
                                                              root.y+gridEntree.itemAt(i).y+5 - gridEntree.itemAt(i).tabPere[j].parent.y - gridEntree.itemAt(i).tabPere[j].y)
                }
            }
        }

        for(var i=0;i<listNumberIn.count;i++)
        {
            if(gridNumberIn.itemAt(i)!==null)
            {
                for(var j=0;j<gridNumberIn.itemAt(i).tabPere.length;j++)
                {
                    gridNumberIn.itemAt(i).tabPere[j].filsBouge(gridNumberIn.itemAt(i),
                                                              root.x+gridNumberIn.itemAt(i).x+5 - gridNumberIn.itemAt(i).tabPere[j].parent.x - gridNumberIn.itemAt(i).tabPere[j].x,
                                                              root.y+gridNumberIn.itemAt(i).y+5 - gridNumberIn.itemAt(i).tabPere[j].parent.y - gridNumberIn.itemAt(i).tabPere[j].y)
                }
            }
        }

        for(var i=0;i<listNumberOut.count;i++)
        {
            if(gridNumberOut.itemAt(i)!==null)
            {
                gridNumberOut.itemAt(i).pereBouge(root.x,root.y)
            }
        }

        for(var i=0;i<listSortie.count;i++)
        {
            if(gridSortie.itemAt(i)!==null)
            {
                gridSortie.itemAt(i).pereBouge(root.x,root.y)
            }
        }
    }

    Menu
    {
        id:contextMenu1
        MenuItem
        {
            text:"Supprimer le bloc"
            onTriggered:
            {
                for(var i=0;i<listSortie.count;i++)
                {
                    gridSortie.itemAt(i).haraKiri(gridSortie.itemAt(i))
                    for(var j=0;j<gridSortie.itemAt(i).tabFils.length;j++)
                    {
                        gridSortie.itemAt(i).tabFils[j].parent.bloc.supprimerFils(gridSortie.itemAt(i).parent.bloc)
                    }
                }

                //listSortie.clear()
                for(var i=0;i<listEntree.count;i++)
                {
                    gridEntree.itemAt(i).harakiri(gridEntree.itemAt(i))
                    for(var j=0;j<gridEntree.itemAt(i).tabPere.length;j++)
                    {
                        gridEntree.itemAt(i).tabPere[j].parent.bloc.supprimerFils(gridEntree.itemAt(i).parent.bloc)
                    }
                }
                iWantToDie();
            }
        }
    }

    MouseArea
    {
        id:mouseArea3
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.fill: parent
        drag.target: parent;
        propagateComposedEvents:true
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked:
        {
            if(mouse.button === Qt.RightButton)
            {
                contextMenu1.popup()
            }else
            {
                click()
            }
        }
    }

    Rectangle {
        id: rectangle //655e5e
        color: "#655e5e"
        border.color: _couleurInfoBloc
        border.width: 3
        opacity: 0.8 //655e5e
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: rectangle3.bottom
        anchors.topMargin: 0
        Component.onCompleted:
        {
            createSpriteObjects(type,0,0)
            creationComplete(bloc);
        }
    }

    ListModel
    {
        id:listEntree
        ListElement{ _x:2 ; _y:30; _indice:0;_color:"grey" }
    }

    Repeater
    {
        id:gridEntree
        model:listEntree
        EntreeBloc
        {
            x:_x
            y:_y
            couleur:_color
        }
    }

    ListModel
    {
        id:listNumberIn
        //ListElement{ _x:2 ; _y:75; _indice:0;_color:"#8ec1ff" }
    }

    Repeater
    {
        id:gridNumberIn
        model:listNumberIn
        NumberEntreeBloc
        {
            x:_x
            y:_y
            couleur:_color
        }
    }

    ListModel
    {
        id:listNumberOut
        //ListElement{ _x:188 ; _y:75; _indice:0;_color:"#8ec1ff" }
    }

    Repeater
    {
        id:gridNumberOut
        model:listNumberOut
        NumberSortieBloc
        {
            x:_x
            y:_y
            couleur:_color
        }
    }

    ListModel
    {
        id:listSortie
        ListElement{ _x:188 ; _y:30; _indice:0;_color:"grey" }
        ListElement{ _x:188 ; _y:45; _indice:1;_color:"orange" }
        ListElement{ _x:188 ; _y:60; _indice:2;_color:"yellow" }
        ListElement{ _x:188 ; _y:75; _indice:3;_color:"red" }
    }

    Repeater
    {
        id:gridSortie
        model:listSortie

        SortieBloc
        {
            indice:_indice
            x:_x
            y:_y
            z:2
            couleur:_color
        }
    }

    Rectangle {
        id: rectangle3
        height: 2
        color: "#000000"
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 13
        anchors.left: parent.left
        anchors.leftMargin: 13

    }
    Rectangle {
        id: rectangle4
        color: "#4f4a4a"
        z:-1
        radius: 5
        anchors.right: parent.right
        anchors.rightMargin: 13
        anchors.left: parent.left
        anchors.leftMargin: 13
        anchors.bottom: rectangle3.top
        anchors.bottomMargin: -5
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: textTitre
            z:2
            text: title+" "+indice
            font.bold: true
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.topMargin: 7
            font.pixelSize: 13
        }
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
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocServo.qml");
            break;
        }
        case 1: //Dynamixel
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocDyna.qml");
            break;
        }
        case 2: //Capteur
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocCapteur.qml");
            break;
        }
        case 3: //Moteur
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocMoteur.qml");
            break;
        }
        case 4: //Autre
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAutre.qml");
            break;
        }
        case 5: //Position
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocPosition.qml");
            break;
        }
        case 6: //Orientation
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocOrientation.qml");
            break;
        }
        case 7: //Sequence
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocSequence.qml");
            break;
        }
        case 9: //Depart Sequence
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocDepart.qml");
            break;
        }
        case 10: //Attente servo
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAttenteServo.qml");
            break;
        }
        case 11: //Attente dyna
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAttenteDyna.qml");
            break;
        }
        case 12: //Attente temps
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAttenteTemps.qml");
            break;
        }
        case 13: //Retour déplacement
        {
            //component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAttenteTemps.qml");
            break;
        }
        case 14: //Retour orientation
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocRetourOrientation.qml");
            break;
        }
        case 15: //Retour position
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocRetourPosition.qml");
            break;
        }
        case 16: //GPIO
        {
            //component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAttenteTemps.qml");
            break;
        }
        case 17: //retour GPIO
        {
            //component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAttenteTemps.qml");
            break;
        }
        case 18: //Bloc AND
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocAND.qml");
            break;
        }
        case 19: //Bloc setValue
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocSetValue.qml");
            break;
        }
        case 20://Bloc courbe
        {
            component = Qt.createComponent("../ComposantBloc/TypeAction/BlocCourbe.qml");
            break;
        }

        }
        if(type!==-1)
        {
            if (component.status === Component.Ready)
                finishCreation(type, x,y);
            else
                component.statusChanged.connect(finishCreation(x,y));

            for(var i=0;i<listSortie.count;i++)
            {
                bloc.ajouterListFils();
            }
            for(var i=0;i<listEntree.count;i++)
            {
                bloc.ajouterListPere();
            }

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
                if(type !== 9)sprite.modifTaille.connect(modifTaille)
                modifTaille(sprite.taille)
                bloc = sprite.fils

            }

        } else if (component.status === Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    function modifTaille(taille)
    {
        root.height = 32 + taille
    }
}
