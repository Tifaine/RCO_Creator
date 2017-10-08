#include "sequence.h"

Sequence::Sequence()
{

}

void Sequence::addAction(Action* toBeAdded)
{
    listAction.append(toBeAdded);
}

void Sequence::supprAction(Action* toBeDeletted)
{
    if(listAction.contains(toBeDeletted)==true)
    {
        listAction.removeAt(listAction.indexOf(toBeDeletted));
    }
}

void Sequence::parcoursAction()
{
    qDebug()<<"----------------------";
    for(int i=0;i<listAction.size();i++)
    {
        if(listAction.at(i)->getTypeAction()==ACTION_POSITION)
        {
            qDebug()<<"x : "<< *(listAction.at(i)->getPosition().x);
            qDebug()<<"y : "<< *(listAction.at(i)->getPosition().y);
        }
    }
}
