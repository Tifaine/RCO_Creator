import QtQuick 2.0
import QtQuick.Controls 1.4
import "../ComposantBloc"
import "../ComposantBloc/TypeAction"

Item {
    id:root
    property string title
    property int indice
    property int type
    property var _couleurInfoBloc : "#655e5e"
    signal iWantToDie()
    signal creationComplete(var bloc)
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
            listSortie.append({_x:188,_y:30,_indice:0,_color:"grey"})
            break;

        case 0: //Servomoteur
        case 1: //Dynamixel
        case 2: //Capteur
        case 3: //Moteur
        case 4: //Autre
        case 5: //Position
        case 6: //Orientation
        case 7: //Sequence
        {
            listEntree.clear();
            listEntree.append({_x:2,_y:30,_indice:0,_color:"yellow"})
            listSortie.clear();
            listSortie.append({_x:188,_y:30,_indice:0,_color:"grey"})
            listSortie.append({_x:188,_y:50,_indice:0,_color:"orange"})
            break;
        }

        }
    }

    onXChanged:
    {
        for(var i=0;i<listEntree.count;i++)
        {
            for(var j=0;j<gridEntree.itemAt(i).tabPere.length;j++)
            {
                gridEntree.itemAt(i).tabPere[j].filsBouge(gridEntree.itemAt(i),
                                                          root.x+gridEntree.itemAt(i).x+5 - gridEntree.itemAt(i).tabPere[j].parent.x - gridEntree.itemAt(i).tabPere[j].x,
                                                          root.y+gridEntree.itemAt(i).y+5 - gridEntree.itemAt(i).tabPere[j].parent.y - gridEntree.itemAt(i).tabPere[j].y)
            }
        }

        for(var i=0;i<listSortie.count;i++)
        {
            gridSortie.itemAt(i).pereBouge(root.x,root.y)
        }
    }

    onYChanged:
    {
        for(var i=0;i<listEntree.count;i++)
        {
            for(var j=0;j<gridEntree.itemAt(i).tabPere.length;j++)
            {
                gridEntree.itemAt(i).tabPere[j].filsBouge(gridEntree.itemAt(i),
                                                          root.x+gridEntree.itemAt(i).x+5 - gridEntree.itemAt(i).tabPere[j].parent.x - gridEntree.itemAt(i).tabPere[j].x,
                                                          root.y+gridEntree.itemAt(i).y+5 - gridEntree.itemAt(i).tabPere[j].parent.y - gridEntree.itemAt(i).tabPere[j].y)
            }
        }
        for(var i=0;i<listSortie.count;i++)
        {
            gridSortie.itemAt(i).pereBouge(root.x,root.y)
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
                }
                //listSortie.clear()
                for(var i=0;i<listEntree.count;i++)
                {
                    gridEntree.itemAt(i).harakiri(gridEntree.itemAt(i))
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
            }
        }

    }
    Info_Bloc
    {
        _couleur : _couleurInfoBloc
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: rectangle3.bottom
        anchors.topMargin: 0
        typeBloc:type
        onIFTailleChange:
        {
            root.height = 32 + taille
        }
        onFinCreation:
        {
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
            text: title
            font.bold: true
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.topMargin: 7
            font.pixelSize: 13
        }
    }
}
