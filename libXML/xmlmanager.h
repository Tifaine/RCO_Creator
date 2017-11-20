#ifndef XMLMANAGER_H
#define XMLMANAGER_H
#include <QObject>
#include "QDebug"
#include "../Action/action.h"

#include "tinyxml.h"
#include "tinystr.h"

class XMLManager : public QObject
{
    Q_OBJECT
public:
    explicit XMLManager(QObject *parent = nullptr);

    QString getNomXmlFile() const;
    void setNomXmlFile(const QString &value);


signals:
    void genererAction(int xBloc, int yBloc, int typeBloc);
public slots:
    int parseFile(void);

private:
    QString nomXmlFile =" ";

};

#endif // XMLMANAGER_H
