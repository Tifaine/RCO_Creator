import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id:root
    width: 629
    height:400


    Rectangle {
        id: rectangle2
        color:"#323232"
        anchors.fill: parent
    }

    Rectangle {
        id: rectangle
        height: 2
        color: "#000000"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    Rectangle {
        id: rectangle1
        x: -33
        width: 2
        color: "#000000"
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    Text {
        id: textPosition
        color: "#ffffff"
        text: qsTr("Position")
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: rectangle.bottom
        anchors.topMargin: 10
        font.pixelSize: 15
    }

    ListModel
    {
        id:listPosAvant
        ListElement{ _indice:0 ; indicePre:2}
        ListElement{ _indice:1 ; indicePre:5}
        ListElement{ _indice:2 ; indicePre:6}
    }

    Rectangle
    {
        id:rect
        width: 50
        color:"#323232"
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: textPosition.bottom
        anchors.topMargin: 15
        Flickable {
            id: flickable
            anchors.fill: parent
            contentWidth: 50; contentHeight: 1000
            contentX: 0
            contentY:0
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
                anchors.fill: parent
                color:"transparent"
                Repeater
                {
                    z:3
                    id:repeaterPosAvant
                    model:listPosAvant
                    width: 50

                    Rectangle
                    {
                        height: 30
                        radius: 15
                        width:30
                        color:"green"
                        anchors.top: repeaterPosAvant.top
                        anchors.topMargin: 40*_indice
                        anchors.left: repeaterPosAvant.left
                        anchors.leftMargin: 5
                        anchors.right: repeaterPosAvant.right
                        anchors.rightMargin: 15

                        Text
                        {
                            text:indicePre
                            anchors.fill: parent
                            font.bold: true
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
    }

    ListModel
    {
        id:listPosApres
        ListElement{ _indice:0 ; indicePre:3}
        ListElement{ _indice:1 ; indicePre:4}
        ListElement{ _indice:2 ; indicePre:9}
    }

    Rectangle
    {
        id:rect1
        width: 50
        color:"#323232"
        anchors.top: textPosition.bottom
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: rectangle1.left
        anchors.rightMargin: 5
        Flickable {
            id: flickable1
            anchors.fill: parent
            contentWidth: 50; contentHeight: 1000
            contentX: 0
            contentY:0
            ScrollBar.vertical: ScrollBar {
                parent: flickable1.parent
                anchors.top: flickable1.top
                anchors.left: flickable1.right
                anchors.leftMargin: -10
                anchors.bottom: flickable1.bottom
            }
            ScrollBar.horizontal: ScrollBar {
                parent: flickable1.parent
                anchors.left: flickable1.left
                anchors.right: flickable1.right
                anchors.bottom: flickable1.bottom
            }
            Rectangle
            {
                anchors.fill: parent
                color:"transparent"
                Repeater
                {
                    z:3
                    id:repeaterPosApres
                    model:listPosApres
                    width: 50

                    Rectangle
                    {
                        height: 30
                        radius: 15
                        width:30
                        color:"green"
                        anchors.top: repeaterPosApres.top
                        anchors.topMargin: 40*_indice
                        anchors.left: repeaterPosApres.left
                        anchors.leftMargin: 15
                        anchors.right: repeaterPosApres.right
                        anchors.rightMargin: 5

                        Text
                        {
                            text:indicePre
                            anchors.fill: parent

                            font.bold: true
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
    }


}
