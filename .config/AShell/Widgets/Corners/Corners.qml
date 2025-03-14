import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../globals/components/"
import "../../config/"


Scope {
    Variants{
        model: Quickshell.screens
        delegate: Component{
            PanelWindow {
                id: corners

                property var modelData
                screen: modelData


                anchors {
                    top: true
                    left: true
                    right: true
                    bottom: true
                }
                mask: Region { //Allowing mouse events to pass below to other windows
                    item: canvas;
                    intersection: Intersection.Xor
                }

                color: 'transparent'

                Canvas {
                    id: canvas
                    anchors.fill: parent
                    onPaint: {
                            var ctx = getContext("2d");
                            var width = this.width;
                            var height = this.height;
                            var radius = 10;

                            ctx.lineWidth = 1;
                            ctx.fillStyle = Colors.alpha_color(Colors.surface, 0.95);  // Outer fill color

                            // Start drawing the outer shape
                            ctx.beginPath();

                            // Upper-left corner
                            ctx.moveTo(0, radius);
                            ctx.arc(radius, radius, radius, Math.PI, Math.PI * 1.5);
                            ctx.lineTo(0, 0);

                            // Upper-right corner
                            ctx.moveTo(width, 0);
                            ctx.arc(width - radius, radius, radius, -0.5 * Math.PI, 0);
                            ctx.lineTo(width, radius);

                            // Bottom-left corner
                            ctx.moveTo(0, height);
                            ctx.arc(0 + radius, height - radius, radius, Math.PI * 0.5, Math.PI);
                            ctx.lineTo(0, height);

                            // Bottom-right corner
                            ctx.moveTo(width, height);
                            ctx.arc(width - radius, height - radius, radius, 0 * Math.PI, Math.PI * 0.5);
                            ctx.lineTo(width, height);

                            // Fill
                            ctx.fill();
                            //Don't stroke, it will not blend nicely.
                        }
                    Component.onCompleted: {
                        Colors.colorsChanged.connect(() => {
                            canvas.requestPaint()
                        })
                    }
                }
            }
        }
    }
}
