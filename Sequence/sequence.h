#ifndef SEQUENCE_H
#define SEQUENCE_H

#include <QQuickItem>
#include <QDateTime>
#include <QList>
#include "../Action/action.h"

#include "../libXML/tinystr.h"
#include "../libXML/tinyxml.h"

class Sequence : public QQuickItem
{
    Q_OBJECT
public:
    Sequence(QQuickItem *parent = nullptr);

signals:
    void genererAction(int xBloc, int yBloc, int typeBloc, QString listPere, QString listFils,QString param0 ,QString param1, QString param2, QString param3, QString param4, QString param5);
    void finParsage();

public slots:
    void ajouterAction(Action* essai);
    void supprimerAction(Action * toBeDeleted);
    void enregistrerSous(QString filename);
    void clearAll();

    void test();

    int ouvrirFichier(QString fileName);

    int getIndice(Action* act);

    int getNbAction();
private:
    QList<Action*> listAction;
};

#endif // SEQUENCE_H
