#include "actionsetvariable.h"

actionSetVariable::actionSetVariable()
{
    setType(typeSetVariable);
}

void actionSetVariable::saveXML(QXmlStreamWriter* xmlWriter)
{

}

void actionSetVariable::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionVar");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("numero", QString::number(getNomVar(),'f',0).toStdString().c_str());
        param->SetAttribute("cible", QString::number(getNomRobot(),'f',0).toStdString().c_str());
        QString commande;
        switch(getNomOperation())
        {
        case 0: //SET
            commande.append("SET ");
            break;
        case 1: //Add
             commande.append("INC ");
            break;
        case 2://SUB
             commande.append("DEC ");
            break;
        case 3://MUL
             commande.append("MUL ");
            break;
        case 4://DIV
             commande.append("DIV ");
            break;
        }
        commande.append(QString::number(getVariable(),'f',2));
        qDebug()<<commande;
        param->SetAttribute("commande", commande.toStdString().c_str());
        break;
    }
}

int actionSetVariable::getNomVar() const
{
    return nomVar;
}

void actionSetVariable::setNomVar(const int &value)
{
    nomVar = value;
}

int actionSetVariable::getNomRobot() const
{
    return nomRobot;
}

void actionSetVariable::setNomRobot(const int &value)
{
    nomRobot = value;
}

int actionSetVariable::getNomOperation() const
{
    return nomOperation;
}

void actionSetVariable::setNomOperation(const int &value)
{
    nomOperation = value;
}

double actionSetVariable::getVariable() const
{
    return variable;
}

void actionSetVariable::setVariable(double value)
{
    variable = value;
}
