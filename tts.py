import torch
import sounddevice as sd
import yaml

def speak(text):
    with open("config.json") as f:
        config = yaml.safe_load(f)

    language = config.get("language", "ru")
    speaker = "baya" if language == "ru" else "en_0"

    device = torch.device("cpu")
    torch.set_num_threads(4)

    model, example_text = torch.hub.load(
        repo_or_dir='snakers4/silero-models',
        model='silero_tts',
        language=language,
        speaker=f'{speaker}_9000'
    )
    model.to(device)

    audio = model.apply_tts(text=text, speaker=speaker, sample_rate=48000)
    sd.play(audio.numpy(), samplerate=48000)
    sd.wait()
