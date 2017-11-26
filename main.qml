import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import "Composant"
import "Sequence"

ApplicationWindow {
    visible: true
    width: 1500
    height: 800
    title: qsTr("RCO Creator V0.3 Chataigne")

    Rectangle
    {
        anchors.fill: parent
        color:"#323232"
    }
    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem
            {
                text: "Ouvrir..."
                onTriggered:
                {
                    ongletSequence.clearAll();
                    ongletSequence.ouvrir("Pouet.xml");
                }
            }

            MenuItem { text: "Enregistrer" }
            MenuItem
            {
                text: "Enregistrer sous..."
                onTriggered:
                {
                    ongletSequence.saveAs("Pouet")
                }
            }
        }

        Menu {
            title: "View"
            MenuItem { text: "Table" }
            MenuItem { text: "Points" }
            MenuItem { text: "Actions" }
        }
    }

    OngletSequence {
        id: ongletSequence
        anchors.left: bandeauCote.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 5
        visible:true
        z:0
    }


    BandeauCote {
        id: bandeauCote
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        onChangeAffich:
        {
            switch(currentIndex)
            {
            case 0:
            {
                ongletSequence.visible = true;
            }
            break;
            case 1:
            {
                ongletSequence.visible = false;
            }
            break;
            case 2:
            {
                ongletSequence.visible = false;
            }
            break;
            case 3:
            {
                ongletSequence.visible = false;
            }
            break;
            case 4:
            {
                ongletSequence.visible = false;
            }
            break;
            }

        }
    }
}
