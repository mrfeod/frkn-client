#ifndef CONFIGCONTROLLER_H
#define CONFIGCONTROLLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

namespace frkn {

class ConfigController : public QObject {
  Q_OBJECT

public:
  explicit ConfigController(QObject *parent = nullptr);

signals:
  void configReceived(const QStringList &config);
  void loadError(const QString &message);

public slots:
  void loadConfig(const QString &url);

private slots:
  void onLoadConfigReply(QNetworkReply *reply);

private:
  QNetworkAccessManager *m_networkManager;
};
} // namespace frkn
#endif // CONFIGCONTROLLER_H