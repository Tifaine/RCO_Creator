#ifndef GESTIONDYNA_H
#define GESTIONDYNA_H

#include <QObject>
#include "dynamixel.h"
#include <QFileSystemWatcher>

class GestionDynamixel : public QObject
{
    Q_OBJECT
public:
    explicit GestionDynamixel(QObject *parent = nullptr);

signals:

public slots:
    void listFichierDyna();
    void mustDelete();
    int getNbDyna();
    QString getNomDyna(int indice);
    int getNbAction(int indiceDyna);
    QString getNomAction(int indiceDyna, int indiceAction);
    int getValAction(int indiceDyna, int indiceAction);
    int getNbVitesse(int indiceDyna);
    QString getNomVitesse(int indiceDyna, int indiceVitesse);
    int getValVitesse(int indiceDyna, int indiceVitesse);
private:
    QList<Dynamixel*> listDyna;
    QFile* fichierDyna;
    QFileSystemWatcher* watcher;
};

#endif // GESTIONDYNA_H
