# 🖇️ Optional Peripherals & Upgrades – X1 Yoga Gen 5 Hackintosh

This guide details optional peripherals and external devices tested or known to work with the X1 Yoga Gen 5 Hackintosh setup.

---

## 🖥️ External Displays

| Device | Connection | Notes |
|--------|-----------|-------|
| 4K Monitor | HDMI | Works at 30Hz max, scaling supported |
| DisplayPort / USB-C | Thunderbolt 3 | Basic external display support, no hotplug eGPU acceleration by default |
| Multi-monitor setups | HDMI + TB3 | Requires manual arrangement in Display Preferences |

---

## 💻 Docking Stations

| Dock Model | Connection | Notes |
|------------|-----------|------|
| Lenovo Thunderbolt 3 Dock | TB3 | Limited hotplug support, USB peripherals work |
| Generic USB-C Dock | USB-C | Works for HDMI/USB, audio may need patching |

> **Tip:** Keep the dock powered and connected at boot for proper detection.

---

## 🖱️ Input Devices

| Device | Connection | Notes |
|--------|-----------|------|
| External Keyboard | USB / Bluetooth | Fully functional, FN keys may require remapping |
| External Mouse | USB / Bluetooth | Works out-of-the-box |

---

## 🔊 Audio Peripherals

| Device | Connection | Notes |
|--------|-----------|------|
| USB Headset | USB | Fully supported |
| Bluetooth Headphones | BT 5.1 | Works with AppleHDA/BlueToolFixup, occasional latency |

---

## ⚡ Storage & Networking

| Device | Connection | Notes |
|--------|-----------|------|
| External NVMe SSD | USB-C / TB3 | Bootable via OpenCore if properly formatted |
| USB Wi-Fi Adapter | USB 3.0 | Only Intel or macOS-native chipsets recommended |
| Ethernet Adapter | USB-C / USB-A | Intel I219-LM works via USB adapter, no drivers needed |

---

## 🛠️ Tips for Optional Upgrades

- Keep `USBMap.kext` updated if connecting multiple USB devices or hubs.  
- Thunderbolt 3 eGPUs are partially supported; check Apple Metal support and PCIe injection in `config.plist`.  
- For multi-monitor setups, prefer HDMI + TB3 combination to avoid macOS detection issues.  
- Back up your EFI before experimenting with peripheral hotplug.  

---

**Reference Links:**  
- [Dortania Hackintosh Guide – Peripherals](https://dortania.github.io/OpenCore-Install-Guide/ExternalPeripherals.html)  
- [ThinkPad Hackintosh Forum](https://forums.macrumors.com/threads/lenovo-x1-yoga-gen-5-hackintosh.2367891/)