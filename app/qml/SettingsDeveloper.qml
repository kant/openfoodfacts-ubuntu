import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0
import Ubuntu.Components.Popups 0.1

Page {
    id: settingsPage

    signal settingsChanged()
    Component.onCompleted: openFoodFacts.currentPage="Settings"

    header: PageHeader {
        title: i18n.tr("Developer settings")
       StyleHints {
           foregroundColor: openFoodFacts.settings.fontColor;
           backgroundColor: openFoodFacts.settings.color;
       }

   }
    Rectangle {
        id:main
        anchors {
            fill: parent
            topMargin: units.gu(6)
        }
        color: if (openFoodFacts.settings.color == "#3B3B3B"){ "#5D5D5D"; }else{ "#EDEDEC"; }

        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: settingsColumn.height
            flickableDirection: Flickable.VerticalFlick
            clip: true


            Column {
                id: settingsColumn
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }


                ListItem.Header {
                    text: "<font color=\""+openFoodFacts.settings.textColor+"\">"+i18n.tr("Developer settings")+"</font>"
                }

                ListItem.Standard {
                    showDivider: false
                    text: "<font color=\""+openFoodFacts.settings.textColor+"\">"+"Activate the welcome wizard at next start"+"</font>"
                    control: Switch {
                        id: welcomewizard
                        checked: openFoodFacts.settings.firstRun
                        onClicked: { openFoodFacts.settings.firstRun = checked;
                        }
                    }
                }

                ListItem.Standard {
                    showDivider: false
                    text: "<font color=\""+openFoodFacts.settings.textColor+"\">"+i18n.tr("scanner from the home page")+"</font>"
                    control: Switch {
                        id: scanhomepageswitch
                        checked: openFoodFacts.settings.scanhomepage
                        onClicked: { openFoodFacts.settings.scanhomepage = checked;
                                     pageStack.clear();
                             pageStack.push(Qt.resolvedUrl("main.qml"));
                        }
                    }
                }

                ListItem.Standard {
                    showDivider: false
                    text: "<font color=\""+openFoodFacts.settings.textColor+"\">"+"Enable health journal"+"</font>"
                    control: Switch {
                        id: healthjournal
                        checked: openFoodFacts.settings.healthjournal
                        onClicked: { openFoodFacts.settings.healthjournal = checked;
                        }
                    }
                }

            }
        } //flickable

        Button {
            id: settingsButton
            anchors {
                bottom: parent.bottom
                bottomMargin: units.gu(3)
                horizontalCenter: parent.horizontalCenter
            }
            height: units.gu(3)
            width: parent.width/1.5
            color: UbuntuColors.red
            text: i18n.tr("Delete settings")
            onClicked: {
                openFoodFacts.settings.firstRun = true;
                openFoodFacts.settings.scanhomepage = false;
                openFoodFacts.settings.visiblecomposition = true;
                openFoodFacts.settings.visiblenutrition =	true;
                openFoodFacts.settings.visibleingredient =	true;
                openFoodFacts.settings.visiblecharacteristics =	true;
                openFoodFacts.settings.healthjournal =	false;
                openFoodFacts.settings.color =  '#48c1ba';
                openFoodFacts.settings.fontColor = "white";
                openFoodFacts.settings.allergen = [];
                openFoodFacts.settings.developerModeEnabled =	false;
                openFoodFacts.settings.history = [];
                pageStack.clear();
                pageStack.push(Qt.resolvedUrl("main.qml"));
            }
        }


    }
}
