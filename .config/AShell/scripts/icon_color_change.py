import os
import subprocess
import math
from colormath.color_objects import sRGBColor, LabColor
from colormath.color_conversions import convert_color
import json

def split_hex_color(hex_color_raw):
    hex_split = []
    for i in range(0, len(hex_color_raw), 2):
       hex_color = hex_color_raw[i:i+2]
       hex_split.append(hex_color)

    print(f"Split hex color: {hex_split} \n")
    return hex_split

def hex_to_rgb(hex):
    #the letters in hex range from A-F, valuing from 10 - 15
    #the hex 0 - 9 range from 0 - 9.
    #to convert a hexadecimal to an rgb value, you need to do the following:
    #
    # from right to left in the hexadecimal, the values are multiplied in an ascending order starting with 16⁰
    #
    # Example:
    #
    # HEXADECIMAL: #FAB
    # the first digit, A, is going to be multiplied by 16⁰
    # the second digit, F, is going to be multiplied by 16¹
    # the third digit, B, is going to be multiplied by 16²
    #
    # IMPORTANT!
    # --remember that any number raised to the power of 0 is 1
    # --remember that any number raised to the power of 1 is itself. (16¹ = 16)
    # --remember that jteh values are multiplied from RIGHT to LEFT
    #
    #
    #
    # B is valued at 11, so:
    # 11 * 1 = 11
    #
    # A is valued at 10, so:
    # 10 * 16 = 160
    #
    # F is valued at 15, so:
    # 15 * 256 = 3840
    #
    # F + A + B = result
    # 3840 + 160 + 11 = 4011
    #
    # The hexadecimal #FAB has the value of 4011
    #

    hex_letter_table = {
        'a': 10,
        'b': 11,
        'c': 12,
        'd': 13,
        'e': 14,
        'f': 15,
        'A': 10,
        'B': 11,
        'C': 12,
        'D': 13,
        'E': 14,
        'F': 15
    }

    inverse_counter = 0 # used to calculate the place value in hexadecimal
    rgb_value = 0

    for i in range(len(hex), 0, -1):
        hex_decimal_value = 0

        try:
            hex_decimal_value = int(hex[i-1:i])
        except ValueError:
            hex_decimal_value = hex_letter_table.get(hex[i-1:i])

        rgb_value+= hex_decimal_value * (16**(inverse_counter))
        inverse_counter+=1

    print(f"rgb_value for {hex}: {rgb_value}")
    return rgb_value

def lab_color_distance(lab1, lab2, kL=1, kC=1, kH=1):
    # CHATGPT CODE. Note to self: Study math more cuz i didnt understand how the math expression behind DeltaE of two lab colors worked and had to ask chatgpt.

    L1, a1, b1 = lab1.get_value_tuple()
    L2, a2, b2 = lab2.get_value_tuple()

    # Step 1: Calculate C1 and C2
    C1 = math.sqrt(a1**2 + b1**2)
    C2 = math.sqrt(a2**2 + b2**2)

    # Step 2: Compute the average C
    C_bar = (C1 + C2) / 2

    # Step 3: Compute G
    G = 0.5 * (1 - math.sqrt((C_bar**7) / (C_bar**7 + 25**7)))

    # Step 4: Adjusted a values
    a1_prime = a1 * (1 + G)
    a2_prime = a2 * (1 + G)

    # Step 5: Compute C' and h'
    C1_prime = math.sqrt(a1_prime**2 + b1**2)
    C2_prime = math.sqrt(a2_prime**2 + b2**2)

    h1_prime = math.atan2(b1, a1_prime) % (2 * math.pi)
    h2_prime = math.atan2(b2, a2_prime) % (2 * math.pi)

    # Step 6: Compute delta L', delta C', delta H'
    delta_L_prime = L2 - L1
    delta_C_prime = C2_prime - C1_prime

    delta_h_prime = h2_prime - h1_prime
    if abs(delta_h_prime) > math.pi:
        delta_h_prime -= 2 * math.pi if delta_h_prime > 0 else -2 * math.pi

    delta_H_prime = 2 * math.sqrt(C1_prime * C2_prime) * math.sin(delta_h_prime / 2)

    # Step 7: Compute L', C', H'
    L_bar_prime = (L1 + L2) / 2
    C_bar_prime = (C1_prime + C2_prime) / 2

    h_bar_prime = (h1_prime + h2_prime) / 2
    if abs(h1_prime - h2_prime) > math.pi:
        h_bar_prime += math.pi if h_bar_prime < math.pi else -math.pi

    # Step 8: Compute T
    T = (1 - 0.17 * math.cos(h_bar_prime - math.radians(30)) +
            0.24 * math.cos(2 * h_bar_prime) +
            0.32 * math.cos(3 * h_bar_prime + math.radians(6)) -
            0.20 * math.cos(4 * h_bar_prime - math.radians(63)))

    # Step 9: Compute SL, SC, SH
    S_L = 1 + (0.015 * (L_bar_prime - 50)**2) / math.sqrt(20 + (L_bar_prime - 50)**2)
    S_C = 1 + 0.045 * C_bar_prime
    S_H = 1 + 0.015 * C_bar_prime * T

    # Step 10: Compute RT
    delta_theta = math.radians(60) * math.exp(-((h_bar_prime - math.radians(275)) / math.radians(25))**2)
    R_C = 2 * math.sqrt((C_bar_prime**7) / (C_bar_prime**7 + 25**7))
    R_T = -math.sin(2 * delta_theta) * R_C

    # Step 11: Compute Delta E 2000
    delta_E_00 = math.sqrt(
        (delta_L_prime / (kL * S_L))**2 +
        (delta_C_prime / (kC * S_C))**2 +
        (delta_H_prime / (kH * S_H))**2 +
        R_T * (delta_C_prime / (kC * S_C)) * (delta_H_prime / (kH * S_H))
    )

    return delta_E_00


with open('../config/colors.json', 'r') as file:
    data = json.load(file)
    hex_color_treated = data["source_color"][1: 7] # removing # from the hex

split_hex_color = split_hex_color(hex_color_treated) # pyright: ignore

input_color_rgb = tuple(hex_to_rgb(color) for color in split_hex_color) ; print("") # Stores the converted input color RGB

# Define available colors for Papirus Folders
folder_colors = {
    "black": (0, 0, 0),
    "blue": (0, 0, 255),
    "bluegrey": (96, 125, 139),
    "breeze": (255, 255, 200),
    "brown": (139, 69, 19),
    "carmine": (255, 0, 56),
    "cyan": (0, 255, 255),
    "darkcyan": (0, 139, 139),
    "deeporange": (255, 87, 34),
    "green": (0, 255, 0),
    "grey": (128, 128, 128),
    "indigo": (75, 0, 130),
    "magenta": (255, 0, 255),
    "nordic": (59, 66, 82),
    "orange": (255, 152, 0),
    "palebrown": (110, 76, 30),
    "paleorange": (255, 167, 38),
    "pink": (255, 128, 171),
    "red": (255, 0, 0),
    "teal": (0, 128, 128),
    "violet": (142, 36, 170),
    "white": (255, 255, 255),
    "yellow": (255, 255, 0),
}

color_distances = dict()

for folder_color in folder_colors:
    #print("_______________________________")

    #print(f"Comparing input color {input_color_rgb} to {folder_color} ({folder_colors[folder_color]}) \n")

    input_R = input_color_rgb[0]
    input_G = input_color_rgb[1]
    input_B = input_color_rgb[2]

    folder_R = folder_colors[folder_color][0]
    folder_G = folder_colors[folder_color][1]
    folder_B = folder_colors[folder_color][2]

    input_color_srgb = sRGBColor(input_R/255, input_G/255, input_B/255);
    folder_color_srgb = sRGBColor(folder_R/255, folder_G/255, folder_B/255);
    #print(F"input_color_srgb: {input_color_srgb}")
    #print(F"folder_color_srgb: {folder_color_srgb} \n")

    input_color_lab = convert_color(input_color_srgb, LabColor)
    folder_color_lab = convert_color(folder_color_srgb, LabColor)
    #print(f"Comparing input_color_lab ({input_color_lab}) to {folder_color} (lab) ({folder_color_lab})")

    color_distance = lab_color_distance(input_color_lab, folder_color_lab);

    color_distances[folder_color] = color_distance

    #print(f"\nDistance: {color_distance})")


#print("_______________________________ \n")
least_different_color = min(color_distances.items(), key=lambda x: x[1])
print(f"Most equal color is: {least_different_color[0]} with a difference of {least_different_color[1]}")

#Set folder color. Popen is used here because papirus-folders takes a little bit to change folder color.
subprocess.Popen(["papirus-folders", "--color", least_different_color[0]])

#Refresh gtk colors
subprocess.run(["/usr/bin/gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", "''"])

subprocess.run(["/usr/bin/gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", "Material"])
