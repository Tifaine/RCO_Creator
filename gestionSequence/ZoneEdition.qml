import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import connector 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import sequence 1.0

import "../Composant"
Item {
    width: 1500
    height: 800
    property int indiceZoneEdi :-1
    property var rectEnCours:null
    property var entreeCourante : null
    property var sortieCourante : null
    property var toRightClic:null
    property string nomActionToAdd : "Coucou"
    signal ajouterTab(string nom)

    Component.onCompleted:
    {
        listAction.clear();
        if(indiceZoneEdi===0)
        {
            listAction.append({_x:0,_y:10200, _title:"Début",_indice:0,_type:9})
        }else
        {
            listAction.append({_x:0,_y:10200, _title:"Entrée",_indice:0,_type:9})
            listAction.append({_x:500,_y:10200, _title:"Sortie",_indice:1,_type:8})
        }

    }

    Sequence
    {
        id:seq
    }

    function addActionToSeq(toAdd)
    {
        seq.addAction(toAdd);
    }

    Rectangle
    {
        color:"#323232"
        anchors.fill: parent
        Flickable {
            id: flickable
            property real echelle :1.0
            anchors.fill: parent
            contentWidth: 20000; contentHeight: 20000
            contentX: 0
            contentY:10000
            scale: echelle
            ScrollBar.vertical: ScrollBar {

                parent: flickable.parent
                anchors.top: flickable.top
                anchors.left: flickable.right
                anchors.leftMargin: -10
                anchors.bottom: flickable.bottom
            }
            ScrollBar.horizontal: ScrollBar {

                parent: flickable.parent
                anchors.left: flickable.left
                anchors.right: flickable.right
                anchors.bottom: flickable.bottom
            }

            ListModel
            {
                id:listMenu
                ListElement{  _title:"Menu 0";}
            }


            Menu
            {
                id:contextMenu
                property int previousSelected:-1
                Instantiator
                {
                    //The trick is on those two lines
                    onObjectAdded: contextMenu.insertItem(index, object)
                    onObjectRemoved: contextMenu.removeItem(object)
                    model:listMenu
                    MenuItem
                    {
                        text:_title
                        onTriggered:
                        {
                            toRightClic.parent.parent.getPere(index).parent.setColor("#655e5e");
                            if(contextMenu.previousSelected !== -1)
                            {
                                contextMenu.previousSelected = -1
                            }
                            toRightClic.parent.parent.deleteLien(index)
                        }

                    }

                }

                on__CurrentIndexChanged:
                {
                    if( __currentIndex >= 0)
                    {
                        toRightClic.parent.parent.getPere(__currentIndex).parent.setColor("#8FFF44")
                        if(contextMenu.previousSelected !== -1)
                        {
                            toRightClic.parent.parent.getPere(contextMenu.previousSelected).parent.setColor("#655e5e");
                        }

                    }else if(contextMenu.previousSelected !==-1)
                    {
                        toRightClic.parent.parent.getPere(contextMenu.previousSelected).parent.setColor("#655e5e");
                    }

                    contextMenu.previousSelected = __currentIndex;


                }
            }

            ListModel
            {
                id:listAction

                ListElement{ _x:0 ; _y:10200; _title:"Init"; _indice:0; _type:-1 }
            }

            Rectangle
            {
                id:rect
                anchors.fill: parent
                property var survolActif :null
                color:"transparent"
                MouseArea
                {
                    id:mouseArea1
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    anchors.fill: parent
                    propagateComposedEvents: true

                    onWheel:
                    {
                        if(flickable.echelle + wheel.angleDelta.y/1000. > 0.2 && flickable.echelle + wheel.angleDelta.y/1000. < 5)
                        {
                            flickable.echelle += wheel.angleDelta.y / 1000.
                        }
                    }

                    onMouseXChanged:
                    {

                        if(sortieCourante !== null)
                        {
                            sortieCourante.x2 = mouseX-sortieCourante.parent.x-sortieCourante.parent.parent.x
                            sortieCourante.y2 = mouseY-sortieCourante.parent.y-sortieCourante.parent.parent.y
                        }
                        if(rect.survolActif!==null)
                        {
                            rect.survolActif.colorEntry = "yellow"
                        }

                        if(rect.childAt(mouseX,mouseY).objectName === "Action")
                        {
                            if(rect.childAt(mouseX,mouseY).getEntree(mouseX,mouseY) !== null)
                            {
                                rect.survolActif = rect.childAt(mouseX,mouseY);
                                rect.survolActif.colorEntry = "blue"
                            }

                        }
                    }

                    onPressed:
                    {

                        if(mouse.button === Qt.LeftButton)
                        {
                            if(rect.childAt(mouseX,mouseY).objectName === "Action")
                            {
                                flickable.interactive = false
                                if(rect.childAt(mouseX,mouseY).getSortie(mouseX,mouseY) !== null)
                                {                                    
                                    sortieCourante = rect.childAt(mouseX,mouseY).getSortie(mouseX,mouseY)
                                    sortieCourante.x1 = sortieCourante.parent.width/2
                                    sortieCourante.y1 = sortieCourante.parent.height/2
                                    sortieCourante.x2 = sortieCourante.x1
                                    sortieCourante.y2 = sortieCourante.y1
                                }else if(rect.childAt(mouseX,mouseY).getTimeOut(mouseX,mouseY) !== null)
                                {
                                    sortieCourante = rect.childAt(mouseX,mouseY).getTimeOut(mouseX,mouseY)
                                    sortieCourante.x1 = sortieCourante.parent.width/2
                                    sortieCourante.y1 = sortieCourante.parent.height/2
                                    sortieCourante.x2 = sortieCourante.x1
                                    sortieCourante.y2 = sortieCourante.y1
                                }

                            }else
                            {
                                sortieCourante = null
                            }
                        }else if(mouse.button === Qt.RightButton)
                        {
                            if(rect.childAt(mouseX,mouseY).objectName === "Action")
                            {
                                flickable.interactive = false
                                if(rect.childAt(mouseX,mouseY).getEntree(mouseX,mouseY) !== null)
                                {
                                    toRightClic = rect.childAt(mouseX,mouseY).getEntree(mouseX,mouseY)
                                    listMenu.clear()
                                    for(var i =0;i < toRightClic.parent.parent.getNbPere();i++)
                                    {
                                        listMenu.append({_title:("Supprimer lien avec "+toRightClic.parent.parent.getPere(i).parent.getNom())})
                                    }

                                    contextMenu.popup()
                                }
                            }
                        }
                    }
                    onReleased:
                    {
                        flickable.interactive = true
                        if(rect.childAt(mouseX,mouseY).objectName === "Action")
                        {
                            rect.childAt(mouseX,mouseY).itemDepart = sortieCourante.parent

                            if(rect.childAt(mouseX,mouseY).getEntree(mouseX,mouseY) !== null && sortieCourante.parent.objectName==="sortie")
                            {
                                entreeCourante = rect.childAt(mouseX,mouseY).getEntree(mouseX,mouseY)
                                sortieCourante.x2 = entreeCourante.parent.parent.x + entreeCourante.parent.x + entreeCourante.width/2 - sortieCourante.parent.x-sortieCourante.parent.parent.x
                                sortieCourante.y2 = entreeCourante.parent.parent.y + entreeCourante.parent.y + entreeCourante.height/2 -sortieCourante.parent.y-sortieCourante.parent.parent.y
                                sortieCourante.parent.parent.itemArrive.push(entreeCourante)
                                sortieCourante.parent.parent.add_sortie()
                                sortieCourante.parent.parent.addFils(entreeCourante.parent.parent.getBloc())
                                entreeCourante.parent.parent.addPere(sortieCourante.parent.parent.getBloc())
                                rect.survolActif.colorEntry = "yellow"
                            }else
                            {
                                sortieCourante.x2 = sortieCourante.x1
                                sortieCourante.y2 = sortieCourante.y1
                            }

                        }else
                        {
                            sortieCourante.x2 = sortieCourante.x1
                            sortieCourante.y2 = sortieCourante.y1
                        }
                        sortieCourante = null
                        entreeCourante = null
                    }
                }


                DropArea
                {
                    anchors.fill: parent
                    onDropped:
                    {
                        if(nomActionToAdd ==="Dynamixel")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:1})
                        }else if(nomActionToAdd ==="Servomoteur")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:0})
                        }else if(nomActionToAdd ==="Capteur")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:2})
                        }else if(nomActionToAdd ==="Moteur")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:3})
                        }else if(nomActionToAdd ==="Autre")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:4})
                        }else if(nomActionToAdd ==="Position")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:5})
                        }else if(nomActionToAdd ==="Orientation")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:6})
                        }else if(nomActionToAdd ==="Séquence")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:7})
                        }else if(nomActionToAdd ==="Départ")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:9})
                        }
                    }
                }

                Repeater
                {
                    id:gridAction
                    model:listAction
                    Bloc_Action
                    {
                        id:action1
                        x:_x
                        y:_y
                        title:_title
                        indice:_indice
                        type : _type
                        onMustBeDeleted:
                        {
                            for(var i=indice+1;i<listAction.count;i++)
                            {
                                listAction.get(i)._indice--;
                            }

                            listAction.remove(_indice)
                        }
                        onAfficherTabBloc:
                        {
                            ajouterTab(nom)
                        }
                        onAjouterAction:
                        {
                            addActionToSeq(actionToAdd)
                        }
                    }
                }
            }
        }
    }

}
