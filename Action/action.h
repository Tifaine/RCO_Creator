#ifndef ACTION_H
#define ACTION_H

#include <QQuickItem>
#include <QObject>
#include <QXmlStreamWriter>
//#include "actionposition.h"

#define typeServo       0
#define typeDyna        1
#define typeCapteur     2
#define typeMoteur      3
#define typeAutre       4
#define typePosition    5
#define typeOrientation 6
#define typeSequence    7
//define typeServo 9

class Action : public QQuickItem
{
    Q_OBJECT
public:
    Action(QQuickItem *parent = nullptr);
    int getType() const;
    void setType(int value);

    virtual void saveXML(QXmlStreamWriter* xmlWriter) = 0;
    void creerAction(int type);

signals:

public slots:
    virtual void getInfo();
    void ajouterListFils();
    void ajouterFils(int indiceListe, Action *act);
    void supprimerFils(Action * actToDelete);

protected:

private:
    QList<QList<Action* >*> listFils;
    int type = -1;

};

#endif // ACTION_H
