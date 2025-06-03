import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import "../../config/"
import "../globals/components/"

Scope {

    PanelWindow {
        id: switcher

        //Properties
        property bool isVisible: false

        screen: Quickshell.screens.forEach((screen, index) => {
            const preferred_monitor = "DP-3"
            if(screen.name == preferred_monitor) return index
        }) // Only open on primary screen.

        WlrLayershell.layer: WlrLayer.Overlay
        width: grid_container.width || 1
        height: grid_container.height +  padding || 1
        color: 'transparent'
        visible: isVisible


        property int screen_width: switcher.screen.width
        property int screen_height: switcher.screen.height

        property int container_width: screen_width * 0.125
        property int container_height: screen_height * 0.125
        property int border_radius: container_width * 0.05
        property int border_width: screen_height * 0.0025
        property int padding: container_height * 0.115


        property int switcherPosition: 0

        //Worker
        WorkerScript {
            id: switcherWorker
            source: 'switcherWorker.js'

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
                const split_class = app_class.split('.')
                search_icon(split_class[split_class.length-1])
                return icon
            }

            onMessage: (message) => {
                switch(message.message){
                    case "update_position":
                        switcher.switcherPosition = message.data
                        break
                    case "update_clients":
                        grid.children.forEach(children => children.destroy())
                        let thumbnails = ToplevelManager.toplevels.values
                        message.data.forEach((client, index) => {
                            const new_preview = windowPreviewComponent.createObject(grid);
                            new_preview.index = index
                            new_preview.pid = client.pid
                            new_preview.title = client.initialTitle
                            new_preview.icon = query_icon(client.class, client.initialTitle)
                            thumbnails.forEach((thumbnail, index) => {
                                if(thumbnail.appId == client.class && thumbnail.title == client.title){
                                    new_preview.thumbnail = thumbnail
                                    thumbnails[index] = null
                                    return
                                }
                            })
                        })
                }
            }
        }

        //Processes
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

        //Listeners
        Component.onCompleted: {
            Hyprland.rawEvent.connect((event) => {
                switch(event.name){
                    case 'activewindow':
                        fetchClients.running = true
                        break
                }
            })
        }

        IpcHandler { //Request Handler
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





        //UI
        Component {
            id: windowPreviewComponent

            Rectangle { //Window Preview | Container for App Info and thumbnail
                id: windowPreview

                property int index: 0
                property int pid: 0
                property string title: "title"
                property string icon: "placeholder"
                property QtObject thumbnail: null
                property color border_color: index === switcher.switcherPosition ? Colors.primary : Colors.surface_container_highest
                property color text_color: index === switcher.switcherPosition ? Colors.primary : Colors.on_surface


                width: switcher.container_width
                height: switcher.container_height

                anchors.margins: switcher.border_width + switcher.padding
                radius: switcher.border_radius

                border.color: border_color
                border.width: switcher.border_width
                color: Colors.surface_container


                ScreencopyView { //Thumbnail
                    id: preview

                    anchors.fill: parent
                    anchors.margins: switcher.border_width

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {  // dont try to mask with preview or else it will crash :broken_heart:
                            width: preview.width
                            height: preview.height
                            radius: switcher.border_radius
                        }
                    }

                    paintCursor: true
                    smooth: true
                    live: true

                    captureSource: thumbnail

                    onStopped: {
                        console.log("oi")
                    }
                }

                Rectangle { //App info container

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: parent.height * 0.05
                    anchors.topMargin: parent.height * 0.05

                    width: row.width + switcher.padding
                    height: row.height + switcher.padding / 2
                    color: Colors.surface_container
                    border.width: switcher.border_width
                    border.color: Colors.surface_container_highest
                    radius: switcher.border_radius


                    RowLayout { //App info row
                        id: row
                        anchors.centerIn: parent
                        Layout.margins: switcher.padding

                        IconImage {
                            width: windowPreview.height * 0.15
                            height: windowPreview.height * 0.15
                            source: Quickshell.iconPath(icon)
                        }

                        StyledText{
                            font.pixelSize: windowPreview.height * 0.125
                            color: text_color
                            text: title.split("|")[0] //handling discord title being DISCORD | SERVER | CHANNEL

                        }
                    }
                }
            }
        }


        Rectangle { //Grid Container, used for background and padding
            id: grid_container
            width: grid.width + switcher.padding
            height: grid.height + switcher.padding
            radius: switcher.border_radius
            color: Colors.surface

            GridLayout { //Grid itself
                anchors.centerIn: parent
                id: grid
                columns: 3
            }
        }
    }
  }


