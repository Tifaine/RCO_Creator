#ifndef RETOURVARIABLE_H
#define RETOURVARIABLE_H
#include "../action.h"

class RetourVariable : public Action
{
    Q_OBJECT
    Q_PROPERTY(int nomCondition READ getNomCondition WRITE setNomCondition NOTIFY nomConditionChanged)
    Q_PROPERTY(int nomRobot READ getNomRobot WRITE setNomRobot NOTIFY nomRobotChanged)
    Q_PROPERTY(int nomVar READ getNomVar WRITE setNomVar NOTIFY nomVarChanged)
    Q_PROPERTY(double variable READ getVariable WRITE setVariable NOTIFY variableChanged)

public:
    RetourVariable();
    void saveXML(QXmlStreamWriter* xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    double getVariable() const;
    void setVariable(double value);

    int getNomCondition() const;
    void setNomCondition(int value);

    int getNomRobot() const;
    void setNomRobot(int value);

    int getNomVar() const;
    void setNomVar(int value);

signals:
    void nomVarChanged();
    void nomRobotChanged();
    void nomConditionChanged();
    void variableChanged();

private:
    int nomVar;
    int nomRobot;
    int nomCondition;
    double variable;
};

#endif // RETOURVARIABLE_H
