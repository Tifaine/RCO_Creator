import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import connector 1.0
import sequence 1.0
import QtQuick.XmlListModel 2.0

import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../ComposantBloc"
import "../gestionTable"

Item {
    id:root
    signal ajouterTab(var nom);
    property int indiceTab : 0
    property bool ctrlPressed:false
    property bool majPressed:false
    property string nomActionToAdd : "Coucou"
    property var actionSelected:[]

    function saveAs(nomFichier)
    {
        seq.enregistrerSous(nomFichier)
    }

    function exportXML()
    {
        seq.exportXML();
    }

    function toggleTable()
    {
        table1.visible = !table1.visible;
    }

    function clearAll()
    {
        listAction.clear()
        seq.clearAll()
        table1.gestionTable.clearAll()
        table1.clear()
    }

    function mirror()
    {
        seq.mirror();
    }



    function reorganiserBloc()
    {

        for(var i=0;i<listAction.count;i++)
        {
            if(gridAction.itemAt(i).x%220 > 110)
            {
                gridAction.itemAt(i).x = gridAction.itemAt(i).x + (220-(gridAction.itemAt(i).x%220))
            }else
            {
                gridAction.itemAt(i).x = gridAction.itemAt(i).x - gridAction.itemAt(i).x%220
            }

            if(gridAction.itemAt(i).y%120 > 60)
            {
                gridAction.itemAt(i).y = gridAction.itemAt(i).y + (120-(gridAction.itemAt(i).y%120))
            }else
            {
                gridAction.itemAt(i).y = gridAction.itemAt(i).y - gridAction.itemAt(i).y%120
            }
        }
    }

    function ouvrirFile(nomFichier)
    {
        seq.ouvrirFichier(nomFichier)
    }

    function clearSelection()
    {
        for(var i = 0; i<actionSelected.length; i++)
        {
            gridAction.itemAt(actionSelected[i])._couleurInfoBloc="#655e5e"
        }
        actionSelected = []
    }

    Sequence
    {
        id:seq
        onFinParsage:
        {
            for(var i=0;i<listAction.count;i++)
            {
                if(gridAction.itemAt(i).listPere !== null && gridAction.itemAt(i).listFils !== null )
                {

                    var stringList = gridAction.itemAt(i).listFils.split(';')
                    var sortieCourante = gridAction.itemAt(i).listSortie_.itemAt(0)
                    if(sortieCourante!==null)
                    {
                        for(var j=0;j<stringList.length-1;j++)
                        {
                            var obj2 = gridAction.itemAt(parseInt(stringList[j])).listEntree_.itemAt(0)

                            sortieCourante.repaint((obj2.parent.x+obj2.x+5)-sortieCourante.parent.x-sortieCourante.x,
                                                   (obj2.parent.y+obj2.y+5)-sortieCourante.parent.y-sortieCourante.y)
                            sortieCourante.addLiaison(obj2);
                            sortieCourante.parent.bloc.ajouterFils(sortieCourante.indice,obj2.parent.bloc)
                            obj2.tabPere.push(sortieCourante)
                            obj2.parent.bloc.ajouterPere(0,sortieCourante.parent.bloc)
                        }
                        stringList = gridAction.itemAt(i).listPere.split(';')
                    }
                }

                if(gridAction.itemAt(i).listTimeOut !== null)
                {
                    var stringList2 = gridAction.itemAt(i).listTimeOut.split(';')
                    var sortieCourante2 = gridAction.itemAt(i).listSortie_.itemAt(1)
                    for(var k=0;k<stringList2.length-1;k++)
                    {
                        var obj3 = gridAction.itemAt(parseInt(stringList2[k])).listEntree_.itemAt(0)
                        sortieCourante2.repaint((obj3.parent.x+obj3.x+5)-sortieCourante2.parent.x-sortieCourante2.x,
                                                (obj3.parent.y+obj3.y+5)-sortieCourante2.parent.y-sortieCourante2.y)
                        sortieCourante2.addLiaison(obj3);
                        sortieCourante2.parent.bloc.ajouterFils(sortieCourante2.indice,obj3.parent.bloc)
                        obj3.tabPere.push(sortieCourante2)
                        obj3.parent.bloc.ajouterPere(0,sortieCourante2.parent.bloc)
                    }
                    stringList = gridAction.itemAt(i).listPere.split(';')
                }
                //console.log("Liste Pere : "+gridAction.itemAt(i).listPere+" Liste Fils : "+gridAction.itemAt(i).listFils)
            }

            table1.updateTable()
        }

        onGenererAction:
        {

            switch(typeBloc)
            {
            case -1: //Init
                break;
            case 0: //Servomoteur
            {

                listAction.append({_x:xBloc,_y:yBloc, _title:"Servomoteur",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 1: //Dynamixel
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Dynamixel",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param3);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;

                break;
            }
            case 2: //Capteur
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Capteur",_indice:listAction.count,_type:typeBloc})
                break;
            }
            case 3: //Moteur
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Moteur",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 4: //Autre
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Autre",_indice:listAction.count,_type:typeBloc})
                break;
            }
            case 5: //Position
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Position",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param3,param4,param5,param6,param7);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param8;
                break;
            }
            case 6: //Orientation
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Orientation",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param3);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param4;
                break;
            }
            case 7: //Sequence
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Sequence",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 9: //Depart Sequence
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Depart",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 10: //Attente servo
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Retour servo",_indice:listAction.count,_type:typeBloc})
                break;
            }
            case 11: //Attente dyna
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Retour dyna",_indice:listAction.count,_type:typeBloc})

                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param4,param5);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param3;
                break;
            }
            case 12: //Attente temps
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Retour temps",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 13: //Retour déplacement
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Retour déplacement",_indice:listAction.count,_type:typeBloc})
                break;
            }
            case 14: //Retour orientation
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Retour orientation",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param3);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param2;
                break;
            }
            case 15: //Retour position
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Retour position",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param4);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param3;
                break;
            }
            case 16: //GPIO
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"GPIO",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 17: //retour GPIO
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"retour GPIO",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param3;
                break;
            }
            case 18: //Bloc AND
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"AND",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param1);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param0;
                break;
            }
            case 19:
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"SetValue",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            case 20:
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Courbe",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param3,param4,param7);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param8;
                break;
            }
            case 21:
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Attente Blocage",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param2);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param1;
                break;
            }
            case 22:
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Deplacement",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).bloc.parent.setParam(param0,param1,param2,param3);
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                gridAction.itemAt(listAction.count-1).listTimeOut = param4;
                break;
            }
            case 23:
            {
                listAction.append({_x:xBloc,_y:yBloc, _title:"Fin",_indice:listAction.count,_type:typeBloc})
                gridAction.itemAt(listAction.count-1).listPere = listPere;
                gridAction.itemAt(listAction.count-1).listFils = listFils;
                break;
            }
            }
        }
    }

    GestionTable
    {
        id:table1
        z:1
        seqPapa:gridAction
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onPositionClicked:
        {
            flickable.contentX = action.getXBloc() - (flickable.visibleArea.widthRatio*flickable.contentWidth)/2
            flickable.contentY = action.getYBloc() - (flickable.visibleArea.heightRatio*flickable.contentHeight)/2
        }
    }

    Rectangle
    {
        id:rect
        color:"#323232"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottomMargin: 0
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

                focus:true

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
                    onWheel:
                    {
                        if(root.ctrlPressed)
                        {
                            if(wheel.angleDelta.y<0 && flickable.scale + wheel.angleDelta.y/25  > 0.1)
                            {
                                flickable.scale += wheel.angleDelta.y/25
                            }else if(wheel.angleDelta.y>0 && flickable.scale + wheel.angleDelta.y/25  < 2)
                            {
                                flickable.scale += wheel.angleDelta.y/25
                            }

                            if(wheel.angleDelta.y==-120 && flickable.scale + wheel.angleDelta.y/500  > 0.1)
                            {
                                flickable.scale += wheel.angleDelta.y/500
                            }else if(wheel.angleDelta.y==120 && flickable.scale + wheel.angleDelta.y/500  < 2)
                            {
                                flickable.scale += wheel.angleDelta.y/500
                            }
                        }else
                        {
                            if(root.majPressed)
                            {
                                if(wheel.angleDelta.y<0 && flickable.contentX + wheel.angleDelta.y  > 0)
                                {
                                    flickable.contentX += wheel.angleDelta.y
                                }else if(wheel.angleDelta.y>0 && flickable.contentX + wheel.angleDelta.y  < flickable.contentWidth)
                                {
                                    flickable.contentX += wheel.angleDelta.y
                                }

                            }else
                            {
                                if(wheel.angleDelta.y<0 && flickable.contentY + wheel.angleDelta.y  > 0)
                                {
                                    flickable.contentY += wheel.angleDelta.y
                                }else if(wheel.angleDelta.y>0 && flickable.contentY + wheel.angleDelta.y  < flickable.contentHeight)
                                {
                                    flickable.contentY += wheel.angleDelta.y
                                }
                            }
                        }
                    }

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

                                    if(obj2.objectName==="Sortie" || obj2.objectName === "NumberOut")
                                    {
                                        sortieCourante = obj2
                                    }
                                }else
                                {
                                    clearSelection()
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
                                        if(obj2.objectName === "Entree" && sortieCourante.objectName === "Sortie")
                                        {
                                            sortieCourante.repaint((obj.x+obj2.x+5)-sortieCourante.parent.x-sortieCourante.x,
                                                                   (obj.y+obj2.y+5)-sortieCourante.parent.y-sortieCourante.y)
                                            sortieCourante.addLiaison(obj2);
                                            sortieCourante.parent.bloc.ajouterFils(sortieCourante.indice,obj2.parent.bloc)
                                            obj2.tabPere.push(sortieCourante)
                                            obj2.parent.bloc.ajouterPere(0,sortieCourante.parent.bloc)
                                            if(rect1.survolActif!==null)
                                            {
                                                rect1.survolActif.couleur = "yellow"
                                            }
                                            table1.updateTable()
                                        }else if(obj2.objectName === "NumberIn" && sortieCourante.objectName === "NumberOut")
                                        {

                                            sortieCourante.repaint((obj.x+obj2.x+5)-sortieCourante.parent.x-sortieCourante.x,
                                                                   (obj.y+obj2.y+5)-sortieCourante.parent.y-sortieCourante.y)

                                            sortieCourante.addLiaison(obj2);
                                            sortieCourante.parent.bloc.ajouterNumberOut(obj2.parent.bloc)
                                            obj2.tabPere.push(sortieCourante)
                                            obj2.parent.bloc.ajouterNumberIn(sortieCourante.parent.bloc)
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
                                mouseArea.entreePopup.parent.bloc.supprimerPere(mouseArea.entreePopup.tabPere[index].parent.bloc)

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
                    id:drop1
                    property bool wasDropped:false
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
                        }else if(nomActionToAdd === "Métier")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:4})
                        }else if(nomActionToAdd === "Position")
                        {
                            drop1.wasDropped = true;
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
                        }else if(nomActionToAdd === "Retour déplacement")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:13})
                        }else if(nomActionToAdd === "Retour orientation")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:14})
                        }else if(nomActionToAdd === "Retour position")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:15})
                        }else if(nomActionToAdd === "GPIO")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:16})
                        }else if(nomActionToAdd === "Retour GPIO")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:17})
                        }else if(nomActionToAdd === "AND")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:18})
                        }else if(nomActionToAdd === "SetValue")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:19})
                        }else if(nomActionToAdd === "Courbe")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:20})
                        }else if(nomActionToAdd === "Attente Blocage")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:21})
                        }else if(nomActionToAdd === "Deplacement")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:22})
                        }else if(nomActionToAdd === "Fin")
                        {
                            listAction.append({_x:drag.x,_y:drag.y, _title:nomActionToAdd,_indice:listAction.count,_type:23})
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
                        _couleurInfoBloc:(indice==table1.indiceSelect) ? "blue":"#655e5e"
                        onIWantToDie:
                        {
                            seq.supprimerAction(act.bloc)
                            table1.gestionTable.supprimerAction(act.bloc)
                            listAction.remove(index,1)
                            table1.updateTable()
                        }

                        onCreationComplete:
                        {
                            if(bloc!==null)
                            {
                                seq.ajouterAction(bloc)
                                table1.gestionTable.ajouterAction(bloc)
                                if(drop1.wasDropped === true)
                                {
                                    drop1.wasDropped = false;
                                    table1.updateTable()
                                }

                                bloc.xBloc = x;
                                bloc.yBloc = y;
                            }else
                            {
                                console.log("je suis nuuuuuul")
                            }
                        }
                        property bool findIt:false
                        onClick:
                        {
                            if(root.ctrlPressed)
                            {
                                findIt=false
                                for(var i = 0; i<actionSelected.length; i++)
                                {
                                    if(actionSelected[i]===indice)
                                    {
                                        findIt=true;
                                    }
                                }
                                if(findIt===false)
                                {
                                    actionSelected.push(indice)
                                }
                                _couleurInfoBloc="#0B0B3B"
                            }
                        }
                        onXChange:
                        {
                            if(_couleurInfoBloc==="#0B0B3B")
                            {
                                for(var i=0;i<actionSelected.length;i++)
                                {
                                    if(actionSelected[i]!==indice)
                                    {
                                        gridAction.itemAt(actionSelected[i]).inhibeMoveXY = true
                                        gridAction.itemAt(actionSelected[i]).x += value
                                        gridAction.itemAt(actionSelected[i]).inhibeMoveXY = false
                                    }
                                }
                            }
                        }
                        onYChange:
                        {
                            if(_couleurInfoBloc==="#0B0B3B")
                            {
                                for(var i=0;i<actionSelected.length;i++)
                                {
                                    if(actionSelected[i]!==indice)
                                    {
                                        gridAction.itemAt(actionSelected[i]).inhibeMoveXY = true
                                        gridAction.itemAt(actionSelected[i]).y += value
                                        gridAction.itemAt(actionSelected[i]).inhibeMoveXY = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function copierBloc()
    {
        for(var i = 0; i<actionSelected.length; i++)
        {
            listAction.append({_x:(gridAction.itemAt(actionSelected[i]).x+20),_y:(gridAction.itemAt(actionSelected[i]).y+50), _title:gridAction.itemAt(actionSelected[i]).title,_indice:listAction.count,_type:gridAction.itemAt(actionSelected[i]).type})
        }
        var nbActionToCopy = actionSelected.length;
        clearSelection()
        for(i = 0; i<nbActionToCopy;i++)
        {
            actionSelected.push(listAction.count-i-1)
            gridAction.itemAt(actionSelected[i])._couleurInfoBloc="#0B0B3B"

        }

    }
}
