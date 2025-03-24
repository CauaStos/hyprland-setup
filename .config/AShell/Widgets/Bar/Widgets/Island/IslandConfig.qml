pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../../globals/components/"
import "../../../../config/"
import "../../"
import "./Components/"

Singleton {
    id: islandConfig

    //State
    property var islandRequest: new Set(["Idle"])
    property int islandState: 0
    property bool isWidgetOpen: false

    //Variables
    property int bar_island_width: 0
    property int island_size: BarConfig.container_height * 0.9; //minimum island size


    //Functions
    function remove_request(request){
        islandRequest.remove(request)
        islandRequest = islandRequest
    }

    function pop_request(){
        let requests = [...islandRequest]
        requests.pop()
        islandRequest = new Set(requests)
    }

    function request(request){
        let requests = [...islandRequest]
        requests.push(request)
        islandRequest = new Set(requests)
    }

    //Listeners

    onIslandRequestChanged: {
        const requests = [...islandRequest]
        const last_request = requests[requests.length-1]
        switch(last_request){
            case "Idle":
                islandState = 0
                isWidgetOpen = false
                break
            case "Player":
                islandState = 1
                isWidgetOpen = false
                break
            case "Launcher":
                islandState = 2
                isWidgetOpen = true
                break
        }
    }
}

/*

    when updating the islandRequest:
        IslandConfig.islandRequest.push("Launcher")
        IslandConfig.islandRequest = IslandConfig.islandRequest //Doing this because qt is... dumb? Pushing an item in an array doesnt trigger changed signal...
*/
