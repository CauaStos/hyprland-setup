import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../globals/components/"
import "../../config/"
import Quickshell.Hyprland
import Quickshell.Wayland


Scope {

    PanelWindow {
        id: switcher

        property bool isVisible: false
        WlrLayershell.layer: WlrLayer.Overlay

        property int screen_width: switcher.screen.width
        property int screen_height: switcher.screen.height

        property int container_width: screen_width * 0.125
        property int container_height: screen_height * 0.125
        property int border_radius: container_width * 0.05
        property int border_width: screen_height * 0.0025
        property int padding: container_height * 0.115

        color: 'transparent'

        WorkerScript {
            id: switcherWorker
            source: 'switcherWorker.js'

            onMessage: (message) => {
                switch(message.message){
                    case "update_position":
                        switcher.switcherPosition = message.data
                        break
                    case "update_clients":
                        grid.children = null
                        let thumbnails = ToplevelManager.toplevels.values
                        message.data.forEach((client, index) => {
                            const new_preview = windowPreviewComponent.createObject(grid);
                            new_preview.index = index
                            new_preview.pid = client.pid
                            new_preview.title = client.initialTitle
                            new_preview.icon = switcher.query_icon(client.class, client.initialTitle)


                            thumbnails.forEach((thumbnail, index) => {
                                if(thumbnail.appId == client.class && thumbnail.title == thumbnail.title){
                                    if(thumbnail) new_preview.thumbnail = thumbnail
                                    return
                                }
                            })
                        })

                }
            }
        }

        function query_icon(app_class, app_initial_title) {
            let icon = "placeholder"

            function search_icon(icon_query){
                if(icon!="placeholder") return

                let query = icon_query.toLowerCase()
                let desktop_entries = DesktopEntries.applications.values
                desktop_entries.forEach((entry) => {
                    if(entry.icon.includes(query)) icon = entry.icon
                })
            }

            search_icon(app_class)

            search_icon(app_initial_title)

            const split = app_class.split('.')
            search_icon(split[split.length-1])

            return icon
        }

        property int switcherPosition: 0


        width: grid_container.width || 1
        height: grid_container.height +  padding || 1


        visible: isVisible


        Component {
            id: windowPreviewComponent

            Rectangle {
                id: windowPreview





                property int index: 0
                property string icon: "placeholder"
                property string title: "title"
                property int pid: 0
                property QtObject thumbnail: null
                property color border_color: index === switcher.switcherPosition ? Colors.primary : Colors.surface_container_highest



                width: switcher.container_width
                height: switcher.container_height


                border.color: border_color
                border.width: switcher.border_width

                radius: switcher.border_radius

                    anchors.margins: switcher.border_width + switcher.padding
                    color: Colors.surface_container



                        ScreencopyView {
                            id: preview
                            anchors.margins: switcher.border_width
                            anchors.fill: parent
                            paintCursor: true
                            smooth: true
                               live: true
                               captureSource: thumbnail

                        }

                        Rectangle {

                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: parent.height * 0.05
                            anchors.topMargin: parent.height * 0.05

                            width: row.width + switcher.padding
                            height: row.height + switcher.padding
                            color: Colors.surface_container
                            border.width: switcher.border_width
                            border.color: Colors.surface_container_highest
                            radius: switcher.border_radius



                            RowLayout {
                                id: row
                                anchors.centerIn: parent
                                Layout.margins: switcher.padding

                                IconImage {
                                    width: 20
                                    height: 20
                                    source: Quickshell.iconPath(icon)
                                }

                                StyledText{
                                    color: windowPreview.index === switcher.switcherPosition ? Colors.primary : Colors.on_surface

                                    text: title
                                }

                            }

                        }





            }
        }


        Rectangle {
            id: grid_container
            width: grid.width + switcher.padding
            height: grid.height + switcher.padding
            radius: switcher.border_radius


            color: Colors.surface


            GridLayout {
                anchors.centerIn: parent
                id: grid
                columns: 3
            }
        }

        Process {
            id: fetchClients
            running: true
            command: ["hyprctl", "clients", "-j"]
            stdout: SplitParser {
                splitMarker: ''
                onRead: data => {
                    let clients = JSON.parse(data)
                    switcherWorker.sendMessage({message: "update_clients", clients: clients})
                }
            }
        }

        Process {
            id: switchWindow
            running: false
            property int pid: 0
            command: ["hyprctl", "dispatch", "focuswindow", `pid:${pid}`]
            onExited: {
                switcher.isVisible = false
                fetchClients.running = true
            }
        }


        Component.onCompleted: {
            Hyprland.rawEvent.connect((event) => {
                switch(event.name){
                    case 'activewindow':
                        fetchClients.running = true
                        break

                }
            })
        }


        IpcHandler {
            target: "Switcher"

            function cycle_next() {
                switcher.isVisible = true
                switcherWorker.sendMessage({message: "next"})
            }

            function switch_window() {
                if(switcher.isVisible){
                    switchWindow.pid = grid.children[switcher.switcherPosition].pid
                    switchWindow.running = true
                }
            }

          }





    }
}
