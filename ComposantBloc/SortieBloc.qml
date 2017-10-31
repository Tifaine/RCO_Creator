import QtQuick 2.0
import connector 1.0

Item {
    id:root
    property string couleur
    property string couleurSelected:"#FF007F"
    property int indice:-1
    objectName: "Sortie"
    height:12
    width:12
    property var tabFils:[]

    Rectangle
    {
        radius: 6
        anchors.fill: parent
        color:couleur
    }

    ListModel
    {
        id:listLien
        ListElement{_x1:5; _y1:5; _x2:5; _y2:5}
    }

    Repeater
    {
        id:repeaterLien
        model:listLien

        Liaison
        {
            id:liaison
            antialiasing: true
            _color:couleurSelected
            z:  -1
            x1: _x1
            y1: _y1
            x2: _x2
            y2: _y2
        }
    }

    function haraKiri(toBeDeleted)
    {
        for(var i=0;i<tabFils.length;i++)
        {
            tabFils[i].supprimerPere(toBeDeleted)
        }
        listLien.clear();
    }

    function supprimerFils(fils)
    {
        listLien.remove(tabFils.indexOf(fils))
        tabFils.splice(tabFils.indexOf(fils),1)
    }

    function repaint(x,y)
    {
        listLien.setProperty(listLien.count-1,"_x2",x)
        listLien.setProperty(listLien.count-1,"_y2",y)       
    }

    function pereBouge(xPere, yPere)
    {
        for(var i=0;i<tabFils.length;i++)
        {
            listLien.setProperty(i,"_x2",5+(tabFils[i].parent.x+tabFils[i].x)-xPere-root.x)
            listLien.setProperty(i,"_y2",5+(tabFils[i].parent.y+tabFils[i].y)-yPere-root.y)
        }
    }

    function filsBouge(fils,x,y)
    {
        listLien.setProperty(tabFils.indexOf(fils),"_x2",x)
        listLien.setProperty(tabFils.indexOf(fils),"_y2",y)
    }

    function addLiaison(fils)
    {
        listLien.append({"_x1":5, "_y1":5, "_x2":5, "_y2":5})
        tabFils.push(fils)
    }
}
