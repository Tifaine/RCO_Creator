#ifndef ACTIONORIENTATION_H
#define ACTIONORIENTATION_H
#include "action.h"

class ActionOrientation : public Action
{
    Q_OBJECT
    Q_PROPERTY(int angle READ getAngle WRITE setAngle NOTIFY angleChanged)
public:
    ActionOrientation();
    void saveXML(QXmlStreamWriter *xmlWriter);


    int getAngle() const;
    void setAngle(int value);

signals:
    void angleChanged();

private:
    int angle = 180;
};

#endif // ACTIONORIENTATION_H
