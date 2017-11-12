#ifndef RETOURPOSITION_H
#define RETOURPOSITION_H
#include "../action.h"

class RetourPosition : public Action
{
    Q_OBJECT
    Q_PROPERTY(int xRobot READ getXRobot WRITE setXRobot NOTIFY xRobotChanged)
    Q_PROPERTY(int yRobot READ getYRobot WRITE setYRobot NOTIFY YRobotChanged)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)
public:
    RetourPosition();

    int getXRobot() const;
    void setXRobot(int value);

    int getYRobot() const;
    void setYRobot(int value);

    int getPrecision() const;
    void setPrecision(int value);

    void saveXML(QXmlStreamWriter* xmlWriter);

signals:
    void xRobotChanged();
    void YRobotChanged();
    void precisionChanged();

private:
    int xRobot = 0;
    int yRobot = 0;
    int precision = 50;
};

#endif // RETOURPOSITION_H
