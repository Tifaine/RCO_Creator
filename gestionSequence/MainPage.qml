import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../Composant"
import "../gestionSequence"
Item {
    id: item1

    Component.onCompleted:
    {
        listServo.clear()
        listDyna.clear();
        listDeplacement.clear();
        listCapteur.clear();
        listAutre.clear();

        listServo.append({_nom:"Servomoteur",        _color:"grey", _index:0})

        listDyna.append({_nom:"Dynamixel",          _color:"grey", _index:0})

        listDeplacement.append({_nom:"Position",           _color:"grey", _index:0})
        listDeplacement.append({_nom:"Orientation",          _color:"grey", _index:1})
        listDeplacement.append({_nom:"Moteur",             _color:"grey", _index:2})

        listCapteur.append({_nom:"Capteur",            _color:"grey", _index:0})

        listAutre.append({_nom:"Autre",              _color:"grey", _index:0})
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


    ZoneEdition {
        id: zoneEdi
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 5
    }
    Rectangle {
        id: rectangleCacheur
        color: "#323232"
        anchors.right: zoneEdi.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: -5

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    property int dragItemIndex: -1

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
                                        zoneEdi.nomActionToAdd = listServo.get(index)._nom

                                    }
                                    rect.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rect.Drag.active
                                    ParentChange {
                                        target: rect
                                        parent: zoneEdi
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
                                        zoneEdi.nomActionToAdd = listDyna.get(index)._nom

                                    }
                                    rectDyna.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectDyna.Drag.active
                                    ParentChange {
                                        target: rectDyna
                                        parent: zoneEdi
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
                                        zoneEdi.nomActionToAdd = listDeplacement.get(index)._nom

                                    }
                                    rectDepl.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectDepl.Drag.active
                                    ParentChange {
                                        target: rectDepl
                                        parent: zoneEdi
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
                                        zoneEdi.nomActionToAdd = listCapteur.get(index)._nom

                                    }
                                    rectCapt.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectCapt.Drag.active
                                    ParentChange {
                                        target: rectCapt
                                        parent: zoneEdi
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
                                        zoneEdi.nomActionToAdd = listAutre.get(index)._nom

                                    }
                                    rectAutre.Drag.drop();
                                }

                            }
                            states: [
                                State {
                                    when: rectAutre.Drag.active
                                    ParentChange {
                                        target: rectAutre
                                        parent: zoneEdi
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
