import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import "../Composant"


Item {
    focus:true
    property bool ctrlPressed:false
    property bool majPressed:false
    property var fichierLoad:""

    Keys.onPressed: {
        if (event.key === Qt.Key_Control)
        {
            ctrlPressed = true
        }else if(event.key === Qt.Key_Shift)
        {
            majPressed = true;
        }else if(event.key === Qt.Key_S)
        {
            if(ctrlPressed && fichierLoad!="")
            {
                saveAs(fichierLoad)
            }
        }else if(event.key === Qt.Key_I)
        {
            if(ctrlPressed)
            {
                repeaterOnglet.itemAt(bar.currentIndex).children[0].reorganiserBloc()
            }
        }else if(event.key === Qt.Key_V)
        {
            console.log("V ",ctrlPressed)
        }
    }
    Keys.onReleased: {
        if (event.key === Qt.Key_Control)
        {
            ctrlPressed = false
        }else if(event.key === Qt.Key_Shift)
        {
            majPressed = false;
        }
    }

    property var tabNomTab:[]
    id:item1
    Component.onCompleted:
    {

        listServo.clear()
        listDyna.clear();
        listDeplacement.clear();
        listCapteur.clear();
        listAutre.clear();

        listServo.append({_nom:"Servomoteur",                   _color:"grey", _index:0})
       // listServo.append({_nom:"Attente servo",                 _color:"grey", _index:1})

        listDyna.append({_nom:"Dynamixel",                      _color:"grey", _index:0})
        listDyna.append({_nom:"Attente dyna",                   _color:"grey", _index:1})

        listDeplacement.append({_nom:"Position",                _color:"grey", _index:0})
        listDeplacement.append({_nom:"Orientation",             _color:"grey", _index:1})
        listDeplacement.append({_nom:"Déplacement",             _color:"grey", _index:2})
        listDeplacement.append({_nom:"Courbe",                  _color:"grey", _index:3})
       // listDeplacement.append({_nom:"Retour déplacement",      _color:"grey", _index:3})
        //listDeplacement.append({_nom:"Retour orientation",      _color:"grey", _index:4})
        //listDeplacement.append({_nom:"Retour position",         _color:"grey", _index:5})

       /* listCapteur.append({_nom:"Capteur",             _color:"grey", _index:0})
        listCapteur.append({_nom:"GPIO",                _color:"grey", _index:1})
        listCapteur.append({_nom:"Retour GPIO",         _color:"grey", _index:2})*/

        listAutre.append({_nom:"AND",                   _color:"grey", _index:0})
        listAutre.append({_nom:"Séquence",              _color:"grey", _index:1})
        listAutre.append({_nom:"Départ",                _color:"grey", _index:2})
        listAutre.append({_nom:"Attente temps",         _color:"grey", _index:3})
        listAutre.append({_nom:"SetValue",              _color:"grey", _index:4})

    }

    function ouvrir(nomFichier)
    {
        repeaterOnglet.itemAt(bar.currentIndex).children[0].ouvrirFile(nomFichier)
        fichierLoad = nomFichier;
    }

    function saveAs(nomFichier)
    {
        repeaterOnglet.itemAt(bar.currentIndex).children[0].saveAs(nomFichier)
    }

    function clearAll()
    {
        repeaterOnglet.itemAt(bar.currentIndex).children[0].clearAll();
    }


    ListModel
    {
        id:listServo
        ListElement{ _nom:"Bras Gauche" ; _color:"grey"; _index:0}
    }

    ListModel
    {
        id:listDyna
        ListElement{ _nom:"Bras Gauche" ; _color:"grey"; _index:0}
    }
    ListModel
    {
        id:listDeplacement
        ListElement{ _nom:"Bras Gauche" ; _color:"grey"; _index:0}
    }
    ListModel
    {
        id:listCapteur
        ListElement{ _nom:"Bras Gauche" ; _color:"grey"; _index:0}
    }ListModel
    {
        id:listAutre
        ListElement{ _nom:"Bras Gauche" ; _color:"grey"; _index:0}
    }

    Menu
    {
        id:contextMenu
        MenuItem
        {
            text:"Supprimer"
            onTriggered:
            {
                listOnglet.remove(bar.currentIndex,1)
                tabNomTab.splice(bar.currentIndex-1,1)
            }
        }
    }

    TabView {
        id: bar
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 5

        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color:  "dimgrey"
                border.width: 1
                border.color: styleData.selected ? "blue":"black"

                implicitWidth: text.width + 30
                implicitHeight: 35
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: "white"
                }
                MouseArea
                {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked:
                    {
                        bar.currentIndex = index
                        if (mouse.button === Qt.RightButton && index !== 0)
                        {
                            contextMenu.popup()
                        }
                    }
                }
            }
            frame: Rectangle { color: "steelblue" }
        }

        ListModel
        {
            id:listOnglet
            ListElement{ _nom:"Séquence principale" ; _index:0}
        }
        Connections
        {
            target:gestSequence
            onAfficherSequence:
            {
                if(tabNomTab.indexOf(nomSequence)===-1)
                {
                    tabNomTab.push(nomSequence)
                    listOnglet.append({_nom:nomSequence,_index:listOnglet.count})
                    repeaterOnglet.nbTabOpen++
                    bar.currentIndex = listOnglet.count-1

                    for(var i = 0;i<listOnglet.count;i++)
                    {
                        console.log(repeaterOnglet.itemAt(i).title+" "+repeaterOnglet.itemAt(i).children[0].indiceTab)
                    }

                    clearAll()
                    repeaterOnglet.itemAt(bar.currentIndex).children[0].ouvrirFile("scripts/"+nomSequence)
                }else
                {
                    bar.currentIndex = tabNomTab.indexOf(nomSequence)+1
                }
            }
        }

        Repeater
        {

            id:repeaterOnglet
            model:listOnglet
            property int nbTabOpen:0
            Tab
            {
                id:tab
                title: _nom
                ZoneEdition {
                    id: zoneEdi
                    //indiceZoneEdi: _index
                    anchors.fill: parent
                    indiceTab:index
                    ctrlPressed: item1.ctrlPressed
                    majPressed: item1.majPressed
                    /*onAjouterTab:
                    {

                    }*/
                }

            }
        }
    }

    Rectangle {
        id: rectangle1
        width: 20
        height: 20
        color: "#bdbdbd"
        radius: 10
        anchors.topMargin: item1.height/2 -height/2
        anchors.left: rectangle.right
        anchors.leftMargin: -7
        anchors.top: parent.top
        z:2



        Text {
            id: text1
            text: qsTr("<")
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 16
        }

        MouseArea {
            property int nbClic :0
            id: mouseArea1
            anchors.fill: parent
            onClicked:
            {
                if(nbClic ===0)
                {
                    text1.text = ">"
                    nbClic = 1
                    rectangle.x = 10
                    columnLayout.visible = false

                }else
                {
                    text1.text = "<"
                    nbClic = 0;
                    rectangle.x = 160
                    columnLayout.visible = true
                }
            }
        }
    }
    Rectangle {
        id: rectangle
        x: 160
        width: 1
        z:1
        color: "black"

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    property int dragItemIndex: -1

    Rectangle
    {
        anchors.right: rectangle.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        color:"#323232"
    }

    ColumnLayout {
        id: columnLayout
        anchors.right: rectangle.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        spacing: 1
        property var currentItem: null
        PanelItem {
            id:moveBiatch
            current: false
            title: "Servo"
            Rectangle {
                color: "dimgrey"
                anchors.fill: parent

                Grid {
                    id: grid
                    columns: parent.width / 150
                    spacing: 2
                    anchors.fill: parent

                    Repeater
                    {
                        id:gridGenerate
                        model:listServo
                        Rectangle
                        {
                            id:rect
                            height:50
                            width:150
                            color: "grey"
                            property int index : _index

                            Text
                            {
                                anchors.fill: parent
                                text: _nom
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            MouseArea
                            {
                                id:mouseArea2
                                anchors.fill: parent
                                drag.target: rect;
                                drag.onActiveChanged: {
                                    if (mouseArea2.drag.active) {
                                        repeaterOnglet.itemAt(bar.currentIndex).children[0].nomActionToAdd = listServo.get(index)._nom
                                    }
                                    rect.Drag.drop();
                                }
                            }
                            states: [
                                State {
                                    when: rect.Drag.active
                                    ParentChange {
                                        target: rect
                                        parent: repeaterOnglet.itemAt(bar.currentIndex).children[0]
                                    }

                                    AnchorChanges {
                                        target: rect
                                        anchors.horizontalCenter: undefined
                                        anchors.verticalCenter: undefined
                                    }
                                }
                            ]
                            Drag.active: mouseArea2.drag.active
                            Drag.hotSpot.x: rect.width / 2
                            Drag.hotSpot.y: rect.height / 2

                        }
                    }
                }
            }
        }

        PanelItem {
            current: false
            title: "Dynamixel"
            Rectangle {
                color: "dimgrey"
                anchors.fill: parent

                Grid {
                    columns: parent.width / 150
                    spacing: 2
                    anchors.fill: parent

                    Repeater
                    {
                        id:gridGenerate1
                        model:listDyna
                        Rectangle
                        {
                            id:rectDyna
                            height:50
                            width:150
                            color: "grey"
                            property int index : _index

                            Text
                            {
                                anchors.fill: parent
                                text: _nom
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            MouseArea
                            {
                                id:mouseArea3
                                anchors.fill: parent
                                drag.target: rectDyna;
                                drag.onActiveChanged: {
                                    if (mouseArea3.drag.active) {
                                        repeaterOnglet.itemAt(bar.currentIndex).children[0].nomActionToAdd = listDyna.get(index)._nom

                                    }
                                    rectDyna.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectDyna.Drag.active
                                    ParentChange {
                                        target: rectDyna
                                        parent: repeaterOnglet.itemAt(bar.currentIndex).children[0]
                                    }

                                    AnchorChanges {
                                        target: rectDyna
                                        anchors.horizontalCenter: undefined
                                        anchors.verticalCenter: undefined
                                    }
                                }
                            ]
                            Drag.active: mouseArea3.drag.active
                            Drag.hotSpot.x: rectDyna.width / 2
                            Drag.hotSpot.y: rectDyna.height / 2

                        }
                    }
                }
            }
        }

        PanelItem {
            current: false
            title: "Déplacement"
            Rectangle {
                color: "dimgrey"
                anchors.fill: parent

                Grid {
                    columns: parent.width / 150
                    spacing: 2
                    anchors.fill: parent

                    Repeater
                    {
                        id:gridGenerate2
                        model:listDeplacement
                        Rectangle
                        {
                            id:rectDepl
                            height:50
                            width:150
                            color: "grey"
                            property int index : _index

                            Text
                            {
                                anchors.fill: parent
                                text: _nom
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            MouseArea
                            {
                                id:mouseArea4
                                anchors.fill: parent
                                drag.target: rectDepl;
                                drag.onActiveChanged: {
                                    if (mouseArea4.drag.active) {
                                        repeaterOnglet.itemAt(bar.currentIndex).children[0].nomActionToAdd = listDeplacement.get(index)._nom

                                    }
                                    rectDepl.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectDepl.Drag.active
                                    ParentChange {
                                        target: rectDepl
                                        parent: repeaterOnglet.itemAt(bar.currentIndex).children[0]
                                    }

                                    AnchorChanges {
                                        target: rectDepl
                                        anchors.horizontalCenter: undefined
                                        anchors.verticalCenter: undefined
                                    }
                                }
                            ]
                            Drag.active: mouseArea4.drag.active
                            Drag.hotSpot.x: rectDepl.width / 2
                            Drag.hotSpot.y: rectDepl.height / 2

                        }
                    }
                }
            }
        }

        PanelItem {
            current: false
            title: "Capteur"
            Rectangle {
                color: "dimgrey"
                anchors.fill: parent

                Grid {
                    columns: parent.width / 150
                    spacing: 2
                    anchors.fill: parent

                    Repeater
                    {
                        id:gridGenerate3
                        model:listCapteur
                        Rectangle
                        {
                            id:rectCapt
                            height:50
                            width:150
                            color: "grey"
                            property int index : _index

                            Text
                            {
                                anchors.fill: parent
                                text: _nom
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            MouseArea
                            {
                                id:mouseArea5
                                anchors.fill: parent
                                drag.target: rectCapt;
                                drag.onActiveChanged: {
                                    if (mouseArea5.drag.active) {
                                        repeaterOnglet.itemAt(bar.currentIndex).children[0].nomActionToAdd = listCapteur.get(index)._nom

                                    }
                                    rectCapt.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectCapt.Drag.active
                                    ParentChange {
                                        target: rectCapt
                                        parent: repeaterOnglet.itemAt(bar.currentIndex).children[0]
                                    }

                                    AnchorChanges {
                                        target: rectCapt
                                        anchors.horizontalCenter: undefined
                                        anchors.verticalCenter: undefined
                                    }
                                }
                            ]
                            Drag.active: mouseArea5.drag.active
                            Drag.hotSpot.x: rectCapt.width / 2
                            Drag.hotSpot.y: rectCapt.height / 2

                        }
                    }
                }
            }
        }

        PanelItem {
            current: false
            title: "Autre"
            Rectangle {
                color: "dimgrey"
                anchors.fill: parent

                Grid {
                    columns: parent.width / 150
                    spacing: 2
                    anchors.fill: parent

                    Repeater
                    {
                        id:gridGenerate4
                        model:listAutre
                        Rectangle
                        {
                            id:rectAutre
                            height:50
                            width:150
                            color: "grey"
                            property int index : _index

                            Text
                            {
                                anchors.fill: parent
                                text: _nom
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            MouseArea
                            {
                                id:mouseArea6
                                anchors.fill: parent
                                drag.target: rectAutre;
                                drag.onActiveChanged: {
                                    if (mouseArea6.drag.active) {
                                        repeaterOnglet.itemAt(bar.currentIndex).children[0].nomActionToAdd = listAutre.get(index)._nom

                                    }
                                    rectAutre.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectAutre.Drag.active
                                    ParentChange {
                                        target: rectAutre
                                        parent: repeaterOnglet.itemAt(bar.currentIndex).children[0]
                                    }

                                    AnchorChanges {
                                        target: rectAutre
                                        anchors.horizontalCenter: undefined
                                        anchors.verticalCenter: undefined
                                    }
                                }
                            ]
                            Drag.active: mouseArea6.drag.active
                            Drag.hotSpot.x: rectAutre.width / 2
                            Drag.hotSpot.y: rectAutre.height / 2

                        }
                    }
                }
            }
        }

        Item {
            height:1
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
