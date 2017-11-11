#ifndef ATTENTEDYNA_H
#define ATTENTEDYNA_H
#include "../action.h"

class AttenteDyna : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idDyna READ getIdDyna WRITE setIdDyna NOTIFY idDynaChanged)
    Q_PROPERTY(int valueDyna READ getValueDyna WRITE setValueDyna NOTIFY valueDynaChanged)
    Q_PROPERTY(QString nomDyna READ getNomDyna WRITE setNomDyna NOTIFY nomDynaChanged)

public:
    AttenteDyna();
    void saveXML(QXmlStreamWriter *xmlWriter);

    int getIdDyna() const;
    void setIdDyna(int value);

    int getValueDyna() const;
    void setValueDyna(int value);

    QString getNomDyna() const;
    void setNomDyna(const QString &value);
signals:
    void idDynaChanged();
    void valueDynaChanged();
    void nomDynaChanged();

private:
    int idDyna = -1;
    int valueDyna = -1;
    QString nomDyna = " ";
};

#endif // ATTENTEDYNA_H
