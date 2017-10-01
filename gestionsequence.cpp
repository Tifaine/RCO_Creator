#include "gestionsequence.h"

gestionSequence::gestionSequence()
{
    dossierScript = new QDir("scripts");
    if(!dossierScript->exists())
    {
        QDir().mkdir("scripts");
    }
    watcher = new QFileSystemWatcher();
    watcher->addPath("scripts");
    QStringList filters;
    filters << "*.txt"<<"*.xml";
    dossierScript->setNameFilters(filters);
    nomFiles = dossierScript->entryList();
    connect(watcher,SIGNAL(directoryChanged(QString)),this,SLOT(captureFichierScript(QString)));
}


int gestionSequence::getNbFile()
{
    return nomFiles.size();
}

QString gestionSequence::getNameFile(int indice)
{
    return nomFiles.at(indice);
}

void gestionSequence::captureFichierScript(QString a)
{
    dossierScript = new QDir("scripts");
    QStringList filters;
    filters << "*.txt"<<"*.xml";
    dossierScript->setNameFilters(filters);
    nomFiles.clear();
    nomFiles = dossierScript->entryList();
    emit change();
}
