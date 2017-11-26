#include "actionsequence.h"

ActionSequence::ActionSequence()
{
    setType(typeSequence);
}

void ActionSequence::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionSequence");
    xmlWriter->writeTextElement("nomSequence",getNomSequence());
    xmlWriter->writeEndElement();
}

QString ActionSequence::getNomSequence() const
{
    return _nomSequence;
}

void ActionSequence::setNomSequence(const QString &value)
{
    _nomSequence = value;
}
