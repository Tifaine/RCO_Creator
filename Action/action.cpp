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
