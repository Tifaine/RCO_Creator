#ifndef ATTENTESERVO_H
#define ATTENTESERVO_H
#include "../action.h"

class AttenteServo : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idServo READ getIdServo WRITE setIdServo NOTIFY idServoChanged)
    Q_PROPERTY(int valueAttente READ getValueAttente WRITE setValueAttente NOTIFY valueAttenteChanged)
    Q_PROPERTY(QString nomServo READ getNomServo WRITE setNomServo NOTIFY nomServoChanged)

public:
    AttenteServo();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
    int getIdServo() const;
    void setIdServo(int value);

    int getValueAttente() const;
    void setValueAttente(int value);

    QString getNomServo() const;
    void setNomServo(const QString &value);

signals:
    void idServoChanged();
    void valueAttenteChanged();
    void nomServoChanged();

private:
    int idServo = -1;
    int valueAttente = -1;
    QString nomServo = " ";
};

#endif // ATTENTESERVO_H
