#include "actionposition.h"

ActionPosition::ActionPosition()
{
    setType(typePosition);
}


void ActionPosition::getInfo()
{
    qDebug()<<xRobot<<" "<<yRobot;
}

bool ActionPosition::getSens() const
{
    return sens;
}

void ActionPosition::setSens(bool value)
{
    sens = value;
}

int ActionPosition::getDeceleration() const
{
    return deceleration;
}

void ActionPosition::setDeceleration(int value)
{
    deceleration = value;
}

int ActionPosition::getAcceleration() const
{
    return acceleration;
}

void ActionPosition::setAcceleration(int value)
{
    acceleration = value;
}

int ActionPosition::getVitesse() const
{
    return vitesse;
}

void ActionPosition::setVitesse(int value)
{
    vitesse = value;
}

int ActionPosition::getXRobot() const
{
    return xRobot;
}

void ActionPosition::setXRobot(int value)
{
    xRobot = value;
    emit xRobotChanged();
    emit paramChanged(this, "x",xRobot);
}

int ActionPosition::getYRobot() const
{
    return yRobot;
}

void ActionPosition::setYRobot(int value)
{
    yRobot = value;
    emit YRobotChanged();
    emit paramChanged(this, "y",yRobot);
}

void ActionPosition::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionPosition");
    xmlWriter->writeTextElement("coordX",QString::number(xRobot,'f',0));
    xmlWriter->writeTextElement("coordY",QString::number(yRobot,'f',0));
    xmlWriter->writeTextElement("vitesse",QString::number(vitesse,'f',0));
    xmlWriter->writeTextElement("acc",QString::number(acceleration,'f',0));
    xmlWriter->writeTextElement("dec",QString::number(deceleration,'f',0));
    xmlWriter->writeTextElement("sens",QString::number(sens,'f',0));
    xmlWriter->writeEndElement();
}
