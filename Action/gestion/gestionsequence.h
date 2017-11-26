#ifndef GESTIONSEQUENCE_H
#define GESTIONSEQUENCE_H

#include <QObject>
#include <QDebug>
#include <QList>
#include <QDir>
#include <QFileSystemWatcher>

class GestionSequence : public QObject
{
    Q_OBJECT
public:
    explicit GestionSequence(QObject *parent = nullptr);

signals:
    void change();
    void afficherSequence(QString nomSequence);

public slots:
    int getNbFile();
    QString getNameFile(int indice);
    void parseDirectory();
    void afficheTab(QString nomSequence);

private:
    QList<QString> listNomFile;
    QFileSystemWatcher* fileWatcher;
    QDir* dirScript;

};

#endif // GESTIONSEQUENCE_H
