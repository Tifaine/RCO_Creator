#ifndef ACTIONORIENTATION_H
#define ACTIONORIENTATION_H
#include "action.h"

class ActionOrientation : public Action
{
    Q_OBJECT
    Q_PROPERTY(int angle READ getAngle WRITE setAngle NOTIFY angleChanged)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)

public:
    ActionOrientation();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getAngle() const;
    void setAngle(int value);

    int getPrecision() const;
    void setPrecision(int value);

signals:
    void precisionChanged();
    void angleChanged();

private:
    int angle = 180;
    int precision = 3;
};

#endif // ACTIONORIENTATION_H
