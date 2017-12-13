#ifndef ACTIONSEQUENCE_H
#define ACTIONSEQUENCE_H
#include "action.h"

class ActionSequence : public Action
{
    Q_OBJECT
    Q_PROPERTY(QString _nomSequence READ getNomSequence WRITE setNomSequence NOTIFY nomSequenceChanged)
public:
    ActionSequence();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    QString getNomSequence() const;
    void setNomSequence(const QString &value);

signals:
    void nomSequenceChanged();

private:
    QString _nomSequence;
};

#endif // ACTIONSEQUENCE_H
