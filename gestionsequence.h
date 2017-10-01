#ifndef GESTIONSEQUENCE_H
#define GESTIONSEQUENCE_H

#include <QObject>
#include <QDir>
#include <QDebug>
#include <QFile>
#include <QFileSystemWatcher>
#include <QtXml>

class gestionSequence : public QObject
{
    Q_OBJECT
public:
    gestionSequence();
signals:
    void change();

public slots:
    int getNbFile();
    QString getNameFile(int indice);
    void captureFichierScript(QString a);
private:

    QStringList nomFiles;
    QDir* dossierScript;
    QFileSystemWatcher* watcher;
};

#endif // GESTIONSEQUENCE_H
