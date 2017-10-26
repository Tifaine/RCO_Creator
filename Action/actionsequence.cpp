#include "actionsequence.h"

ActionSequence::ActionSequence()
{
    setType(typeSequence);
}

void ActionSequence::saveXML(QXmlStreamWriter* xmlWriter)
{
qDebug()<<"Action sequence";
}
