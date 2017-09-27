#include "bloc_action.h"
#include <QDebug>

bloc_Action::bloc_Action(QQuickItem *parent) : QQuickItem(parent)
{
    listPere = new QList<bloc_Action*>;
    listFils = new QList<bloc_Action*>;
}

int bloc_Action::getX()
{
    return posX;
}

int bloc_Action::getY()
{
    return posY;
}

void bloc_Action::setX(int _x)
{
    posX = _x;
}

void bloc_Action::setY(int _y)
{
    posY = _y;
}

int bloc_Action::getXDraw() const
{
    return xDraw;
}

void bloc_Action::setXDraw(int value)
{
    xDraw = value;
}

int bloc_Action::getYDraw() const
{
    return yDraw;
}

void bloc_Action::setYDraw(int value)
{
    yDraw = value;
}

QList<bloc_Action *>* bloc_Action::getListPere() const
{
    return listPere;
}

QList<bloc_Action *> *bloc_Action::getListFils() const
{
    return listFils;
}

void bloc_Action::addFils(bloc_Action* toAdd)
{
    listFils->append(toAdd);
}


void bloc_Action::addPere(bloc_Action* toAdd)
{
    listPere->append(toAdd);
}

bloc_Action* bloc_Action::getFils(int indice)
{
    return listFils->at(indice);
}

bloc_Action* bloc_Action::getPere(int indice)
{
    return listPere->at(indice);
}

int bloc_Action::getNbPere()
{
    return listPere->size();
}

int bloc_Action::getNbFils()
{
    return listFils->size();
}

void bloc_Action::deleteFils(bloc_Action* toDelete)
{
    if(listFils->contains(toDelete)==true)
    {
        removeFils(listFils->indexOf(toDelete));
        listFils->removeAt(listFils->indexOf(toDelete));

        listFilsChanged();
    }
}

void bloc_Action::deletePere(bloc_Action* toDelete)
{
    if(listPere->contains(toDelete)==true)
    {
        listPere->removeAt(listPere->indexOf(toDelete));
    }
}

QString bloc_Action::nom_Bloc()
{
    return nomBloc;
}

void bloc_Action::setNom_Bloc(QString m_nomBloc)
{
   nomBloc = m_nomBloc;
}

void bloc_Action::otherHaraKiri(bloc_Action* other)
{

    while(listPere->contains(other))
    {
        listPere->removeAt(listPere->indexOf(other));
    }

    while(listFils->contains(other))
    {
        removeFils(listFils->indexOf(other));
        listFils->removeAt(listFils->indexOf(other));

        listFilsChanged();
    }
}

void bloc_Action::haraKiri()
{
    for(int i=0;i<listPere->size();i++)
    {
        listPere->at(i)->otherHaraKiri(this);
    }
    for(int i=0;i<listFils->size();i++)
    {
        listFils->at(i)->otherHaraKiri(this);
    }

    listFils->clear();
    listFilsChanged();
}

