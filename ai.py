import requests

def ask(prompt):
    url = "http://localhost:11434/api/generate"
    data = {
        "model": "mistral",
        "prompt": prompt
    }
    try:
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return response.json().get("response", "Ошибка ответа ИИ.")
        else:
            return "Не могу связаться с ИИ."
    except Exception as e:
        return f"Ошибка: {e}"
