#ifndef ATTENTEDYNA_H
#define ATTENTEDYNA_H
#include "../action.h"

class AttenteDyna : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idDyna READ getIdDyna WRITE setIdDyna NOTIFY idDynaChanged)
    Q_PROPERTY(int valueDyna READ getValueDyna WRITE setValueDyna NOTIFY valueDynaChanged)
    Q_PROPERTY(QString nomDyna READ getNomDyna WRITE setNomDyna NOTIFY nomDynaChanged)
    Q_PROPERTY(bool type READ getType WRITE setType NOTIFY typeChanged)

public:
    AttenteDyna();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
    int getIdDyna() const;
    void setIdDyna(int value);

    int getValueDyna() const;
    void setValueDyna(int value);

    QString getNomDyna() const;
    void setNomDyna(const QString &value);
    bool getType() const;
    void setType(bool value);

signals:
    void idDynaChanged();
    void valueDynaChanged();
    void nomDynaChanged();
    void typeChanged();

private:
    int idDyna = -1;
    int valueDyna = -1;
    QString nomDyna = " ";
    bool type = false;
};

#endif // ATTENTEDYNA_H
