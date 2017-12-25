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
    listAction.removeAll(toBeDeleted);
    gestionTable();
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
    listLienAction.clear();
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
        if(actChanged->getType() == typePosition)
        {
            gestionTable();

            // emit ajouterFils(listAction.indexOf(actChanged), newValue);
            //emit finTraitementTable();
        }
    }
}

void GestionTable::gestionTable()
{
    //    bool nonPositionTrouve = true;
    //    QList<Action*> listToParse;
    //    listToParse = listAction;
    //    while(nonPositionTrouve)
    //    {
    //        for(int i = 0;i < listToParse.size();i++)
    //        {
    //            nonPositionTrouve = false;
    //            if(listToParse.at(i)->getType()!=typePosition && listToParse.at(i)->getType()!=typeEntree)
    //            {
    //                for(int j=0;j<listToParse.at(i)->getListFils().at(0)->size();j++)
    //                {
    //                    listToParse.at(i)->getListPere().at(0)->at(0)->getListFils().at(0)->append(listToParse.at(i)->getListFils().at(0)->at(j));
    //                    listToParse.at(i)->getListFils().at(0)->at(j)->getListPere().at(0)->removeAll(listToParse.at(i));
    //                    listToParse.at(i)->getListFils().at(0)->at(j)->ajouterPere(0, listToParse.at(i)->getListPere().at(0)->at(0));
    //                }

    //                listToParse.removeAt(i);
    //                nonPositionTrouve = true;
    //                break;
    //            }
    //        }
    //    }

    //    for(int i=0; i<listToParse.size();i++)
    //    {
    //        for(int j=0;j<listToParse.at(i)->getListFils().size();j++)
    //        {
    //            for(int k=0;k<listToParse.at(i)->getListFils().at(j)->size();k++)
    //            {
    //                if(listToParse.at(i)->getListFils().at(j)->at(k)->getType()!=typePosition)
    //                {
    //                    listToParse.at(i)->getListFils().at(j)->removeAt(k);
    //                    k--;
    //                }
    //            }
    //        }
    //    }

    //    for(int i = 0; i < listToParse.size();i++)
    //    {
    //        for(int j=0;j<listToParse.at(i)->getListFils().size();j++)
    //        {
    //            for(int k=0;k<listToParse.at(i)->getListFils().at(j)->size();k++)
    //            {
    //                listLienAction.append(new lienAction());
    //                listLienAction.last()->indicePere = i;
    //                listLienAction.last()->indiceFils = listAction.indexOf(listToParse.at(i)->getListFils().at(j)->at(k));
    //                listAction.at(listAction.indexOf(listToParse.at(i)->getListFils().at(j)->at(k)))->getInfo();
    //            }
    //        }
    //    }


    QList<Action*> listPerePosition, listFils;

    listPerePosition.append(listAction.at(0));

    while(listPerePosition.size()>0)
    {
        for(int i = 0; i < listPerePosition.at(0)->getListFils().size();i++)
        {
            for(int j=0; j<listPerePosition.at(0)->getListFils().at(i)->size();j++)
            {
                listFils.append(listPerePosition.first()->getListFils().at(i)->at(j));
            }

        }
        while(listFils.size()>0)
        {
            if(listFils.at(0)->getType()==typePosition)
            {
                listLienAction.append(new lienAction());
                listLienAction.last()->indicePere = listAction.indexOf(listPerePosition.first());
                listLienAction.last()->indiceFils = listAction.indexOf(listFils.first());

                listPerePosition.append(listAction.at(listAction.indexOf(listFils.first())));

            }else
            {
                for(int i =0;i<listFils.at(0)->getListFils().size();i++)
                {
                    for(int j=0;j<listFils.at(0)->getListFils().at(i)->size();j++)
                    {
                        listFils.append(listFils.at(0)->getListFils().at(i)->at(j));
                    }
                }
            }
            listFils.removeFirst();
        }
        listPerePosition.removeFirst();
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
