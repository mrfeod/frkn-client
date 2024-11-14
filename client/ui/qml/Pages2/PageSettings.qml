import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import PageEnum 1.0
import Style 1.0

import "./"
import "../Controls2"
import "../Controls2/TextTypes"
import "../Config"

PageType {
    id: root

    defaultActiveFocusItem: header

    FlickableType {
        id: fl
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        contentHeight: content.height

        ColumnLayout {
            id: content

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 0

            HeaderType {
                id: header
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.rightMargin: 16
                Layout.leftMargin: 16

                headerText: qsTr("Settings")

                KeyNavigation.tab: connection.rightButton
            }

            // LabelWithButtonType {
            //     id: account
            //     Layout.fillWidth: true
            //     Layout.topMargin: 16

            //     text: qsTr("Servers")
            //     rightImageSource: "qrc:/images/controls/chevron-right.svg"
            //     leftImageSource: "qrc:/images/controls/server.svg"

            //     clickedFunction: function() {
            //         PageController.goToPage(PageEnum.PageSettingsServersList)
            //     }

            //     KeyNavigation.tab: connection.rightButton
            // }

            // DividerType {}

            LabelWithButtonType {
                id: connection
                Layout.fillWidth: true

                text: qsTr("Connection")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/radio.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsConnection)
                }

                KeyNavigation.tab: application.rightButton
            }

            DividerType {}

            LabelWithButtonType {
                id: application
                Layout.fillWidth: true

                text: qsTr("Application")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/app.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsApplication)
                }

                KeyNavigation.tab: about.rightButton
            }

            DividerType {}

            // LabelWithButtonType {
            //     id: backup
            //     Layout.fillWidth: true

            //     text: qsTr("Backup")
            //     rightImageSource: "qrc:/images/controls/chevron-right.svg"
            //     leftImageSource: "qrc:/images/controls/save.svg"

            //     clickedFunction: function() {
            //         PageController.goToPage(PageEnum.PageSettingsBackup)
            //     }

            //     KeyNavigation.tab: about.rightButton
            // }

            // DividerType {}

            LabelWithButtonType {
                id: about
                Layout.fillWidth: true

                text: qsTr("About AmneziaVPN")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/amnezia.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsAbout)
                }
                KeyNavigation.tab: updateConfig

            }

            DividerType {}

            LabelWithButtonType {
                id: devConsole
                visible: SettingsController.isDevModeEnabled
                Layout.fillWidth: true

                text: qsTr("Dev console")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/bug.svg"

                // Keys.onTabPressed: lastItemTabClicked(header)

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageDevMenu)
                }
            }

            DividerType {
                visible: SettingsController.isDevModeEnabled
            }

            LabelWithButtonType {
                id: updateConfig
                Layout.fillWidth: true
                Layout.preferredHeight: about.height

                text: qsTr("Update configuration")
                leftImageSource: "qrc:/images/controls/refresh-cw.svg"
                isLeftImageHoverEnabled: false

                clickedFunction: function() {
                    if(FrknApi.checkForUpdates()) {
                        PageController.showBusyIndicator(true)
                    }
                    else {
                        PageController.showNotificationMessage(qsTr("Configuration is up to date"))
                    }
                }

                KeyNavigation.tab: logout
            }

            DividerType {
                visible: GC.isDesktop()
            }

            LabelWithButtonType {
                id: logout
                Layout.fillWidth: true
                Layout.preferredHeight: about.height

                text: qsTr("Logout")
                leftImageSource: "qrc:/images/controls/logout.svg"
                isLeftImageHoverEnabled: false

                clickedFunction: function() {
                    var headerText = qsTr("Logout and remove all servers data from the application?")
                    var descriptionText = qsTr("Servers settings will be removed. You can login again with your mnemophrase.")
                    var yesButtonText = qsTr("Continue")
                    var noButtonText = qsTr("Cancel")

                    var yesButtonFunction = function() {
                        if (ServersModel.isDefaultServerCurrentlyProcessed() && ConnectionController.isConnected) {
                            PageController.showNotificationMessage(qsTr("Cannot logout during active connection"))
                        } else
                        {
                            ServersModel.removeServers()
                            SettingsController.resetFrknToken()
                            PageController.goToPageHome()
                        }

                        if (!GC.isMobile()) {
                            root.defaultActiveFocusItem.forceActiveFocus()
                        }
                    }
                    var noButtonFunction = function() {
                        if (!GC.isMobile()) {
                            root.defaultActiveFocusItem.forceActiveFocus()
                        }
                    }

                    showQuestionDrawer(headerText, descriptionText, yesButtonText, noButtonText, yesButtonFunction, noButtonFunction)
                }

                KeyNavigation.tab: close
            }

            DividerType {
                visible: GC.isDesktop()
            }

            LabelWithButtonType {
                id: close
                visible: GC.isDesktop()
                Layout.fillWidth: true
                Layout.preferredHeight: about.height

                text: qsTr("Close application")
                leftImageSource: "qrc:/images/controls/x-circle.svg"
                isLeftImageHoverEnabled: false                

                Keys.onTabPressed: lastItemTabClicked(header)

                clickedFunction: function() {
                    PageController.closeApplication()
                }
            }

            DividerType {
                visible: GC.isDesktop()
            }
        }
    }
}
