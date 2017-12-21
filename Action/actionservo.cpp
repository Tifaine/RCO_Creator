#include "actionservo.h"

ActionServo::ActionServo()
{
    setType(typeServo);
}

void ActionServo::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionServo");
    xmlWriter->writeTextElement("nomServo",getNomServo());
    xmlWriter->writeTextElement("idServo",QString::number(getIdServo(),'f',0));
    xmlWriter->writeTextElement("angle",QString::number(getValueServo(),'f',0));
    xmlWriter->writeEndElement();
}
void ActionServo::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionServo");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("nom", getNomServo().toStdString().c_str());
        param->SetAttribute("id", QString::number(getIdServo(),'f',0).toStdString().c_str());
        param->SetAttribute("angle", QString::number(getValueServo(),'f',0).toStdString().c_str());
        break;
    }
}

int ActionServo::getIdServo() const
{
    return idServo;
}

void ActionServo::setIdServo(int value)
{
    idServo = value;
}

int ActionServo::getValueServo() const
{
    return valueServo;
}

void ActionServo::setValueServo(int value)
{
    valueServo = value;
}

QString ActionServo::getNomServo() const
{
    return nomServo;
}

void ActionServo::setNomServo(const QString &value)
{
    nomServo = value;
}
