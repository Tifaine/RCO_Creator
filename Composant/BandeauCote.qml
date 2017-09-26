import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2


Item {
    signal changeAffich(int currentIndex);
    width: 100
    height: 800
    Component.onCompleted:
    {
    }
    Rectangle
    {
        anchors.fill: parent
        color:"#323232"
    }

    VerticalTabBar
    {
        id:verticalBar
        anchors.fill: parent
        visible: true
        onChangeIndice:
        {
            changeAffich(currentIndex);
        }
    }
}
