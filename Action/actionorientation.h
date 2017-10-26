#ifndef ACTIONORIENTATION_H
#define ACTIONORIENTATION_H
#include "action.h"

class ActionOrientation : public Action
{
public:
    ActionOrientation();
    void saveXML(QXmlStreamWriter *xmlWriter);
};

#endif // ACTIONORIENTATION_H
