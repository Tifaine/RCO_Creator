import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../Composant"
import "../gestionSequence"
Item {

    Component.onCompleted:
    {
        listServo.clear()
        listServo.append({_nom:"Position",           _color:"grey", _index:0})
        listServo.append({_nom:"Orientation",          _color:"grey", _index:1})
        listServo.append({_nom:"Servomoteur",        _color:"grey", _index:2})
        listServo.append({_nom:"Dynamixel",          _color:"grey", _index:3})
        listServo.append({_nom:"Capteur",            _color:"grey", _index:4})
        listServo.append({_nom:"Moteur",             _color:"grey", _index:5})
        listServo.append({_nom:"Autre",              _color:"grey", _index:6})
    }

    ListModel
    {
        id:listServo
        ListElement{ _nom:"Bras Gauche" ; _color:"grey"; _index:0}
    }

    Rectangle {
        id: rectangle
        x: 160
        width: 1
        color: "black"

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5

        MouseArea {
            id: mouseArea
            anchors.rightMargin: -2
            anchors.leftMargin: -2
            anchors.bottomMargin: -2
            anchors.topMargin: -2
            anchors.fill: parent
            drag.target: parent;
            propagateComposedEvents:true
            hoverEnabled: true
            onPositionChanged:
            {

            }
            onContainsMouseChanged:
            {
                if(containsMouse === true)
                {
                    cursorShape = Qt.SizeHorCursor
                }
            }
        }
    }

    ZoneEdition {
        id: zoneEdi
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 5
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
            current: true
            title: ""
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

        Item {
            height:1
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
