#ifndef ACTIONDYNAMIXEL_H
#define ACTIONDYNAMIXEL_H
#include "action.h"

class ActionDynamixel : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idDyna READ getIdDyna WRITE setIdDyna NOTIFY idDynaChanged)
    Q_PROPERTY(int ValueDyna READ getValueDyna WRITE setValueDyna NOTIFY valueDynaChanged)
    Q_PROPERTY(int vitesseDyna READ getVitesseDyna WRITE setVitesseDyna NOTIFY vitesseDynaChanged)
    Q_PROPERTY(QString nomDyna READ getNomDyna WRITE setNomDyna NOTIFY nomDynaChanged)
public:
    ActionDynamixel();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getIdDyna() const;
    void setIdDyna(int value);

    int getValueDyna() const;
    void setValueDyna(int value);

    int getVitesseDyna() const;
    void setVitesseDyna(int value);

    QString getNomDyna() const;
    void setNomDyna(const QString &value);

signals:
    void idDynaChanged();
    void valueDynaChanged();
    void vitesseDynaChanged();
    void nomDynaChanged();

private :
    int idDyna = -1;
    int valueDyna = -1;
    int vitesseDyna = -1;
    QString nomDyna = " ";
};

#endif // ACTIONDYNAMIXEL_H
