#include "actionservo.h"

ActionServo::ActionServo()
{
    setType(typeServo);
}

void ActionServo::saveXML(QXmlStreamWriter* xmlWriter)
{
qDebug()<<"Action servo";
}
