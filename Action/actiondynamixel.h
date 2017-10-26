#ifndef ACTIONDYNAMIXEL_H
#define ACTIONDYNAMIXEL_H
#include "action.h"

class ActionDynamixel : public Action
{
public:
    ActionDynamixel();
    void saveXML(QXmlStreamWriter *xmlWriter);
};

#endif // ACTIONDYNAMIXEL_H
