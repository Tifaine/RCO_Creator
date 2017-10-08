#include "action.h"

Action::Action()
{

}

void Action::setTypeAction(int value)
{
    typeAction = value;
}

void Action::setBlocant(bool value)
{
    blocant = value;
}

bool Action::getBlocant() const
{
    return blocant;
}

int Action::getTypeAction() const
{
    return typeAction;
}

struct position Action::getPosition()
{
    struct position posRobot;

    return posRobot;
}

