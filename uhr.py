
from neopixel import NeoPixel
import ntptime
from machine import Pin, I2C, RTC
import time
import dht
from esp8266_i2c_lcd import I2cLcd

class leduhr:

  wallinfo = {"temp":"","humi":"","express":"","exhumi":"","extemp":""}
  wtage = ("Mo","Di","Mi","Do","Fr","Sa","So")
  timezome = 1
    
  def __init__(self):
    #d7 = io13
    pin = Pin(13, Pin.OUT)
    self.np = NeoPixel(pin, 60) 
    self.rtc = RTC()
    # dht sensor d6 = io12
    self.th = dht.DHT22(Pin(12))
    #I2c
    i2c = I2C(scl=Pin(5),sda=Pin(4),freq=100000)
    #lcd 2 * 16 adr 0x27
    self.lcd = I2cLcd(i2c, 0x27, 2, 16)
    #d3 input pulled high
    self.stop = Pin(0,Pin.IN)
    #
    try:
      ntptime.settime()
    except:
      print("ntp fail")
      self.lcd.putstr("NTP Error")
  #init ende

  def show_werte(self) :
    self.lcd.putstr(self.wallinfo["temp"]+self.wallinfo["humi"])
  
  def get_mess(self):
    self.th.measure()
    self.wallinfo["temp"] = "%2.1fC " % (self.th.temperature())
    self.wallinfo["humi"] = "%2d%% " % (self.th.humidity())

  def get_config(self,datei):
    pass
  
  def zeitanzeige(self):
    self.zeit = self.rtc.datetime()
    self.wallinfo["weekday"] = self.wtage[self.zeit[3]]
    self.wallinfo["date"] = "%2d.%2d.%2d" % (self.zeit[2],self.zeit[1],self.zeit[0]-2000)
    #print(self.zeit)
    std = (self.zeit[4] % 12 * 5) + (self.zeit[5] // 12)
    ledtime = [std,self.zeit[5],self.zeit[6]]
    ledo = {ledtime[0]:[64,0,0]}
    if ledtime[1] in ledo:
      ledo[ledtime[1]][1] = 64
    else:
      ledo[ledtime[1]] = [0,64,0]   
    if ledtime[2] in ledo:
      ledo[ledtime[2]][2] = 64
    else:  
      ledo[ledtime[2]] = [0,0,64]  
    for px in ledo:
      self.np[px] = tuple(ledo[px])
    self.np.write()    
  
  def clr_all(self):
    for lo in range(60):
      self.np[lo] = (0,0,0)
    self.np.write()

    
  def test(self):
    while self.stop.value() == 1:
      self.clr_all()  
      self.zeitanzeige()
      if self.zeit[5] == 0:  #minute 0
        self.get_mess()
        self.show_werte()
      time.sleep(1)
    
