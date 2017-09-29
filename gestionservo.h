#ifndef GESTIONSERVO_H
#define GESTIONSERVO_H

#include <QObject>

#include "servo.h"
#include <QFileSystemWatcher>

class gestionServo : public QObject
{
    Q_OBJECT
public:
    explicit gestionServo(QObject *parent = nullptr);

signals:

public slots:
    void listFichierServo();
    void mustDelete();
    int getNbServo();
    QString getNomServo(int indice);
    int getNbAction(int indiceServo);
    QString getNomAction(int indiceServo, int indiceAction);
    int getIdAction(int indiceServo, int indiceAction);
private:
    QList<servo*> listServo;
    QFile* fichierServo;
    QFileSystemWatcher* watcher;
};

#endif // GESTIONSERVO_H
