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
            paramChanged(actToDelete,"deleteFils",actToDelete);
        }
    }
}

void Action::ajouterNumberIn(Action* newNumberIn)
{
    listNumberIn.append(newNumberIn);
    paramChanged(this,"ajouterNumberIn",newNumberIn);
}

void Action::supprimerNumberIn(Action * numberInToDelete)
{

    if(listNumberIn.indexOf(numberInToDelete)!=-1)
    {
        listNumberIn.removeAt(listNumberIn.indexOf(numberInToDelete));
        paramChanged(numberInToDelete,"supprimerNumberIn",numberInToDelete);
    }
}

void Action::ajouterNumberOut(Action* newNumberOut)
{
    listNumberOut.append(newNumberOut);
}

void Action::supprimerNumberOut(Action* numberOutToDelete)
{
    if(listNumberOut.indexOf(numberOutToDelete)!=-1)
    {
        listNumberOut.removeAt(listNumberOut.indexOf(numberOutToDelete));
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

int Action::getNbPere()
{
    return listPere.at(0)->size();
}

int Action::getnbListFils()
{
    return listFils.size();
}

int Action::getNbFils(int indiceListe)
{
    return listFils.at(indiceListe)->size();
}

Action* Action::getFils(int indiceListe, int indiceFils)
{
    return listFils.at(indiceListe)->at(indiceFils);
}

Action* Action::getPere(int indicePere)
{
    return listPere.at(0)->at(indicePere);
}

bool Action::getIsParcourue() const
{
    return isParcourue;
}

void Action::setIsParcourue(bool value)
{
    isParcourue = value;
}

QString Action::getNameDetect() const
{
    return nameDetect;
}

void Action::setNameDetect(const QString &value)
{
    nameDetect = value;
}

QList<Action *> Action::getListNumberIn() const
{
    return listNumberIn;
}

QList<Action *> Action::getListNumberOut() const
{
    return listNumberOut;
}
