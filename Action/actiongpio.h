#ifndef ACTIONGPIO_H
#define ACTIONGPIO_H
#include "action.h"

class ActionGPIO : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idGPIO READ getIdGPIO WRITE setIdGPIO NOTIFY idGPIOChanged)
    Q_PROPERTY(int valueGPIO READ getValueGPIO WRITE setValueGPIO NOTIFY valueGPIOChanged)
public:
    ActionGPIO();

    void saveXML(QXmlStreamWriter* xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getIdGPIO() const;
    void setIdGPIO(int value);

    int getValueGPIO() const;
    void setValueGPIO(int value);

signals:
    void idGPIOChanged();
    void valueGPIOChanged();

private:
    int idGPIO = -1;
    int valueGPIO = -1;
};

#endif // ACTIONGPIO_H
