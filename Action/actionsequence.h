#ifndef ACTIONSEQUENCE_H
#define ACTIONSEQUENCE_H
#include "action.h"

class ActionSequence : public Action
{
public:
    ActionSequence();
    void saveXML(QXmlStreamWriter *xmlWriter);
};

#endif // ACTIONSEQUENCE_H
