import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import connector 1.0
import bloc 1.0

Item {
    id: item1
    objectName: "Action"
    width: 200
    height: 282
    signal mustBeDeleted();
    property var itemArrive : []
    property string title: "bonsoir"
    property int indice:-1
    property var itemDepart : null
    property int oldX : 111
    property int oldY : 83
    property string colorEntry:"yellow"
    property int type:0

    Component.onCompleted:
    {
        if(indice===0)
        {
            rectangle2.visible = false
            mouseArea3.enabled = false
        }
        if(type === 0)
        {
            rectangle.state = " "
        }else if(type === 1)
        {
            rectangle.state = "Dyna"
            item1.height = 382
        }
    }


    Bloc
    {
        id:bloc1
        posX: item1.x
        posY: item1.y
        xDraw:rectangle2.x+rectangle2.width/2
        yDraw:rectangle2.y+rectangle2.height/2
        nom_Bloc : item1.title;
        onListFilsChanged:
        {
            for(var i=0;i< bloc1.getNbFils();i++)
            {
                deltaX2_fille(bloc1.getFils(i).posX + bloc1.getFils(i).xDraw,i);
                deltaY2_fille(bloc1.getFils(i).posY + bloc1.getFils(i).yDraw,i);
            }
            /*for(var i=0;i<itemArrive.length;i++)
            {
                if(itemArrive[i]!==null)
                {

                    deltaY2_fille(itemArrive[i].parent.parent.y + itemArrive[i].parent.y + itemArrive[i].parent.height/2,i)
                }
            }*/
        }
        onRemoveFils:
        {
            listSortie.remove(filsIndigne)
        }
    }

    onXChanged:
    {
        if (mouseArea3.drag.active) {
            /*if(itemDepart!==null)
            {


                itemDepart.parent.deltaX2_fille(item1.x +rectangle2.x + rectangle2.width/2 ,0);
            }*/

            for(var i=0;i<bloc1.getNbPere();i++)
            {
                bloc1.getPere(i).listFilsChanged();
            }

            for(var i=0;i< bloc1.getNbFils();i++)
            {
                deltaX2_fille(bloc1.getFils(i).posX + bloc1.getFils(i).xDraw,i);
            }
        }
    }
    onYChanged:
    {
        if (mouseArea3.drag.active) {
            /*if(itemDepart!==null)
            {
                itemDepart.parent.deltaY2_fille(item1.y + rectangle2.y + rectangle2.height/2,0);
            }*/


            for(var i=0;i<bloc1.getNbPere();i++)
            {
                bloc1.getPere(i).listFilsChanged();
            }

            for(var i=0;i< bloc1.getNbFils();i++)
            {
                deltaY2_fille(bloc1.getFils(i).posY + bloc1.getFils(i).yDraw,i);
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
                bloc1.haraKiri();
                mustBeDeleted();
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

    Info_Bloc {
        id: rectangle

        anchors.top: rectangle3.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.rightMargin: 7
        anchors.leftMargin: 7

        anchors.bottomMargin: 0
        anchors.topMargin: 0
        onTailleChange:
        {
            item1.height = 32 + taille
        }

    }
    ListModel
    {
        id:listSortie
        ListElement{ _indice:0}
    }
    Rectangle {
        id: rectangle1
        objectName: "sortie"
        x: 162
        z:0
        width: 10
        height: 10
        color: "grey"
        radius: 5
        anchors.topMargin: item1.height/2 - height/2
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 0

        children: [

            Repeater
            {
                id:gridSortie
                model:listSortie
                Liaison
                {
                    z:-1
                    anchors.fill: parent
                }
            }
        ]
    }


    Rectangle {
        id: rectangle2
        width: 10
        height: 10
        z:0
        color: colorEntry
        radius: 5
        anchors.topMargin: item1.height/2 - height/2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 0
        objectName: "entree"

        children: [
            Repeater
            {
                model:1
                Liaison {
                    objectName: "lien"
                    z:-1
                    anchors.fill: parent
                }
            }]
    }

    Rectangle {
        id: rectangle3
        height: 2
        color: "#000000"
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 7
    }

    Rectangle {
        id: rectangle4
        color: "#4f4a4a"
        z:-1
        radius: 5
        anchors.right: parent.right
        anchors.rightMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.bottom: rectangle3.top
        anchors.bottomMargin: -5
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: textTitre
            text: title
            font.bold: true
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.topMargin: 7
            //horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 13
        }

        Image
        {
            source:"../Image/arrowExit.png"
            anchors.topMargin: 0
            anchors.bottomMargin: 7
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: height

        }
    }

    function getNom()
    {
        return bloc1.nom_Bloc
    }

    function getEntree(x, y)
    {

        if(item1.childAt(x-item1.x,y-item1.y) !== null)
        {
            if(item1.childAt(x-item1.x,y-item1.y).objectName === "entree")
            {
                if(item1.childAt(x-item1.x,y-item1.y).children[0] !== null)
                {
                    return item1.childAt(x-item1.x,y-item1.y).children[0]
                }else
                {
                    return null
                }
            }else
            {
                return null
            }
        }else
        {
            return null
        }
    }

    function getSortie(x, y)
    {
        if(item1.childAt(x-item1.x,y-item1.y) !== null)
        {
            if(item1.childAt(x-item1.x,y-item1.y).objectName === "sortie")
            {
                return item1.childAt(x-item1.x,y-item1.y).children[item1.childAt(x-item1.x,y-item1.y).children.length-1].itemAt(item1.childAt(x-item1.x,y-item1.y).children[item1.childAt(x-item1.x,y-item1.y).children.length-1].count-1)
            }else
            {
                return null
            }
        }else
        {
            return null
        }
    }

    function deltaX2_fille(X,indice)
    {
        rectangle1.children[rectangle1.children.length-1].itemAt(indice).x2 = X - item1.x - rectangle1.x + rectangle1.width/2;
    }

    function deltaY2_fille(Y,indice)
    {
        rectangle1.children[rectangle1.children.length-1].itemAt(indice).y2 = Y - (item1.y + rectangle1.y + rectangle1.height/2);
    }

    function getNbPere()
    {
        return bloc1.getNbPere();
    }

    function add_sortie()
    {
        listSortie.append({_indice:listSortie.count})
    }

    function addPere(pere)
    {
        bloc1.addPere(pere);
    }

    function addFils(fils)
    {
        bloc1.addFils(fils);
    }

    function getBloc()
    {
        return bloc1
    }

    function getPere(indicePere)
    {
        return bloc1.getPere(indicePere)
    }

    function deleteLien(indicePere)
    {
        bloc1.getPere(indicePere).deleteFils(bloc1);
        bloc1.deletePere(bloc1.getPere(indicePere))
    }

    function setColor(couleur)
    {
        rectangle.color = couleur
    }
}
