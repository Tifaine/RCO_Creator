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



void Action::ajouterListFils()
{
    listFils.append(new QList<Action *>);
}

void Action::ajouterFils(int indiceListe, Action* act)
{
    listFils.at(indiceListe)->append(act);
    paramChanged(this,"ajoutFils",act);
}

void Action::supprimerFils(Action * actToDelete)
{
    for(int i=0;i<listFils.size();i++)
    {
        if(listFils.at(i)->indexOf(actToDelete)!=-1)
        {
            listFils.at(i)->removeAt(listFils.at(i)->indexOf(actToDelete));
            paramChanged(this,"deleteFils",actToDelete);
        }
    }
}

void Action::ajouterListPere()
{
    listPere.append(new QList<Action *>);
}

void Action::ajouterPere(int indiceListe, Action* act)
{
    listPere.at(indiceListe)->append(act);
}

void Action::supprimerPere(Action * actToDelete)
{
    for(int i=0;i<listPere.size();i++)
    {
        if(listPere.at(i)->indexOf(actToDelete)!=-1)
        {
            listPere.at(i)->removeAt(listPere.at(i)->indexOf(actToDelete));
        }
    }
}

QList<QList<Action *> *> Action::getListPere() const
{
    return listPere;
}

int Action::getTimeOut() const
{
    return timeOut;
}

void Action::setTimeOut(int value)
{
    timeOut = value;
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
