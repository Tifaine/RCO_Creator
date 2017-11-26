QT += qml quick
QT += xml

CONFIG += c++11

SOURCES += main.cpp \
    Action/attente/attentedyna.cpp \
    Action/attente/attenteservo.cpp \
    Action/attente/attentetemps.cpp \
    Action/attente/retourdeplacement.cpp \
    Action/attente/retourgpio.cpp \
    Action/attente/retourorientation.cpp \
    Action/attente/retourposition.cpp \
    Action/gestion/dynamixel.cpp \
    Action/gestion/gestiondynamixel.cpp \
    Action/gestion/gestionservo.cpp \
    Action/gestion/gestionsortie.cpp \
    Action/gestion/servo.cpp \
    Action/action.cpp \
    Action/actionautre.cpp \
    Action/actioncapteur.cpp \
    Action/actiondepart.cpp \
    Action/actiondynamixel.cpp \
    Action/actiongpio.cpp \
    Action/actionmoteur.cpp \
    Action/actionorientation.cpp \
    Action/actionposition.cpp \
    Action/actionsequence.cpp \
    Action/actionservo.cpp \
    Composant/connector.cpp \
    libXML/tinystr.cpp \
    libXML/tinyxml.cpp \
    libXML/tinyxmlerror.cpp \
    libXML/tinyxmlparser.cpp \
    Sequence/sequence.cpp \
    libXML/xmlmanager.cpp \
    Action/gestion/gestionsequence.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Action/attente/attentedyna.h \
    Action/attente/attenteservo.h \
    Action/attente/attentetemps.h \
    Action/attente/retourdeplacement.h \
    Action/attente/retourgpio.h \
    Action/attente/retourorientation.h \
    Action/attente/retourposition.h \
    Action/gestion/dynamixel.h \
    Action/gestion/gestiondynamixel.h \
    Action/gestion/gestionservo.h \
    Action/gestion/gestionsortie.h \
    Action/gestion/servo.h \
    Action/action.h \
    Action/actionautre.h \
    Action/actioncapteur.h \
    Action/actiondepart.h \
    Action/actiondynamixel.h \
    Action/actiongpio.h \
    Action/actionmoteur.h \
    Action/actionorientation.h \
    Action/actionposition.h \
    Action/actionsequence.h \
    Action/actionservo.h \
    Composant/connector.h \
    libXML/tinystr.h \
    libXML/tinyxml.h \
    Sequence/sequence.h \
    libXML/xmlmanager.h \
    Action/gestion/gestionsequence.h

