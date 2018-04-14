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
        nameFilters: [ "Fichier XML (*.xml )" ]
        selectMultiple: false
        selectFolder: false
        onAccepted: {
            ongletSequence.clearAll();
            ongletSequence.ouvrir(fileDialogOuvrir.fileUrl)
        }
    }

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

    BandeauMenu {
        id: bandeauMenu
        z:6
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        onSaveAs: fileDialog.open();
        onOpen: fileDialogOuvrir.open();
        onToggleTable:ongletSequence.toggleTable();
        onMirror: ongletSequence.mirror()
        onUpload:
        {
            ongletSequence.exportXML()
            //ongletSequence.saveAs("file:///tmp/temp.xml")
            gestMQTT.upload();
        }
    }
}
