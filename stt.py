from vosk import Model, KaldiRecognizer
import pyaudio

def listen():
    model = Model(model_path="models/vosk-model-small-ru")
    rec = KaldiRecognizer(model, 16000)

    p = pyaudio.PyAudio()
    stream = p.open(format=pyaudio.paInt16, channels=1, rate=16000, input=True, frames_per_buffer=8000)
    stream.start_stream()

    print("Слушаю...")
    while True:
        data = stream.read(4000, exception_on_overflow=False)
        if rec.AcceptWaveform(data):
            result = rec.Result()
            return result["text"]
