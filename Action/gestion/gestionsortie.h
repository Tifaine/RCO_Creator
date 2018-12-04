#ifndef GESTIONSORTIE_H
#define GESTIONSORTIE_H

#include <QQuickItem>
#include <QDebug>

class GestionSortie : public QQuickItem
{
    Q_OBJECT
public:
    GestionSortie();

signals:

public slots:
    void affichTest(int var);
};

#endif // GESTIONSORTIE_H
