from PyQt5.QtWidgets import QApplication, QWidget, QTextEdit, QPushButton, QLineEdit, QVBoxLayout
from PyQt5.QtGui import QFont
from PyQt5.QtCore import Qt

class ChatGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Кто Я — Ассистент")
        self.setStyleSheet("background-color: #1e1e1e; color: white;")
        layout = QVBoxLayout()

        self.chat_area = QTextEdit()
        self.chat_area.setReadOnly(True)
        self.chat_area.setFont(QFont("Arial", 12))

        self.input_line = QLineEdit()
        self.input_line.setPlaceholderText("Введите команду или задайте вопрос...")
        self.input_line.returnPressed.connect(self.send_input)

        layout.addWidget(self.chat_area)
        layout.addWidget(self.input_line)
        self.setLayout(layout)

    def send_input(self):
        text = self.input_line.text()
        self.chat_area.append(f"<font color='lightblue'>Вы:</font> {text}")
        self.input_line.clear()
        self.chat_area.append(f"<font color='lightgreen'>Кто Я:</font> ...")

app = QApplication([])
window = ChatGUI()
window.show()
app.exec_()
