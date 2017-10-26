#ifndef ACTION_H
#define ACTION_H

#include <QQuickItem>
#include <QObject>
#include <QXmlStreamWriter>

#define typeServo       0
#define typeDyna        1
#define typeCapteur     2
#define typeMoteur      3
#define typeAutre       4
#define typePosition    5
#define typeOrientation 6
#define typeSequence    7
//define typeServo 9

class Action : public QQuickItem
{
    Q_OBJECT
public:
    Action(QQuickItem *parent = nullptr);
    int getType() const;
    void setType(int value);
    virtual void getInfo();
    virtual void saveXML(QXmlStreamWriter* xmlWriter) = 0;

signals:

public slots:

protected:

private:

    int type = -1;

};

#endif // ACTION_H
