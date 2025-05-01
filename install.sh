
---

## 2. `install.sh` — скрипт установки зависимостей

```bash
#!/bin/bash

echo "Установка зависимостей..."

sudo apt update
sudo apt install -y python3-pip python3-pyqt5 python3-venv python3-pyaudio libportaudio2

pip3 install vosk requests sounddevice torch torchaudio pyyaml pyttsx3

echo "Создание папки models..."
mkdir -p models

echo "Загрузка модели Vosk (русский)..."
wget -O models/vosk-model-small-ru.zip https://alphacephei.com/vosk/models/vosk-model-small-ru-0.22.zip
unzip models/vosk-model-small-ru.zip -d models/vosk-model-small-ru

echo "Установка Silero TTS..."
pip3 install git+https://github.com/snakers4/silero-models

echo "Готово!"
