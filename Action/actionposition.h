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
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)
    Q_PROPERTY(bool sens READ getSens WRITE setSens NOTIFY sensChanged)
public:
    ActionPosition();

    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);


    void setVitesse(int value);


    void setAcceleration(int value);


    void setDeceleration(int value);

    bool getSens() const;
    void setSens(bool value);

    void setPrecision(int value);

signals:
    void xRobotChanged();
    void YRobotChanged();
    void vitesseChanged();
    void accelerationChanged();
    void decelerationChanged();
    void sensChanged();
    void precisionChanged();

public slots:

    int getXRobot() const;
    int getYRobot() const;
    int getVitesse() const;
    int getAcceleration() const;
    int getDeceleration() const;
    int getPrecision() const;
    void setXRobot(int value);
    void setYRobot(int value);
    void getInfo();

private:
    int xRobot = 0;
    int yRobot = 0;
    int vitesse = 0;
    int acceleration = 0;
    int deceleration = 0;
    int precision = 50;
    bool sens;
};

#endif // ACTIONPOSITION_H
