import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import PageEnum 1.0
import Style 1.0

import "./"
import "../Controls2"
import "../Config"
import "../Controls2/TextTypes"
import "../Components"

PageType {
    id: root

    defaultActiveFocusItem: focusItem

    ColumnLayout {
        id: content

        anchors.fill: parent
        spacing: 0

        Item {
            id: focusItem
            KeyNavigation.tab: startButton
        }

        Header2Type {
            Layout.fillWidth: true
            Layout.topMargin: 24
            Layout.rightMargin: 16
            Layout.leftMargin: 16

            headerText: qsTr("Log in FRKN")
        }

        Image {
            id: image
            source: "qrc:/images/amneziaBigLogo.png"

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredWidth: 180
            Layout.preferredHeight: 144
        }

        LabelTextType {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            text: qsTr("FRKN provides complete anonymity without collecting personal data. Upon registration, you will be provided with a unique 12 words mnemophrase.")
        }

        LabelTextType {
            id: warningText
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            visible: false

            text: qsTr("● Record and securely save your mnemophrase\n\n● Do not share your mnemophrase with anyone\n\n● In case of loss, recovery is impossible")
        }

        Item
        {
            Layout.fillHeight: true
        }

        TextFieldWithHeaderType {
            id: textKey

            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16

            headerText: qsTr("Your 12 words mnemophrase")
            buttonText: qsTr("Insert")
            textFieldPlaceholderText: qsTr("frog roof kitchen nature ...")

            clickedFunc: function() {
                textField.text = ""
                textField.paste()
            }

            KeyNavigation.tab: lastItemTabClicked(focusItem)
        }

        BasicButtonType {
            id: copyButton
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            visible: false

            text: qsTr("Copy mnemonic phrase")

            clickedFunc: function() {
                textKey.textField.selectAll()
                textKey.textField.copy()
                textKey.textField.deselect()
            }

            Keys.onTabPressed: lastItemTabClicked(focusItem)
        }

        BasicButtonType {
            id: loginButton
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.bottomMargin: registerButton.visible ? 0 : 48

            text: qsTr("Log in")

            clickedFunc: function() {
                // TODO Check mnemonic phrase
                // TODO If mnemonic phrase is valid - download and add configs
                // See how PageSetupWizardConfigSource.qml manages it
            }

            Keys.onTabPressed: lastItemTabClicked(focusItem)
        }

        BasicButtonType {
            id: registerButton
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.bottomMargin: 48

            text: qsTr("Register")

            clickedFunc: function() {
                // Generate BIP39 mnemonic phrase
                // SHA3_512 hex is the user id
                // TODO Receive mnemonic phrase from the server
                // TODO Set mnemonic phrase to textKey.textFieldText
                // This is valid only for testing purposes

                // Redirect to login page with mnemophrase

                // Auth with SHA3_512 in FRKN and receive configs

                // Use mock server to receive configs

                textKey.buttonText = ""
                textKey.textFieldText = "comfort search stem execute face relief exhaust happy erode movie swing one"
                textKey.textFieldEditable = false

                visible = false
                copyButton.visible = true
                warningText.visible = true
            }

            Keys.onTabPressed: lastItemTabClicked(focusItem)
        }
    }
}
