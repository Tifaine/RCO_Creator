#include "actioncourbe.h"

ActionCourbe::ActionCourbe()
{

}

int ActionCourbe::getVitesse() const
{
    return vitesse;
}

void ActionCourbe::setVitesse(int value)
{
    vitesse = value;
}

int ActionCourbe::getRayon() const
{
    return rayon;
}

void ActionCourbe::setRayon(int value)
{
    rayon = value;
}

int ActionCourbe::getAngle() const
{
    return angle;
}

void ActionCourbe::setAngle(int value)
{
    angle = value;
}

int ActionCourbe::getPrecision() const
{
    return precision;
}

void ActionCourbe::setPrecision(int value)
{
    precision = value;
}

bool ActionCourbe::getSens() const
{
    return sens;
}

void ActionCourbe::setSens(bool value)
{
    sens = value;
}

void ActionCourbe::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionCourbe");
    xmlWriter->writeTextElement("vitesse",QString::number(vitesse,'f',0));
    xmlWriter->writeTextElement("rayon",QString::number(rayon,'f',0));
    xmlWriter->writeTextElement("angle",QString::number(angle,'f',0));
    xmlWriter->writeTextElement("precision",QString::number(sens,'f',0));
    xmlWriter->writeTextElement("sens",QString::number(sens,'f',0));

    xmlWriter->writeEndElement();
}

void ActionCourbe::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionCourbe");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("vitesse", QString::number(vitesse,'f',0).toStdString().c_str());
        param->SetAttribute("rayon", QString::number(rayon,'f',0).toStdString().c_str());
        param->SetAttribute("angle", QString::number(angle,'f',0).toStdString().c_str());
        param->SetAttribute("precision", QString::number(precision,'f',0).toStdString().c_str());
        param->SetAttribute("sens", QString::number(sens,'f',0).toStdString().c_str());
        break;
    }
}
