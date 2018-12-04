#ifndef ACTIONSERVO_H
#define ACTIONSERVO_H
#include "action.h"

class ActionServo : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idServo READ getIdServo WRITE setIdServo NOTIFY idServoChanged)
    Q_PROPERTY(int valueServo READ getValueServo WRITE setValueServo NOTIFY valueServoChanged)
    Q_PROPERTY(QString nomServo READ getNomServo WRITE setNomServo NOTIFY nomServoChanged)
public:
    ActionServo();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getIdServo() const;
    void setIdServo(int value);

    int getValueServo() const;
    void setValueServo(int value);

    QString getNomServo() const;
    void setNomServo(const QString &value);

signals:
    void idServoChanged();
    void valueServoChanged();
    void nomServoChanged();

private:
    int idServo = -1;
    int valueServo = -1;
    QString nomServo = " ";
};

#endif // ACTIONSERVO_H
