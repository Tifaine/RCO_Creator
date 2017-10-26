#ifndef ACTIONSERVO_H
#define ACTIONSERVO_H
#include "action.h"

class ActionServo : public Action
{
public:
    ActionServo();
    void saveXML(QXmlStreamWriter *xmlWriter);
};

#endif // ACTIONSERVO_H
