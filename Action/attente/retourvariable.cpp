#include "retourvariable.h"

RetourVariable::RetourVariable()
{

}

void RetourVariable::saveXML(QXmlStreamWriter* xmlWriter)
{

}

void RetourVariable::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionRetourVar");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("numero", QString::number(getNomVar(),'f',0).toStdString().c_str());
        param->SetAttribute("cible", QString::number(getNomRobot(),'f',0).toStdString().c_str());

        param->SetAttribute("condition", QString::number(getNomCondition(),'f',0).toStdString().c_str());
        param->SetAttribute("value", QString::number(getVariable(),'f',0).toStdString().c_str());
        break;
    }
}

double RetourVariable::getVariable() const
{
    return variable;
}

void RetourVariable::setVariable(double value)
{
    variable = value;
}

int RetourVariable::getNomCondition() const
{
    return nomCondition;
}

void RetourVariable::setNomCondition(int value)
{
    nomCondition = value;
}

int RetourVariable::getNomRobot() const
{
    return nomRobot;
}

void RetourVariable::setNomRobot(int value)
{
    nomRobot = value;
}

int RetourVariable::getNomVar() const
{
    return nomVar;
}

void RetourVariable::setNomVar(int value)
{
    nomVar = value;
}
