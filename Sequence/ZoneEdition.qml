import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import connector 1.0
import sequence 1.0

import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../ComposantBloc"

Item {
    id:root
    property string nomActionToAdd : "Coucou"
    function saveAs(nomFichier)
    {
        seq.enregistrerSous(nomFichier)
    }

    Sequence
    {
        id:seq
    }



    Rectangle
    {
        id:rect
        color:"#323232"
        anchors.fill: parent
        Flickable {
            id: flickable
            property real echelle :1.0
            anchors.fill: parent
            contentWidth: 20000; contentHeight: 20000
            contentX: 0
            contentY:0
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

            Rectangle
            {
                id:rect1
                anchors.fill: parent
                property var survolActif :null
                color:"transparent"

                MouseArea
                {
                    id:mouseArea
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    anchors.fill: parent
                    propagateComposedEvents: true

                    property var obj
                    property var obj2
                    property var sortieCourante:null
                    property var entreePopup:null

                    onPressed:
                    {
                        if(mouse.button === Qt.LeftButton)
                        {
                            obj = rect1.childAt(mouse.x,mouse.y)
                            if(obj!==null)
                            {

                                if(obj.objectName==="BlocAction")
                                {
                                    flickable.interactive = false
                                    obj2 = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)

                                    if(obj2.objectName==="Sortie")
                                    {
                                        sortieCourante = obj2
                                    }
                                }
                            }
                        }else if(mouse.button === Qt.RightButton)
                        {
                            obj = rect1.childAt(mouse.x,mouse.y)
                            if(obj!==null)
                            {
                                if(obj.objectName==="BlocAction")
                                {
                                    flickable.interactive = false
                                    obj2 = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)

                                    if(obj2.objectName==="Entree")
                                    {
                                        entreePopup = obj2
                                        listMenu.clear()
                                        for(var i=0;i<entreePopup.tabPere.length;i++)
                                        {
                                            listMenu.append({"_title":entreePopup.tabPere[i].parent.title})
                                        }

                                        contextMenu.popup()
                                    }
                                }
                            }
                        }
                    }

                    onReleased:
                    {
                        flickable.interactive = true

                        if(mouse.button === Qt.LeftButton)
                        {
                            obj = rect1.childAt(mouse.x,mouse.y)
                            if(obj!==null)
                            {
                                if(obj.objectName==="BlocAction")
                                {

                                    obj2 = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)
                                    if(obj2!==null)
                                    {
                                        if(obj2.objectName==="Entree")
                                        {
                                            sortieCourante.repaint((obj.x+obj2.x+5)-sortieCourante.parent.x-sortieCourante.x,
                                                                   (obj.y+obj2.y+5)-sortieCourante.parent.y-sortieCourante.y)
                                            sortieCourante.addLiaison(obj2);
                                            sortieCourante.parent.bloc.ajouterFils(sortieCourante.indice,obj2.parent.bloc)
                                            obj2.tabPere.push(sortieCourante)
                                            if(rect1.survolActif!==null)
                                            {
                                                rect1.survolActif.couleur = "yellow"
                                            }
                                        }else
                                        {
                                            sortieCourante.repaint(5,5)
                                            sortieCourante=null
                                        }
                                    }else
                                    {
                                        if(sortieCourante!==null)
                                        {
                                            sortieCourante.repaint(5,5)
                                        }
                                    }
                                }else
                                {
                                    if(sortieCourante!==null)
                                    {
                                        sortieCourante.repaint(5,5)
                                    }
                                }
                                sortieCourante=null
                            }
                        }
                    }

                    onMouseXChanged:
                    {
                        if(sortieCourante!==null)
                        {
                            sortieCourante.repaint(mouse.x-sortieCourante.parent.x-sortieCourante.x
                                                   , mouse.y-sortieCourante.parent.y-sortieCourante.y)
                        }

                        if(rect1.survolActif!==null)
                        {
                            rect1.survolActif.couleur = "yellow"
                        }

                        obj = rect1.childAt(mouse.x,mouse.y)
                        if(obj!==null)
                        {
                            if(obj.objectName==="BlocAction")
                            {
                                obj2 = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)
                                if(obj2!==null)
                                {
                                    if(obj2.objectName==="Entree")
                                    {
                                        rect1.survolActif = obj2;
                                        rect1.survolActif.couleur = "blue"
                                    }
                                }
                            }
                        }
                    }
                    onMouseYChanged:
                    {
                        if(sortieCourante!==null)
                        {
                            sortieCourante.repaint(mouse.x-sortieCourante.parent.x-sortieCourante.x
                                                   , mouse.y-sortieCourante.parent.y-sortieCourante.y)
                        }
                        if(rect1.survolActif!==null)
                        {
                            rect1.survolActif.couleur = "yellow"
                        }

                        obj = rect1.childAt(mouse.x,mouse.y)
                        if(obj!==null)
                        {
                            if(obj.objectName==="BlocAction")
                            {
                                obj2 = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)
                                if(obj2!==null)
                                {
                                    if(obj2.objectName==="Entree")
                                    {
                                        rect1.survolActif = obj2;
                                        rect1.survolActif.couleur = "blue"
                                    }
                                }
                            }
                        }
                    }
                }

                ListModel
                {
                    id:listMenu
                    ListElement{_title:"Menu 0";}
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
                                mouseArea.entreePopup.tabPere[index].parent.bloc.supprimerFils(mouseArea.entreePopup.parent.bloc)
                                mouseArea.entreePopup.tabPere[index].supprimerFils(mouseArea.entreePopup)
                                mouseArea.entreePopup.tabPere.splice(index,1)
                            }
                        }
                    }

                    on__CurrentIndexChanged:
                    {
                        if( __currentIndex >= 0)
                        {
                            if(contextMenu.previousSelected !==-1)
                            {
                                mouseArea.entreePopup.tabPere[contextMenu.previousSelected].couleurSelected = "#FF007F"
                                mouseArea.entreePopup.tabPere[contextMenu.previousSelected].parent._couleurInfoBloc = "#655e5e"
                            }
                            mouseArea.entreePopup.tabPere[__currentIndex].parent._couleurInfoBloc = "yellow"
                            mouseArea.entreePopup.tabPere[__currentIndex].couleurSelected = "blue"
                        }else if(contextMenu.previousSelected !==-1)
                        {
                            mouseArea.entreePopup.tabPere[contextMenu.previousSelected].couleurSelected = "#FF007F"
                            mouseArea.entreePopup.tabPere[contextMenu.previousSelected].parent._couleurInfoBloc = "#655e5e"
                        }
                        contextMenu.previousSelected = __currentIndex;
                    }
                }

                ListModel
                {
                    id:listAction

                    ListElement{ _x:50 ; _y:250; _title:"Debut"; _indice:0; _type:9 }

                }

                DropArea
                {
                    anchors.fill: parent
                    onDropped:
                    {
                        if(nomActionToAdd ==="Dynamixel")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:1})
                        }else if(nomActionToAdd === "Servomoteur")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:0})
                        }else if(nomActionToAdd === "Capteur")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:2})
                        }else if(nomActionToAdd === "Moteur")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:3})
                        }else if(nomActionToAdd === "Autre")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:4})
                        }else if(nomActionToAdd === "Position")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:5})
                        }else if(nomActionToAdd === "Orientation")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:6})
                        }else if(nomActionToAdd === "Séquence")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:7})
                        }else if(nomActionToAdd === "Départ")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:9})
                        }else if(nomActionToAdd === "Attente servo")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:10})
                        }else if(nomActionToAdd === "Attente dyna")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:11})
                        }else if(nomActionToAdd === "Attente temps")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:12})
                        }
                    }
                }

                Repeater
                {
                    id:gridAction
                    model:listAction
                    BlocAction
                    {
                        x:_x
                        y:_y
                        id:act
                        title:_title
                        indice:_indice
                        type : _type
                        onIWantToDie:
                        {
                            seq.supprimerAction(act.bloc)
                            listAction.remove(index,1)
                        }
                        onCreationComplete:
                        {
                            if(bloc!==null)
                            {
                                seq.ajouterAction(bloc)
                                bloc.xBloc = x;
                                bloc.yBloc = y;
                            }else
                            {
                                console.log("je suis nuuuuuul")
                            }
                        }
                    }
                }
            }
        }
    }
}
