import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    id: item1
    width: 100
    height: 500
    signal changeIndice(int currentIndex);
    property int indice: tabBar.currentIndex


    TabBar {
        id: tabBar
        x: -200
        y: 200
        width: 500
        height: 100
        rotation: 90

        TabButton {
            id: tabButton
            x: 0
            height: 100

            text: qsTr("Config. Robot")
            rotation: -90
            onClicked:
            {
                changeIndice(0);
            }
        }

        TabButton {
            id: tabButton1
            height: 100

            text: qsTr("Config. Action")
            rotation: -90
            onClicked:
            {
                changeIndice(1);
            }
        }

        TabButton {
            id: tabButton2
            height: 100
            text: qsTr("Stratégie")
            rotation: -90
            onClicked:
            {
                changeIndice(2);
            }
        }

        TabButton {
            id: tabButton3
            height: 100
            text: qsTr("Séquence")
            rotation: -90
            onClicked:
            {
                changeIndice(3);
            }
        }

        TabButton {
            id: tabButton4
            height: 100
            text: qsTr("Live")
            rotation: -90
            onClicked:
            {
                changeIndice(4);
            }
        }
    }


}
