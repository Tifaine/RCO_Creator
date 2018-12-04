import QtQuick 2.0

Item {
    property string couleur
    property int indice
    objectName: "Entree"
    height:20
    width:20
    z:15
    property var tabPere:[]
    Rectangle
    {
        radius: 5
        anchors.fill: parent
        anchors.margins: 5
        color:couleur
    }

    function harakiri(toBeDeleted)
    {
        for(var i=0;i<tabPere.length;i++)
        {
            tabPere[i].supprimerFils(toBeDeleted)
        }
    }

    function supprimerPere(toBeDeleted)
    {
        tabPere.splice(tabPere.indexOf(toBeDeleted),1)
    }
}
