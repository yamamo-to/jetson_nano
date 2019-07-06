import cv2
import time
from threading import Lock


class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = \
                super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instances[cls]


class Camera(metaclass=Singleton):
    def __init__(self, source, width, height):
        self._read_lock = Lock()
        self.cap = cv2.VideoCapture(source)
        self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, width)
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, height)

    def read(self, sleep_in_sec):
        self._read_lock.acquire()
        result = self.cap.read()
        time.sleep(sleep_in_sec)
        self._read_lock.release()
        return result

    def read_in_jpeg(self, sleep_in_sec):
        ret, frame = self.read(sleep_in_sec)
        if not ret:
            return None
        ret, jpg = cv2.imencode(".jpg", frame)
        if not ret:
            return None
        return jpg

    def is_opened(self):
        return self.cap.isOpened()

    def release(self):
        self.cap.release()
