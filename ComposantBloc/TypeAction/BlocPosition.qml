import QtQuick 2.0
import QtQuick.Controls 2.2
import actionPos 1.0
import "../../Composant"

Item {
    id: root
    width: 180
    height: 510
    signal modifTaille(int taille)
    property int taille:70
    property var fils:pos
    function tailleChange(_taille)
    {
        root.taille = _taille
        modifTaille(taille);
    }
    onStateChanged:
    {
        if(state==="ouvert")
        {
            if(cbVitesse.indice===3)
            {
                tfVitesseEnable = true
                tfVitesse.visible = true;
                textAcc.anchors.top = tfVitesse.bottom
                tailleChange(root.height+tfVitesse.height+5)

                cbVitesse.setIndice(2);
                cbVitesse.setIndice(3);
            }
        }else
        {
            tfVitesse.visible = false
        }
    }

    function setParam(posX, posY, vitesse, acc, dec, sens, precision, timeout, detection, stabilisation)
    {
        tfX.text = posX;
        tfY.text = posY;
        if(stabilisation==="")stabilisation = -1
        tfStab.text = stabilisation

        switch(vitesse)
        {
        case "1000":
            cbVitesse.setIndice(0);
            break;
        case "700":
            cbVitesse.setIndice(1);
            break;
        case "300":
            cbVitesse.setIndice(2);
            break;
        default:
            cbVitesse.setIndice(3);
            tfVitesseEnable = true
            pos.vitesse = true
            tfVitesse.visible = true
            tfVit.text = vitesse
            break;
        }

        switch(acc)
        {
        case "1000":
            cbAcc.setIndice(0);
            break;
        case "700":
            cbAcc.setIndice(1);
            break;
        case "300":
            cbAcc.setIndice(2);
            break;
        default:
            cbAcc.setIndice(3);
            tfAccEnable = true
            pos.acceleration = acc
            tfAcc.visible = true
            tfAccel.text = acc
            break;
        }

        switch(dec)
        {
        case "1000":
            cbDec.setIndice(0);
            break;
        case "700":
            cbDec.setIndice(1);
            break;
        case "300":
            cbDec.setIndice(2);
            break;
        default:
            cbDec.setIndice(3);
            tfDecEnable = true
            pos.deceleration = dec
            tfDec.visible = true
            tfDecel.text = dec;
            break;
        }
        switch(detection)
        {
        case "0":
            cbDetect.setIndice(0)
            break;
        case "1":
            cbDetect.setIndice(1)
            break;
        case "2":
            cbDetect.setIndice(2)
            break;
        case "3":
            cbDetect.setIndice(3)
            break;
        default:
            cbDetect.setIndice(0)
        }

        if(sens === "0")
        {
            switchSens.checked = false
        }else
        {
            switchSens.checked = true
        }
        pos.sens = switchSens.checked

        tfPrecision.text = precision

        tfTimeOut.text = timeout
    }

    property bool tfVitesseEnable:false
    property bool tfAccEnable:false
    property bool tfDecEnable:false
    Component.onCompleted:
    {
        root.state = "ouvert"
        if(cbAcc.indice === 3)
        {
            tfAcc.visible = true
        }

        if(cbDec.indice === 3)
        {
            tfDec.visible = true
        }

        if(cbVitesse.indice === 3)
        {
            tfVit.visible = true
        }

        var tailleToSend = 510
        if(tfVitesseEnable===true)tailleToSend+=tfVitesse.height+5
        if(tfAccEnable===true)tailleToSend+=tfAcc.height+5
        if(tfDecEnable===true)tailleToSend+=tfDec.height+5;
        tailleChange(tailleToSend)

    }

    Pos
    {
        id:pos
        xRobot: tfX.text
        yRobot: tfY.text

        onXRobotChanged:
        {
            tfX.text = xRobot
        }

        onYRobotChanged:
        {
            tfY.text = yRobot
        }

        //sens:switchSens.checked
    }

    TextField {
        id: tfX
        width: 50
        height: 30
        text: qsTr("0")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textX.bottom
        anchors.topMargin: 5
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    TextField {
        id: tfY
        x: 64
        width: 50
        height: 30
        text: qsTr("1000")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: textY.bottom
        anchors.topMargin: 5
        color: "white"

        background:Rectangle
        {
            radius:7
            anchors.fill: parent
            color:"#4a4545"
        }
    }

    Text {
        id: textX
        text: qsTr("X :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    Text {
        id: textY
        x: 125
        text: qsTr("Y :")
        anchors.right: parent.right
        anchors.rightMargin: 41
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }

    Text {
        id: textVitesse
        text: qsTr("Vitesse :")
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: tfX.bottom
        anchors.topMargin: 5
        font.pixelSize: 12
    }

    CustomComboBox
    {
        id: cbVitesse
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textVitesse.bottom
        anchors.topMargin: 5
        _model: [ "Forte (1000 mm/s)", "Moyenne (700 mm/s)", "Faible (300 mm/s)", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 3)
            {
                if(tfVitesse.visible===false)
                {
                    tfVitesseEnable = true
                    textAcc.anchors.top = tfVitesse.bottom
                    tailleChange(root.height+tfVitesse.height+5)

                    tfVitesse.visible = true;

                }
            }else
            {
                if(tfVitesse.visible===true)
                {
                    tfVitesseEnable = false
                    tfVitesse.visible = false;
                    textAcc.anchors.top = cbVitesse.bottom
                    tailleChange(root.height-tfVitesse.height-5)
                }
            }
            switch(indice)
            {
            case 0:
                pos.vitesse = 1000;
                break;
            case 1:
                pos.vitesse = 700;
                break;
            case 2:
                pos.vitesse = 300;
                break;
            case 3:
                pos.vitesse = tfVit.text;
                break;
            }
        }
        Component.onCompleted: cbVitesse.setIndice(2)

    }

    Rectangle
    {
        id: tfVitesse
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbVitesse.bottom
        anchors.topMargin: 5
        visible: true
        color:"#4a4545"

        TextEdit
        {
            id:tfVit
            height: 30
            text: qsTr("800")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                pos.vitesse = text
            }
        }
    }



    Text {
        id: textAcc
        text: qsTr("Accélération :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbVitesse.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }



    CustomComboBox
    {
        id: cbAcc
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textAcc.bottom
        anchors.topMargin: 5
        _model: [ "Forte (1000 mm/s)", "Moyenne (700 mm/s)", "Faible (300 mm/s)", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 3)
            {
                if(tfAcc.visible===false)
                {
                    tfAccEnable = true
                    tfAcc.visible = true;
                    textDec.anchors.top = tfAcc.bottom
                    tailleChange(root.height+tfAcc.height+5)
                }
            }else
            {
                if(tfAcc.visible===true)
                {
                    tfAccEnable = false
                    tfAcc.visible = false;
                    textDec.anchors.top = cbAcc.bottom
                    tailleChange(root.height-tfAcc.height-5)
                }
            }
            switch(indice)
            {
            case 0:
                pos.acceleration = 1000;
                break;
            case 1:
                pos.acceleration = 700;
                break;
            case 2:
                pos.acceleration = 300;
                break;
            case 3:
                pos.acceleration = tfAccel.text;
                break;
            }
        }
    }

    Rectangle
    {
        id: tfAcc
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        visible:false
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbAcc.bottom
        anchors.topMargin: 5

        color:"#4a4545"

        TextEdit
        {
            id:tfAccel
            height: 30
            text: qsTr("800")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                pos.acceleration = text
            }
        }
    }

    Text {
        id: textDec
        text: qsTr("Décélération :")
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbAcc.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
    }



    CustomComboBox
    {
        id: cbDec
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textDec.bottom
        anchors.topMargin: 5
        _model: [ "Forte (1000 mm/s)", "Moyenne (700 mm/s)", "Faible (300 mm/s)", "Custom..." ]
        onCustomCurrentIndexChanged:
        {
            if(indice === 3)
            {
                if(tfDec.visible===false)
                {
                    tfDecEnable = true
                    tfDec.visible = true;
                    switchSens.anchors.top = tfDec.bottom
                    tailleChange(root.height+tfDec.height+5)
                }
            }else
            {
                if(tfDec.visible===true)
                {
                    tfDecEnable = false
                    tfDec.visible = false;
                    switchSens.anchors.top = cbDec.bottom
                    tailleChange(root.height-tfDec.height-5)
                }
            }
            switch(indice)
            {
            case 0:
                pos.deceleration = 1000;
                break;
            case 1:
                pos.deceleration = 700;
                break;
            case 2:
                pos.deceleration = 300;
                break;
            case 3:
                pos.deceleration = tfDecel.text;
                break;
            }
        }
    }

    Rectangle
    {
        id: tfDec
        height: 30
        radius:7
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbDec.bottom
        anchors.topMargin: 5

        color:"#4a4545"

        TextEdit
        {
            id:tfDecel
            height: 30
            text: qsTr("800")
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "white"
            verticalAlignment: Text.AlignVCenter
            onTextChanged:
            {
                pos.deceleration = text
            }
        }
    }

    Switch {
        id: switchSens
        text:checked?"Marche arriere":"Marche avant"

        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: cbDec.bottom
        anchors.topMargin: 5
        onClicked:
        {
            pos.sens = checked
        }
    }

    Button {
        id: button
        x: -267
        width: 15
        height: 15
        text: qsTr("v")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        property int nbClic :1
        onClicked:
        {
            if(nbClic ===0)
            {
                nbClic = 1;
                root.state = "ferme"
                button.text = "v"
                var tailleToSend = 60
                tailleChange(tailleToSend)
            }else
            {
                root.state = "ouvert"
                button.text = "^"

                if(cbAcc.indice === 3)
                {
                    tfAcc.visible = true
                }

                if(cbDec.indice === 3)
                {
                    tfDec.visible = true
                }

                if(cbVitesse.indice === 3)
                {
                    tfVit.visible = true
                }
                var tailleToSend = 510
                if(tfVitesseEnable===true)tailleToSend+=tfVitesse.height+5
                if(tfAccEnable===true)tailleToSend+=tfAcc.height+5
                if(tfDecEnable===true)tailleToSend+=tfDec.height+5;
                tailleChange(tailleToSend)
                nbClic = 0;
            }
        }
    }

    Text {
        id: textPreci
        x: 4
        y: 8
        text: qsTr("Précision :")
        anchors.left: parent.left
        anchors.top: switchSens.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
        anchors.leftMargin: 5
    }

    Rectangle {
        id: tfPreci
        x: 1
        y: 5
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: textPreci.bottom
        visible: true
        TextEdit {
            id: tfPrecision
            height: 30
            color: "#ffffff"
            text: qsTr("50")
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            onTextChanged: pos.precision = text
        }
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
    }

    Text {
        id: textTimeout
        x: -3
        y: 1
        text: qsTr("TimeOut :")
        anchors.left: parent.left
        anchors.top: cbDetect.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pixelSize: 12
        anchors.leftMargin: 5
    }

    Rectangle {
        id: tfTimeout
        x: -6
        y: -2
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: textTimeout.bottom
        visible: true
        TextEdit {
            id: tfTimeOut
            height: 30
            color: "#ffffff"
            text: qsTr("5000")
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
            onTextChanged: pos.timeOut = text
        }
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
    }

    Text {
        id: textDetect
        x: 4
        y: 8
        text: qsTr("Detect :")
        anchors.topMargin: 5
        font.pixelSize: 12
        font.bold: true
        anchors.top: tfStabilisation.bottom
        anchors.leftMargin: 5
        anchors.left: parent.left
    }

    CustomComboBox {
        id: cbDetect
        x: 9
        y: -2
        height: 30
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.top: textDetect.bottom
        _model: [ "Aucune", "Contact ", "Proche ", "Loin "  ]
        anchors.leftMargin: 5
        anchors.left: parent.left
        anchors.rightMargin: 5
        onCustomCurrentIndexChanged:
        {

            switch(indice)
            {
            case 0:
                pos.detection = 0;
                break;
            case 1:
                pos.detection = 1;
                break;
            case 2:
                pos.detection = 2;
                break;
            case 3:
                pos.detection = 3;
                break;
            }
        }
    }

    Text {
        id: textStabilisation
        x: 4
        y: 8
        text: qsTr("distanceFreinage :")
        anchors.topMargin: 5
        font.pixelSize: 12
        font.bold: true
        anchors.top: tfPreci.bottom
        anchors.leftMargin: 5
        anchors.left: parent.left
    }

    Rectangle {
        id: tfStabilisation
        x: 1
        y: 5
        height: 30
        color: "#4a4545"
        radius: 7
        anchors.topMargin: 5
        TextEdit {
            id: tfStab
            height: 30
            color: "#ffffff"
            text: qsTr("-1")
            anchors.fill: parent
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            onTextChanged: pos.stabilisation = text
        }
        anchors.right: parent.right
        anchors.top: textStabilisation.bottom
        anchors.leftMargin: 5
        anchors.left: parent.left
        visible: true
        anchors.rightMargin: 5
    }

    states: [
        State {
            name: "ouvert"

            PropertyChanges {
                target: textVitesse
                visible: true
            }

            PropertyChanges {
                target: cbVitesse
                visible: true
            }

            PropertyChanges {
                target: textAcc
                visible: true
            }

            PropertyChanges {
                target: cbAcc
                visible: true
            }

            PropertyChanges {
                target: textDec
                visible: true
            }

            PropertyChanges {
                target: cbDec
                visible: true
            }

            PropertyChanges {
                target: switchSens
                visible: true
            }
        },
        State {
            name: "ferme"

            PropertyChanges {
                target: textVitesse
                visible: false
            }

            PropertyChanges {
                target: cbVitesse
                visible: false
            }

            PropertyChanges {
                target: tfVitesse
                visible: false
            }

            PropertyChanges {
                target: textAcc
                visible: false
            }

            PropertyChanges {
                target: cbAcc
                visible: false
            }

            PropertyChanges {
                target: tfAcc
                visible: false
            }

            PropertyChanges {
                target: textDec
                visible: false
            }

            PropertyChanges {
                target: cbDec
                visible: false
            }

            PropertyChanges {
                target: tfDec
                visible: false
            }

            PropertyChanges {
                target: switchSens
                visible: false
            }

            PropertyChanges {
                target: textPreci
                visible: false
            }

            PropertyChanges {
                target: tfPreci
                visible: false
            }

            PropertyChanges {
                target: textTimeout
                visible: false
            }

            PropertyChanges {
                target: tfTimeout
                visible: false
            }

            PropertyChanges {
                target: textStabilisation
                visible: false
            }

            PropertyChanges {
                target: tfStabilisation
                visible: false
            }

            PropertyChanges {
                target: textDetect
                visible: false
            }

            PropertyChanges {
                target: cbDetect
                visible: false
            }
        }
    ]
}
