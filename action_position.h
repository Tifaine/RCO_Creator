#ifndef ACTION_POSITION_H
#define ACTION_POSITION_H

#include <QObject>
#include "action.h"
#include <QDebug>

class Action_Position : public Action
{
    Q_OBJECT
    Q_PROPERTY(int xRobot READ getXRobot WRITE setXRobot NOTIFY xRobotChanged)
    Q_PROPERTY(int yRobot READ getYRobot WRITE setYRobot NOTIFY YRobotChanged)
public:
    Action_Position();

    int getXRobot() const;
    void setXRobot(int value);

    int getYRobot() const;
    void setYRobot(int value);
    void toString();
    struct position getPosition();
signals:
    void xRobotChanged();
    void YRobotChanged();

public slots:

private:
    int xRobot = 0;
    int yRobot = 0;

    struct position posRobot;
};

#endif // ACTION_POSITION_H
