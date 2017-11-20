import QtQuick 2.0

Item {
    property string couleur
    property int indice
    objectName: "Entree"
    height:10
    width:10
    property var tabPere:[]
    Rectangle
    {
        radius: 5
        anchors.fill: parent
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
