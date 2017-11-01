#ifndef GESTIONSERVO_H
#define GESTIONSERVO_H

#include <QObject>
#include <QtXml>
#include "servo.h"
#include <QFileSystemWatcher>

class GestionServo : public QObject
{
    Q_OBJECT
public:
    GestionServo(QObject *parent = nullptr);

signals:

public slots:
    void listFichierServo();
    void mustDelete();
    int getNbServo();
    QString getNomServo(int indice);
    int getIdServo(int indiceServo);
    int getNbAction(int indiceServo);
    QString getNomAction(int indiceServo, int indiceAction);
    int getValAction(int indiceServo, int indiceAction);


private:
    QList<Servo*> listServo;
    QFile* fichierServo;
    QFileSystemWatcher* watcher;
};

#endif // GESTIONSERVO_H
