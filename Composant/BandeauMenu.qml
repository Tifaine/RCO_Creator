import QtQuick 2.4

Item {
    id: item1
    width: 1500
    height: 50
    signal saveAs();
    signal save();
    signal open();
    signal upload();
    signal toggleTable();
    Rectangle
    {
        anchors.fill: parent
        color:"#323232"
    }
    Rectangle
    {
        y: 49
        height: 1
        color: "#000000"
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    Image {
        id: imageSave
        width: 30
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10

        source: "file::/../image/svg/save.svg"
        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: save()
            }
        }
    }

    Image {
        id: imageSaveAs1

        width: 30
        source: "file::/../image/svg/backup.svg"
        anchors.left: imageSave.right
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 10

        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: saveAs()
            }

        }
    }

    Image {
        id: imageLoad
        x: 0
        y: -5
        width: 30
        source: "file::/../image/svg/folder.svg"
        anchors.right: imageUpload.left
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        anchors.rightMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 10
        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: open()
            }
        }
    }

    Image {
        id: imageToggleTable
        x: 0
        y: -5
        width: 30
        source: "file::/../image/svg/table_icon.svg"
        anchors.left: imageSaveAs1.right
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 10
        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: toggleTable()
            }
        }
    }

    Image {

        id: imageStop
        x: 1235
        width: 20
        anchors.left: imagePause.right
        anchors.leftMargin: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        source: "file::/../image/svg/stop.svg"

        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: gestMQTT.stop();
            }
        }
    }

    Image {
        id: imagePause
        x: 1105
        width: 20
        anchors.right: parent.right
        anchors.rightMargin: parent.width/2+width/2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        source: "file::/../image/svg/pause.svg"

        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: gestMQTT.pause();
            }
        }
    }

    Image {
        id: imagePlay
        x: 981
        width: 20
        anchors.right: imagePause.left
        anchors.rightMargin: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        source: "file::/../image/svg/play-button.svg"

        Rectangle
        {
            z:-1
            anchors.fill: parent
            anchors.leftMargin: -7
            anchors.rightMargin: -7
            anchors.bottomMargin: -7
            anchors.topMargin: -7
            color:"transparent"
            radius: 3
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: gestMQTT.play();
            }
        }

    }

    Rectangle {
        x: -7
        y: 49
        height: 1
        color: "#000000"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: -246
        anchors.leftMargin: 256
        anchors.left: parent.left
        anchors.bottomMargin: 0
    }

    Image {
        id: imageReglages
        x: 1228
        y: -7
        width: 20
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.bottom: parent.bottom
        Rectangle {
            color: "#00000000"
            radius: 3
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
            }
            anchors.rightMargin: -7
            anchors.leftMargin: -7
            anchors.topMargin: -7
            anchors.fill: parent
            z: -1
            anchors.bottomMargin: -7
        }
        source: "file::/../image/svg/settings-5.svg"
        anchors.topMargin: 15
        anchors.bottomMargin: 15
        anchors.top: parent.top
    }

    Image {
        id: imageUpload
        x: 971
        y: -7
        width: 20
        anchors.rightMargin: 25
        anchors.bottom: parent.bottom
        Rectangle {
            color: "#00000000"
            radius: 3
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: parent.color="#404040"
                onExited: parent.color="transparent"
                onClicked: upload();
            }
            anchors.rightMargin: -7
            anchors.leftMargin: -7
            anchors.topMargin: -7
            anchors.fill: parent
            z: -1
            anchors.bottomMargin: -7
        }
        anchors.right: imageReglages.left
        source: "file::/../image/svg/send.svg"
        anchors.topMargin: 15
        anchors.bottomMargin: 15
        anchors.top: parent.top
    }

}
