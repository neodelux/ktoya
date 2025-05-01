#!/bin/bash

# Установка зависимостей для Ktoya
set -e  # Автоматически завершать скрипт при ошибках

echo -e "\033[1;34m=== Установка системных зависимостей ===\033[0m"
sudo apt update
sudo apt install -y \
    python3-pip \
    python3-pyqt5 \
    python3-venv \
    python3-pyaudio \
    libportaudio2 \
    wget \
    unzip

echo -e "\n\033[1;34m=== Установка Python-пакетов ===\033[0m"
pip3 install --upgrade \
    vosk \
    requests \
    sounddevice \
    torch torchaudio \
    pyyaml \
    pyttsx3

echo -e "\n\033[1;34m=== Настройка моделей Vosk ===\033[0m"
MODEL_DIR="models/vosk-model-small-ru"
mkdir -p "$MODEL_DIR"

if [ ! -f "$MODEL_DIR/am-final.mdl" ]; then
    echo "Загрузка модели Vosk (русский)..."
    wget -O /tmp/vosk-model-small-ru.zip \
        https://alphacephei.com/vosk/models/vosk-model-small-ru-0.22.zip
    unzip /tmp/vosk-model-small-ru.zip -d "$MODEL_DIR"
    rm /tmp/vosk-model-small-ru.zip
else
    echo "Модель Vosk уже установлена, пропускаем загрузку."
fi

echo -e "\n\033[1;34m=== Установка Silero TTS ===\033[0m"
pip3 install git+https://github.com/snakers4/silero-models

echo -e "\n\033[1;32m✔ Установка завершена успешно!\033[0m"
echo "Для запуска проекта выполните: python3 main.py"
