#ifndef RETOURORIENTATION_H
#define RETOURORIENTATION_H
#include "../action.h"

class RetourOrientation : public Action
{
    Q_OBJECT
    Q_PROPERTY(int orientation READ getOrientation WRITE setOrientation NOTIFY orientationChanged)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)
public:
    RetourOrientation();

    int getOrientation() const;
    void setOrientation(int value);

    int getPrecision() const;
    void setPrecision(int value);

    void saveXML(QXmlStreamWriter* xmlWriter);

signals:
    void orientationChanged();
    void precisionChanged();

private:

    int orientation = 0;
    int precision = 3;
};

#endif // RETOURORIENTATION_H
