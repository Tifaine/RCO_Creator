import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import "Composant"
import "Sequence"

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1500
    height: 800
    title: qsTr("RCO Creator V0.3 Chataigne")




    Rectangle
    {
        anchors.fill: parent
        color:"#323232"
    }


    FileDialog {
        id: fileDialog
        title: "Enregistrer sous ..."
        nameFilters: [ "Fichier XML (*.xml )"]
        selectMultiple: false
        selectExisting: false
        selectFolder: false
        onAccepted: {
            ongletSequence.saveAs(fileDialog.fileUrl)
        }
    }

    FileDialog {
        id: fileDialogOuvrir
        title: "Ouvrir ..."
        nameFilters: [ "Fichier XML (*.xml )"]
        selectMultiple: false
        selectFolder: false
        onAccepted: {
            ongletSequence.clearAll();
            ongletSequence.ouvrir(fileDialogOuvrir.fileUrl)
        }
    }
//    menuBar: MenuBar {
//        Menu {
//            title: "File"
//            MenuItem
//            {
//                text: "Ouvrir..."
//                onTriggered:
//                {
//                    fileDialogOuvrir.open();
//                }
//            }

//            MenuItem { text: "Enregistrer" }
//            MenuItem
//            {
//                text: "Enregistrer sous..."
//                onTriggered:
//                {
//                    fileDialog.open();
//                }
//            }
//        }

//        Menu {
//            title: "View"
//            MenuItem { text: "Table" }
//            MenuItem { text: "Points" }
//            MenuItem { text: "Actions" }
//        }
//    }

    OngletSequence {
        id: ongletSequence
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: bandeauMenu.bottom
        anchors.leftMargin: 0
        visible:true
        z:5
    }

    /*BandeauCote {
        id: bandeauCote
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: bandeauMenu.bottom
        anchors.topMargin: 0
        onChangeAffich:
        {
            switch(currentIndex)
            {
            case 0:
                ongletSequence.visible = true;
                break;
            case 1:
                ongletSequence.visible = false;
                break;
            case 2:
                ongletSequence.visible = false;
                break;
            case 3:
                ongletSequence.visible = false;
                break;
            case 4:
                ongletSequence.visible = false;
                break;
            }
        }
    }*/

    BandeauMenu {
        id: bandeauMenu
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        onSaveAs: fileDialog.open();
        onOpen: fileDialogOuvrir.open();
        onUpload:
        {
            ongletSequence.saveAs("file:///tmp/temp.xml")
            gestMQTT.upload();
        }
    }
}
