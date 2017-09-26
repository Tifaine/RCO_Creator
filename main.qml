import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import "gestionSequence"
import "Composant"

ApplicationWindow {
    visible: true
    width: 1500
    height: 800
    title: qsTr("RCO Creator V0.2 Banane")
    Rectangle
    {
        anchors.fill: parent
        color:"#323232"
    }
    menuBar: MenuBar {
            Menu {
                title: "File"
                MenuItem { text: "Ouvrir..." }
                MenuItem { text: "Enregistrer" }
                MenuItem { text: "Enregistrer sous..." }
            }

            Menu {
                title: "View"
                MenuItem { text: "Table" }
                MenuItem { text: "Points" }
                MenuItem { text: "Actions" }
            }
        }
    MainPage {
        id: mainPage
        anchors.left: bandeauCote.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 5
        z:0
    }


    BandeauCote {
        id: bandeauCote
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
                pageGestionRobot.visible = true;
                pageGestionAction.visible = false;
                pageConfigActionneurs.visible = false;
                pageGestionSequence.visible = false;
            }
            break;
            case 1:
            {
                pageGestionRobot.visible = false;
                pageGestionAction.visible = false;
                pageConfigActionneurs.visible = true;
                pageGestionSequence.visible = false;

            }
            break;
            case 2:
            {
                pageGestionRobot.visible = false;
                pageGestionAction.visible = true;
                pageConfigActionneurs.visible = false;
                pageGestionSequence.visible = false;

                pageGestionAction.affich();
            }
            break;
            case 3:
            {
                pageGestionRobot.visible = false;
                pageGestionAction.visible = false;
                pageConfigActionneurs.visible = false;
                pageGestionSequence.visible = true;
            }
            break;
            case 4:
            {

            }
            break;
            }

        }
    }





}
