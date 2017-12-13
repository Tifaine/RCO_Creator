import QtQuick 2.4
import gestTable 1.0
import connector 1.0

Item {
    id: item1
    width:600
    height:400

    property int essaiX:500
    property int essaiY:1000
    property var seqPapa:null
    property var gestionTable:gestTable
    property int indiceSelect:-1

    function updateTable()
    {
        listPoint.clear()
        for(var i = 0; i<gestTable.getTailleList();i++)
        {
            if(gestTable.getTypeAction(i)===5)
            {
                listPoint.append({"indice":i,"couleur":"#FF007F"})
                repeaterPoint.itemAt(listPoint.count-1).x = image.x + ((gestTable.getAction(i).getXRobot()+1500)*image.width / 3000) - repeaterPoint.itemAt(listPoint.count-1).width/2
                repeaterPoint.itemAt(listPoint.count-1).y = image.y + ((2000-gestTable.getAction(i).getYRobot())*image.height/ 2000) - repeaterPoint.itemAt(listPoint.count-1).height/2
            }
            //x:image.x + ((gestTable.getAction(indice).getXRobot()+1500)*image.width / 3000) - width/2
            //y:image.y + ((2000-gestTable.getAction(indice).getYRobot())*image.height/ 2000) - height/2
        }
        gestTable.gestionTable();
    }

    Component.onCompleted:
    {
        listPoint.clear()
        //modelLien.clear()
    }

    GestTable
    {
        id:gestTable
        onChangeX:
        {
            if(!clicking)
            {
                for(var i = 0; i <listPoint.count; i++)
                {
                    if(listPoint.get(i).indice === indice)
                    {
                        repeaterPoint.itemAt(i).x = image.x + ((gestTable.getAction(indice).getXRobot()+1500)*image.width / 3000) - repeaterPoint.itemAt(listPoint.count-1).width/2
                        //Je sais pas non plu. Mais ça fait le job.
                        rect.x++;
                        rect.x--
                        break;
                    }
                }
            }
        }
        onChangeY:
        {
            if(!clicking)
            {
                for(var i = 0; i <listPoint.count; i++)
                {
                    if(listPoint.get(i).indice === indice)
                    {
                        repeaterPoint.itemAt(i).y = image.y + ((2000-gestTable.getAction(indice).getYRobot())*image.height/ 2000) - repeaterPoint.itemAt(listPoint.count-1).height/2
                        //Je sais pas non plu. Mais ça fait le job.
                        rect.x++;
                        rect.x--;
                        break;
                    }
                }
            }
        }
        onFinTraitementTable:
        {
            listLiaisonTable.clear();
            for(var i = 0 ; i<getNbLien(); i++)
            {
                if(getIndicePere(i)!==0)
                {
                    listLiaisonTable.append({"indicePere":getIndicePere(i),"indiceFils":getIndiceFils(i)});
                }
            }
        }
    }

    ListModel
    {
        id:listLiaisonTable
        ListElement
        {
            indicePere:0
            indiceFils:0
        }
    }

    Repeater
    {
        id:repeaterLiaison
        model: listLiaisonTable
        Liaison
        {
            id:liaison
            z:-1
            _color:"#151b70"
            //x1:repeaterPoint.itemAt(indicePere).x + 10*image.width / 600/2
            //y1:repeaterPoint.itemAt(indicePere).y + 10*image.width / 600/2
            //x2:repeaterPoint.itemAt(indiceFils).x + 10*image.width / 600/2
            //y2:repeaterPoint.itemAt(indiceFils).y + 10*image.width / 600/2
            x1:image.x + ((gestTable.getAction(indicePere).getXRobot()+1500)*image.width / 3000)// - 10*image.width / 600/2
            y1:image.y + ((2000-gestTable.getAction(indicePere).getYRobot())*image.height/ 2000)// - 10*image.height / 400/2
            x2:image.x + ((gestTable.getAction(indiceFils).getXRobot()+1500)*image.width / 3000)// - 10*image.width / 600/2
            y2:image.y + ((2000-gestTable.getAction(indiceFils).getYRobot())*image.height/ 2000)// - 10*image.height / 400/2

        }
    }

    Image {
        id: image
        z:-10
        anchors.leftMargin: -5
        anchors.bottomMargin: 0
        anchors.top: rect.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: rect.right
        anchors.topMargin: -5
        source: "file::/../image/table.jpg"
    }

    ListModel
    {
        id:listPoint
        ListElement
        {
            indice:0
            couleur:"green"
        }
    }

    property bool clicking:false
    Repeater
    {
        id:repeaterPoint
        model:listPoint
        Rectangle
        {
            id:rectPoint
            //x:image.x + ((gestTable.getAction(indice).getXRobot()+1500)*image.width / 3000) - width/2
            //y:image.y + ((2000-gestTable.getAction(indice).getYRobot())*image.height/ 2000) - height/2
            width: 10*image.width / 600
            height:10*image.height / 400
            border.width: 1
            border.color: "black"
            radius: width/2
            color:couleur
            property int compteurBoucle:0
            onXChanged:
            {
                if(mouseArea2.pressed)
                {
                    if(gestTable.getAction(indice).getType() === 5)
                    {
                        gestTable.getAction(indice).setXRobot(((x- image.x + width/2) * 3000/image.width)-1500);
                        rect.x++;
                        rect.x--;
                    }else
                    {
                        gestTable.gestionTable();
                    }
                }
            }
            onYChanged:
            {
                if(mouseArea2.pressed)
                {
                    if(gestTable.getAction(indice).getType() === 5)
                    {
                        gestTable.getAction(indice).setYRobot((((y- image.y + height/2) * 2000/image.height)-2000)*-1);
                        rect.x++;
                        rect.x--;
                    }else
                    {
                        gestTable.gestionTable();
                    }
                }
            }

            Text
            {
                anchors.fill: parent
                text:indice
                color:"white"
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }

            MouseArea {
                id: mouseArea2
                anchors.fill: parent
                hoverEnabled: true
                drag {
                    target: rectPoint
                    axis: Drag.XAndYAxis
                }
                onPressed:
                {
                    clicking = true
                    indiceSelect = indice
                }
                onReleased: clicking = false
            }
        }
    }

    Rectangle
    {
        id:rect
        width: 10
        height: 10
        x:-5
        y:-5
        color:"transparent"
        property int oldX:-5
        onXChanged:
        {
            rect.y += (2./3.)*(rect.x - oldX)
            oldX = rect.x
            if(!clicking)
            {
                for(var i = 0; i <listPoint.count; i++)
                {
                    repeaterPoint.itemAt(i).x = image.x + ((gestTable.getAction(listPoint.get(i).indice).getXRobot()+1500)*image.width / 3000) - repeaterPoint.itemAt(i).width/2
                    repeaterPoint.itemAt(i).y = image.y + ((2000-gestTable.getAction(listPoint.get(i).indice).getYRobot())*image.height/ 2000) - repeaterPoint.itemAt(i).height/2
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            drag {
                target: rect
                axis: Drag.XAxis
            }
            cursorShape: containsMouse ? Qt.SizeFDiagCursor : Qt.ArrowCursor
        }
    }
}
