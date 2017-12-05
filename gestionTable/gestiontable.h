#ifndef GESTIONTABLE_H
#define GESTIONTABLE_H

#include <QObject>
#include <QDebug>
#include "../Action/action.h"
#include <QList>
#include <QThread>

#include "../Action/action.h"

typedef struct lienAction
{
    int indicePere;
    int indiceFils;
}lienAction;

class GestionTable : public QObject
{
    Q_OBJECT
public:
    explicit GestionTable(QObject *parent = nullptr);


signals:
    void changeX(int indice, int newValue);
    void changeY(int indice, int newValue);
    //void ajouterFils(int indicePere, int indiceFils);
    void finTraitementTable();
private slots:
    void actionChanged(Action* actChanged, QString param, int newValue);
    void actionChanged(Action* actChanged, QString param, Action* newValue);
public slots:
    void ajouterAction(Action* essai);
    void supprimerAction(Action * toBeDeleted);
    int getTailleList();
    int getTypeAction(int indice);
    Action* getAction(int indice);
    void clearAll();
    void gestionTable();
    int getNbLien();
    int getIndicePere(int indice);
    int getIndiceFils(int indice);

private:
    QList<Action*> listAction;
    QList<lienAction*> listLienAction;

};

#endif // GESTIONTABLE_H
