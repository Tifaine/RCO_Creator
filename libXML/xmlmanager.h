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
    void genererAction(int xBloc, int yBloc, int typeBloc, QString listPere, QString listFils,QString param0 ,QString param1, QString param2, QString param3, QString param4, QString param5);
    void finParsage();

public slots:
    int parseFile(void);

private:
    QString nomXmlFile =" ";

};

#endif // XMLMANAGER_H
