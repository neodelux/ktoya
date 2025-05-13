import os
import webbrowser
import subprocess
import glob

def handle(command):
    command = command.lower()

    if "открой браузер" in command:
        webbrowser.open("https://google.com")
        return "Открываю браузер."

    elif "открой ютуб" in command or "открой youtube" in command:
        webbrowser.open("https://youtube.com")
        return "Открываю YouTube."

    elif "выключи компьютер" in command:
        subprocess.run(["shutdown", "now"])
        return "Выключаю компьютер."

    elif "перезагрузи wi-fi" in command:
        subprocess.run(["nmcli", "radio", "wifi", "off"])
        subprocess.run(["nmcli", "radio", "wifi", "on"])
        return "Wi-Fi перезагружен."

    elif "найди pdf" in command:
        files = glob.glob("~/Documents/*.pdf", recursive=True)
        return f"Нашёл PDF-файлов: {len(files)}"

    else:
        return None
