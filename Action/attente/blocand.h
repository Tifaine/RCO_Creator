#ifndef BLOCAND_H
#define BLOCAND_H

#include "../action.h"

class BlocAND : public Action
{
    Q_OBJECT
public:
    explicit BlocAND();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

signals:

public slots:
};

#endif // BLOCAND_H
