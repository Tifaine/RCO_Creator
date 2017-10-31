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
public:
    ActionPosition();

    int getXRobot() const;
    void setXRobot(int value);

    int getYRobot() const;
    void setYRobot(int value);

    void saveXML(QXmlStreamWriter *xmlWriter);


signals:
    void xRobotChanged();
    void YRobotChanged();

public slots:
    void getInfo();
private:
    int xRobot = 0;
    int yRobot = 0;
};

#endif // ACTIONPOSITION_H
