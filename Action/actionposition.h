#ifndef ACTIONPOSITION_H
#define ACTIONPOSITION_H

#include <QObject>
#include <QDebug>
#include "action.h"

class ActionPosition : public Action
{
    Q_OBJECT
    Q_PROPERTY(int xRobot READ getXRobot WRITE setXRobot NOTIFY xRobotChanged)
    Q_PROPERTY(int yRobot READ getYRobot WRITE setYRobot NOTIFY YRobotChanged)
    Q_PROPERTY(int vitesse READ getVitesse WRITE setVitesse NOTIFY vitesseChanged)
    Q_PROPERTY(int acceleration READ getAcceleration WRITE setAcceleration NOTIFY accelerationChanged)
    Q_PROPERTY(int deceleration READ getDeceleration WRITE setDeceleration NOTIFY decelerationChanged)
    Q_PROPERTY(bool sens READ getSens WRITE setSens NOTIFY sensChanged)
public:
    ActionPosition();

    int getXRobot() const;
    void setXRobot(int value);

    int getYRobot() const;
    void setYRobot(int value);

    void saveXML(QXmlStreamWriter *xmlWriter);


    int getVitesse() const;
    void setVitesse(int value);

    int getAcceleration() const;
    void setAcceleration(int value);

    int getDeceleration() const;
    void setDeceleration(int value);

    bool getSens() const;
    void setSens(bool value);

signals:
    void xRobotChanged();
    void YRobotChanged();
    void vitesseChanged();
    void accelerationChanged();
    void decelerationChanged();
    void sensChanged();

public slots:
    void getInfo();

private:
    int xRobot = 0;
    int yRobot = 0;
    int vitesse = 0;
    int acceleration = 0;
    int deceleration = 0;
    bool sens;
};

#endif // ACTIONPOSITION_H
