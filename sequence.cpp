#include "sequence.h"

Sequence::Sequence()
{

}

void Sequence::addAction(Action* toBeAdded)
{
    listAction.append(toBeAdded);

    listAction.last()->toString();
}
