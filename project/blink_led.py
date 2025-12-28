import RPi.GPIO as GPIO
import time

try:
    pin = int(input("Enter a valid pin no. (0-27): "))
    if not 0 <= pin <= 27:
        print("❌ Invalid pin number. Valid range: 0-27")
        exit(1)
    
    LED_PIN = pin
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(LED_PIN, GPIO.OUT)
    
    print("Blinking LED. Press Ctrl+C to stop.")
    while True:
        GPIO.output(LED_PIN, GPIO.HIGH)
        time.sleep(1)
        GPIO.output(LED_PIN, GPIO.LOW)
        time.sleep(1)
except KeyboardInterrupt:
    print("✅ Cleanup complete.")
except ValueError:
    print("❌ Please enter a valid integer.")
except Exception as e:
    print(f"❌ Error: {e}")
finally:
    GPIO.cleanup()
