#ifndef BIP39_HELPER_H
#define BIP39_HELPER_H

#include <QObject>
#include <QString>

class Bip39Helper : public QObject {
  Q_OBJECT
public:
  Q_INVOKABLE static QString generatePhrase();
  Q_INVOKABLE static bool validatePhrase(const QString &phrase);
};

#endif // BIP39_HELPER_H