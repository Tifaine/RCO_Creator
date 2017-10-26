#include "actionposition.h"

ActionPosition::ActionPosition()
{
    setType(typePosition);
}


void ActionPosition::getInfo()
{
    qDebug()<<xRobot<<" "<<yRobot;
}

int ActionPosition::getXRobot() const
{
    return xRobot;
}

void ActionPosition::setXRobot(int value)
{
    xRobot = value;
}

int ActionPosition::getYRobot() const
{
    return yRobot;
}

void ActionPosition::setYRobot(int value)
{
    yRobot = value;
}

void ActionPosition::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionPosition");
    xmlWriter->writeTextElement("coordX",QString::number(xRobot,'f',0));
    xmlWriter->writeTextElement("coordY",QString::number(yRobot,'f',0));
    xmlWriter->writeEndElement();
}
