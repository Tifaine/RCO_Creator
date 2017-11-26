#include "gestionsequence.h"

GestionSequence::GestionSequence(QObject *parent) : QObject(parent)
{
    fileWatcher = new QFileSystemWatcher;
    dirScript = new QDir("scripts");
    dirScript->setFilter(QDir::Files | QDir::NoDotAndDotDot);

    fileWatcher->addPath("scripts");

    parseDirectory();
    connect(fileWatcher,SIGNAL(directoryChanged(QString)),this,SLOT(parseDirectory()));
}

int GestionSequence::getNbFile()
{
    return listNomFile.size();
}

QString GestionSequence::getNameFile(int indice)
{
    return listNomFile.at(indice);
}

void GestionSequence::parseDirectory()
{
    QStringList filters;
    filters << "*.xml";
    listNomFile.clear();
    for(int i=0; i<dirScript->count();i++)
    {
        listNomFile.append(dirScript->entryList(filters).at(i));
    }
    emit change();
}

void GestionSequence::afficheTab(QString nomSequence)
{
    emit afficherSequence(nomSequence);
}
