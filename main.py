import json
import subprocess
from modules import commands, gui, stt, tts, ai

CONFIG = json.load(open("config.json"))

def run_command(text):
    print(f"[Вы]: {text}")
    response = commands.handle(text)
    if not response:
        response = ai.ask(text)
    print(f"[Кто Я]: {response}")
    if CONFIG["voice_enabled"]:
        tts.speak(response)

if __name__ == "__main__":
    print("Кто Я запущен. Говорите 'выход' для завершения.")
    while True:
        try:
            text = input("Вы: ").strip()
            if text.lower() in ["выход", "exit"]:
                break
            run_command(text)
        except KeyboardInterrupt:
            break
