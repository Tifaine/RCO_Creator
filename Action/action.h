#ifndef ACTION_H
#define ACTION_H

#include <QQuickItem>
#include <QObject>
#include <QXmlStreamWriter>
//#include "actionposition.h"

#define typeServo           0
#define typeDyna            1
#define typeCapteur         2
#define typeMoteur          3
#define typeAutre           4
#define typePosition        5
#define typeOrientation     6
#define typeSequence        7
#define typeEntree          9

#define typeAttenteServo    10
#define typeAttenteDyna     11

//define typeServo 9

class Action : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int xBloc READ getXBloc WRITE setXBloc NOTIFY xBlocChanged)
    Q_PROPERTY(int yBloc READ getYBloc WRITE setYBloc NOTIFY yBlocChanged)
    Q_PROPERTY(int timeOut READ getTimeOut WRITE setTimeOut NOTIFY timeOutChanged)
public:
    Action(QQuickItem *parent = nullptr);
    int getType() const;
    void setType(int value);

    virtual void saveXML(QXmlStreamWriter* xmlWriter) = 0;
    void creerAction(int type);

    QList<QList<Action *> *> getListFils() const;

    int getXBloc() const;
    void setXBloc(int value);

    int getYBloc() const;
    void setYBloc(int value);

    int getTimeOut() const;
    void setTimeOut(int value);

signals:
    void xBlocChanged();
    void yBlocChanged();
    void timeOutChanged();

public slots:
    virtual void getInfo();
    void ajouterListFils();
    void ajouterFils(int indiceListe, Action *act);
    void supprimerFils(Action * actToDelete);

protected:

private:
    QList<QList<Action* >*> listFils;
    int type = -1;
    int xBloc;
    int yBloc;
    int timeOut = -1;

};

#endif // ACTION_H
