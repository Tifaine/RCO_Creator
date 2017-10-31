#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Composant/connector.h"
#include "Sequence/sequence.h"
#include "Action/actionautre.h"
#include "Action/actioncapteur.h"
#include "Action/actiondynamixel.h"
#include "Action/actionmoteur.h"
#include "Action/actionorientation.h"
#include "Action/actionposition.h"
#include "Action/actionsequence.h"
#include "Action/actionservo.h"
#include "Action/gestion/gestionservo.h"
#include "Action/gestion/gestiondynamixel.h"
#include "Action/gestion/gestionsortie.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    GestionServo serv;
    GestionDynamixel dyna;

    qmlRegisterType<connector>("connector", 1, 0, "Liaison");
    qmlRegisterType<Sequence>("sequence", 1, 0, "Sequence");
    qmlRegisterType<ActionAutre>("actionAutre", 1, 0, "Autre");
    qmlRegisterType<ActionCapteur>("actionCapteur", 1, 0, "Capteur");
    qmlRegisterType<ActionDynamixel>("actionDyna", 1, 0, "Dyna");
    qmlRegisterType<ActionMoteur>("actionMoteur", 1, 0, "Moteur");
    qmlRegisterType<ActionOrientation>("actionOrientation", 1, 0, "Orientation");
    qmlRegisterType<ActionPosition>("actionPos", 1, 0, "Pos");
    qmlRegisterType<ActionSequence>("actionSequence", 1, 0, "Sequence");
    qmlRegisterType<ActionServo>("actionServo", 1, 0, "Servo");
    qmlRegisterType<GestionSortie>("gestSortie", 1, 0, "GestSortie");


    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("gestServo", &serv);
    engine.rootContext()->setContextProperty("gestDyna", &dyna);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
