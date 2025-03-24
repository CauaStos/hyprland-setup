import os
import sys
import subprocess
import math
from colormath.color_objects import sRGBColor, LabColor
from colormath.color_conversions import convert_color
from colorthief import ColorThief



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

def print_colored_cell(rgb, size=1):
    r, g, b = rgb
    cell = f"\033[48;2;{r};{g};{b}m  \033[0m"  # ANSI background color
    for _ in range(size):
        print(cell * size)


base_colors = {
    "black": (0, 0, 0),
    "white": (255, 255, 255),
}

wallpaper_path = os.path.expanduser(sys.argv[1])
color_theme = sys.argv[2]
color_thief = ColorThief(wallpaper_path)
# get the dominant color
input_colors = color_thief.get_palette(2, 100)

for color in input_colors:
    print_colored_cell(color)


color_distances = dict()

for color in base_colors:
    for i in range(2):
        input_R = input_colors[i][0]
        input_G = input_colors[i][1]
        input_B = input_colors[i][2]

        color_R = base_colors[color][0]
        color_G = base_colors[color][1]
        color_B = base_colors[color][2]

        input_color_srgb = sRGBColor(input_R/255, input_G/255, input_B/255);
        color_srgb = sRGBColor(color_R/255, color_G/255, color_B/255);

        input_color_lab = convert_color(input_color_srgb, LabColor)
        color_lab = convert_color(color_srgb, LabColor)
        color_distance = lab_color_distance(input_color_lab, color_lab);

        color_distances[color + f"{i}"] = color_distance


#black0 and white0 is the first color of the palette
#black1 and white1 is the second color of the palette
print(f"COLORS DISTANCES: black:{color_distances['black0']}, white:{color_distances["white1"]} ")
if color_distances["black0"] < 10 or color_distances["white1"] < 10:
    print("Monochrome wallpaper detected! Applying 'scheme-fidelity'")
    subprocess.run(["matugen","-t", "scheme-fidelity", "color", "rgb", f"rgb{input_colors[0]}", "-m", color_theme], check=True)
else:
    print("Colorful wallpaper detected! Applying 'tonal-spot'")
    subprocess.run(["matugen", "image", wallpaper_path, "-m", color_theme], check=True)
    print(["matugen", "image", wallpaper_path, "-m", color_theme])

#Apply changes (icons + wallpaper transition)
subprocess.run(["python", "./icon_color_change.py"], check=True)
subprocess.run(["swww", "img", wallpaper_path, "--transition-step", "10", "--transition-fps", "144"], check=True)
