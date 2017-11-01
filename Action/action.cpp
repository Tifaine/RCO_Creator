#include "action.h"
#include <QDebug>

Action::Action(QQuickItem *parent) : QQuickItem(parent)
{

}

int Action::getType() const
{
    return type;
}

void Action::setType(int value)
{
    type = value;
}

void Action::getInfo()
{
    qDebug()<<"Pas redéfinit, je suis une mère.";
}

void Action::creerAction(int type)
{
    switch(type)
    {
    case typePosition:
    {
        //this = new ActionPosition;
        break;
    }
    }
}

void Action::ajouterListFils()
{
    listFils.append(new QList<Action *>);
}

void Action::ajouterFils(int indiceListe, Action* act)
{
    listFils.at(indiceListe)->append(act);
}

void Action::supprimerFils(Action * actToDelete)
{
    for(int i=0;i<listFils.size();i++)
    {
        if(listFils.at(i)->indexOf(actToDelete)!=-1)
        {
            listFils.at(i)->removeAt(listFils.at(i)->indexOf(actToDelete));
        }
    }
}

int Action::getYBloc() const
{
    return yBloc;
}

void Action::setYBloc(int value)
{
    yBloc = value;
}

int Action::getXBloc() const
{
    return xBloc;
}

void Action::setXBloc(int value)
{
    xBloc = value;
}

QList<QList<Action *> *> Action::getListFils() const
{
    return listFils;
}
