#include "gestiontable.h"

GestionTable::GestionTable(QObject *parent) : QObject(parent)
{

}


void GestionTable::ajouterAction(Action* essai)
{
    listAction.append(essai);
    connect(essai,SIGNAL(paramChanged(Action*,QString,Action*)),this,SLOT(actionChanged(Action*,QString,Action*)));
    connect(essai,SIGNAL(paramChanged(Action*,QString,int)),this,SLOT(actionChanged(Action*,QString,int)));
}

void GestionTable::supprimerAction(Action * toBeDeleted)
{
    listAction.removeAt(listAction.indexOf(toBeDeleted));
}

int GestionTable::getTailleList()
{
    return listAction.size();
}

Action* GestionTable::getAction(int indice)
{
    return listAction.at(indice);
}

void GestionTable::clearAll()
{
    listAction.clear();
}

void GestionTable::actionChanged(Action* actChanged, QString param, int newValue)
{
    if(param.compare("x")==0)
    {
        if(actChanged->getType() == typePosition)
        {
            emit changeX(listAction.indexOf(actChanged), newValue);
        }
    }else if(param.compare("y")==0)
    {
        if(actChanged->getType() == typePosition)
        {
            emit changeY(listAction.indexOf(actChanged), newValue);
        }
    }
}

int GestionTable::getTypeAction(int indice)
{
    return listAction.at(indice)->getType();
}

void GestionTable::actionChanged(Action* actChanged, QString param, Action* newValue)
{
    if(param.compare("ajoutFils")==0)
    {
        if(actChanged->getType() == typePosition)
        {
            gestionTable();
           // emit ajouterFils(listAction.indexOf(actChanged), newValue);
            //emit finTraitementTable();
        }
    }else if(param.compare("deleteFils")==0)
    {

    }
}

void GestionTable::gestionTable()
{

    QList<Action*> listToParse;
    QList<Action*> listFilsToParse;
    listToParse.append(listAction.at(0));

    while(listToParse.size()>0)
    {
        for(int i = 0; i < listAction.at(listAction.indexOf(listToParse.at(0)))->getListFils().size();i++)
        {
            for(int j=0;j<listAction.at(listAction.indexOf(listToParse.at(0)))->getListFils().at(i)->size();j++)
            {
                listFilsToParse.append((listAction.at(listAction.indexOf(listToParse.at(0)))->getListFils().at(i)->at(j)));
            }
        }

        while(listFilsToParse.size()>0)
        {
            if(listFilsToParse.at(0)->getType()==typePosition)
            {
                listToParse.append(listAction.at(listAction.indexOf(listFilsToParse.at(0))));
                listLienAction.append(new lienAction);
                listLienAction.last()->indiceFils = listAction.indexOf(listFilsToParse.at(0));
                listLienAction.last()->indicePere = listAction.indexOf(listToParse.at(0));

            }else
            {
                for(int i = 0; i < listAction.at(listAction.indexOf(listFilsToParse.at(0)))->getListFils().size();i++)
                {
                    for(int j=0;j<listAction.at(listAction.indexOf(listFilsToParse.at(0)))->getListFils().at(i)->size();j++)
                    {
                        listFilsToParse.append((listAction.at(listAction.indexOf(listFilsToParse.at(0)))->getListFils().at(i)->at(j)));
                    }
                }
            }
            listFilsToParse.removeFirst();
        }
        listToParse.removeFirst();
    }
    emit finTraitementTable();
}

int GestionTable::getNbLien()
{
    return listLienAction.size();
}

int GestionTable::getIndicePere(int indice)
{
    return listLienAction.at(indice)->indicePere;
}

int GestionTable::getIndiceFils(int indice)
{
    return listLienAction.at(indice)->indiceFils;
}
