#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "connector.h"
#include "bloc_action.h"
#include "gestionservo.h"
#include "gestiondyna.h"
#include "gestionsequence.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    gestionServo serv;
    gestionDyna dyna;
    gestionSequence gestSeq;

    qmlRegisterType<connector>("connector", 1, 0, "Liaison");
    qmlRegisterType<bloc_Action>("bloc", 1, 0, "Bloc");
   // qmlRegisterType<gestionServo>("gestServo", 1, 0, "GestionServo");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("gestServo", &serv);
    engine.rootContext()->setContextProperty("gestDyna", &dyna);
    engine.rootContext()->setContextProperty("gestSequence", &gestSeq);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
