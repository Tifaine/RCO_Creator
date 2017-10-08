#include "action_position.h"

Action_Position::Action_Position()
{
    setTypeAction(ACTION_POSITION);
    (posRobot.x) = &xRobot;
    (posRobot.y) = &yRobot;
}

int Action_Position::getXRobot() const
{
    return xRobot;
}

void Action_Position::setXRobot(int value)
{
    xRobot = value;
}

int Action_Position::getYRobot() const
{
    return yRobot;
}

void Action_Position::setYRobot(int value)
{
    yRobot = value;
}

void Action_Position::toString()
{
    qDebug()<<"Je suis une position. x : "<<xRobot<<" y :"<<yRobot;
}

struct position Action_Position::getPosition()
{
    return posRobot;
}
