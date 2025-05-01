#!/bin/bash

# Установка Ktoya с автоматической очисткой
set -e  # Выход при ошибках

# Параметры
INSTALL_DIR="$HOME/ktoya"
VENV_DIR="$INSTALL_DIR/venv"
MODEL_DIR="$INSTALL_DIR/models/vosk-model-small-ru"

# Очистка предыдущей установки
echo -e "\033[1;33m=== Очистка предыдущей установки ===\033[0m"
if [ -d "$INSTALL_DIR" ]; then
    echo "Удаление директории $INSTALL_DIR..."
    rm -rf "$INSTALL_DIR"
fi

# Создание чистой директории
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Клонирование репозитория (если нужно)
if [ ! -f "main.py" ]; then
    echo -e "\n\033[1;34m=== Клонирование репозитория ===\033[0m"
    git clone https://github.com/neodelux/ktoya.git .
fi

# Установка системных зависимостей
echo -e "\n\033[1;34m=== Установка системных пакетов ===\033[0m"
sudo apt update
sudo apt install -y \
    python3-pip \
    python3-venv \
    python3-pyqt5 \
    python3-pyaudio \
    libportaudio2 \
    wget \
    unzip \
    python3-full

# Создание виртуального окружения
echo -e "\n\033[1;34m=== Настройка Python окружения ===\033[0m"
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

# Установка Python-пакетов
echo -e "\n\033[1;34m=== Установка зависимостей Python ===\033[0m"
pip install --upgrade pip
pip install \
    vosk \
    requests \
    sounddevice \
    torch torchaudio \
    pyyaml \
    pyttsx3

# Загрузка моделей Vosk
echo -e "\n\033[1;34m=== Загрузка моделей ===\033[0m"
mkdir -p "$MODEL_DIR"
if [ ! -f "$MODEL_DIR/am-final.mdl" ]; then
    echo "Скачивание модели Vosk..."
    wget -O /tmp/vosk-model.zip \
        https://alphacephei.com/vosk/models/vosk-model-small-ru-0.22.zip
    unzip /tmp/vosk-model.zip -d "$MODEL_DIR"
    rm /tmp/vosk-model.zip
fi

# Установка Silero TTS
echo -e "\n\033[1;34m=== Установка Silero TTS ===\033[0m"
pip install git+https://github.com/snakers4/silero-models

# Создание скрипта запуска
echo -e "\n\033[1;34m=== Создание скрипта запуска ===\033[0m"
cat > "$INSTALL_DIR/run.sh" <<EOL
#!/bin/bash
source "$VENV_DIR/bin/activate"
python3 "$INSTALL_DIR/main.py"
EOL

chmod +x "$INSTALL_DIR/run.sh"

# Завершение
echo -e "\n\033[1;32m✔ Установка завершена!\033[0m"
echo -e "Для запуска выполните:\n  cd $INSTALL_DIR && ./run.sh"
echo -e "Или просто:\n  $INSTALL_DIR/run.sh"
