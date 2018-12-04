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

void ActionSequence::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionSequence");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("nomSequence", getNomSequence().toStdString().c_str());
        break;
    }
}

QString ActionSequence::getNomSequence() const
{
    return _nomSequence;
}

void ActionSequence::setNomSequence(const QString &value)
{
    _nomSequence = value;
}
