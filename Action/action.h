#ifndef ACTION_H
#define ACTION_H

#include <QQuickItem>
#include <QObject>
#include <QXmlStreamWriter>
#include "../libXML/tinystr.h"
#include "../libXML/tinyxml.h"
//#include "actionposition.h"

#define typeServo               0
#define typeDyna                1
#define typeCapteur             2
#define typeMoteur              3
#define typeAutre               4
#define typePosition            5
#define typeOrientation         6
#define typeSequence            7
#define typeEntree              9
#define typeGPIO                16

#define typeAttenteServo        10
#define typeAttenteDyna         11
#define typeAttenteTemps        12
#define typeRetourDeplacement   13
#define typeRetourOrientation   14
#define typeRetourPosition      15
#define typeRetourGPIO          17

//define typeServo 9

class Action : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int xBloc READ getXBloc WRITE setXBloc NOTIFY xBlocChanged)
    Q_PROPERTY(int yBloc READ getYBloc WRITE setYBloc NOTIFY yBlocChanged)
    Q_PROPERTY(int timeOut READ getTimeOut WRITE setTimeOut NOTIFY timeOutChanged)
public:
    Action(QQuickItem *parent = nullptr);
    void setType(int value);

    virtual void saveXML(QXmlStreamWriter* xmlWriter) = 0;
    virtual void saveXML(TiXmlElement * root, int indice) = 0;
    QList<QList<Action *> *> getListFils() const;

    int getXBloc() const;
    void setXBloc(int value);

    int getYBloc() const;
    void setYBloc(int value);

    int getTimeOut() const;
    void setTimeOut(int value);

    QList<QList<Action *> *> getListPere() const;

signals:
    void xBlocChanged();
    void yBlocChanged();
    void timeOutChanged();

    void paramChanged(Action* act, QString nomParam, int newValue);
    void paramChanged(Action* act, QString nomParam, Action* newValue);

public slots:
    int getType() const;

    virtual void getInfo();
    void ajouterListFils();
    void ajouterFils(int indiceListe, Action *act);
    void supprimerFils(Action * actToDelete);

    void ajouterListPere();
    void ajouterPere(int indiceListe, Action *act);
    void supprimerPere(Action * actToDelete);


    int getNbPere();
    int getnbListFils();
    int getNbFils(int indiceListe);
    Action* getFils(int indiceListe, int indiceFils);
    Action* getPere(int indicePere);

protected:

private:
    QList<QList<Action* >*> listFils;
    QList<QList<Action* >*> listPere;
    int type = -1;
    int xBloc;
    int yBloc;
    int timeOut = -1;

};

#endif // ACTION_H
