#include "bip39_helper.h"

#include <iostream> // fix bip39 build

#include <bip39/bip39.h>

QString Bip39Helper::generatePhrase() {
  auto mnemonic = BIP39::generate_mnemonic();
  return QString::fromStdString(mnemonic.to_string());
}

bool Bip39Helper::validatePhrase(const QString &phrase) {
  BIP39::word_list mnemonic;
  auto words = phrase.split(' ');
  for (const auto &word : words) {
    mnemonic.add(word.toStdString());
  }
  return BIP39::valid_mnemonic(mnemonic);
}
