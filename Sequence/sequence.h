#ifndef SEQUENCE_H
#define SEQUENCE_H

#include <QQuickItem>
#include <QDateTime>
#include <QList>
#include "../Action/action.h"
#include "Action/actionautre.h"
#include "Action/actioncapteur.h"
#include "Action/actiondynamixel.h"
#include "Action/actionmoteur.h"
#include "Action/actiongpio.h"
#include "Action/actiondeplacement.h"
#include "Action/actionorientation.h"
#include "Action/actionposition.h"
#include "Action/actionsequence.h"
#include "Action/actionservo.h"
#include "Action/actionsetvaleur.h"
#include "Action/actiondepart.h"
#include "Action/actionfin.h"
#include "Action/actioncourbe.h"
#include "Action/attente/attenteservo.h"
#include "Action/attente/attentedyna.h"
#include "Action/attente/attentetemps.h"
#include "Action/attente/retourposition.h"
#include "Action/attente/retourorientation.h"
#include "Action/attente/attenteblocage.h"
#include "Action/attente/blocand.h"
#include "Action/attente/retourgpio.h"

#include "../libXML/tinystr.h"
#include "../libXML/tinyxml.h"

class Sequence : public QQuickItem
{
    Q_OBJECT
public:
    Sequence(QQuickItem *parent = nullptr);

signals:
    void genererAction(int xBloc, int yBloc, int typeBloc, QString listPere, QString listFils,QString param0 ,QString param1, QString param2, QString param3, QString param4, QString param5, QString param6, QString param7, QString param8);
    void finParsage();

public slots:
    void ajouterAction(Action* essai);
    void supprimerAction(Action * toBeDeleted);
    void enregistrerSous(QString filename);
    void clearAll();
    void enregistrerSequence(TiXmlElement * root, QList<Action*>* listActionSequence, int indice, int indiceDebut, QList<Action *> *listRef, int delta);
    void exportXML();

    void test();

    int ouvrirFichier(QString fileName);

    int ouvrirSequence(QString sequenceName, QList<Action*>* listAction);

    int getIndice(Action* act);

    int getNbAction();
private:
    QList<Action*> listAction;
};

#endif // SEQUENCE_H
