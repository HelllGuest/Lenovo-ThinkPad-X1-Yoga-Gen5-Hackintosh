<p align="center">
  <img src="./docs/assets/banner.svg" width="600" alt="Lenovo X1 Yoga Gen 5 Hackintosh Banner">
</p>

<p align="center">
  <a href="https://github.com/HelllGuest/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh/releases">
    <img src="https://img.shields.io/badge/macOS-Ventura_13.7.8-orange?style=for-the-badge&logo=apple" />
  </a>
  <a href="https://github.com/acidanthera/OpenCorePkg">
    <img src="https://img.shields.io/badge/OpenCore-1.0.6-blue?style=for-the-badge&logo=hack-the-box" />
  </a>
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />
  </a>
  <a href="https://github.com/HelllGuest/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh/commits/main">
    <img src="https://img.shields.io/github/last-commit/HelllGuest/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh?style=for-the-badge" />
  </a>
</p>

# 💻 Lenovo ThinkPad X1 Yoga Gen 5 Hackintosh

EFI configuration for macOS **Ventura 13.7.8** using **OpenCore 1.0.6**, optimized for the ThinkPad X1 Yoga Gen 5 (20UCS33G00).  
Stable, power-efficient, and close to native macOS experience.

---

### 📖 Documentation

- [Hardware Specifications](./docs/hardware.md)
- [ACPI Overview](./docs/acpi.md)
- [Config Reference](./docs/config_reference.md)
- [Troubleshooting Guide](./docs/troubleshooting.md)
- [Changelog](./CHANGELOG.md)

---

## 🖥️ Hardware Specifications

| Component | Details | Status |
|-----------|---------|--------|
| **Model** | Lenovo ThinkPad X1 Yoga Gen 5 (20UCS33G00) | ✅ Fully Supported |
| **CPU** | Intel Core i7-10610U (Comet Lake-U) | ✅ Native Power Management |
| **Graphics** | Intel UHD Graphics (GT2, 24 EUs) | ✅ Hardware Acceleration |
| **Memory** | 16GB LPDDR3-2133 (soldered) | ✅ Fully Compatible |
| **Storage** | NVMe SSD (various capacities) | ✅ Native Support + Optimization |
| **Display** | 14" 1920x1080 IPS Touchscreen | ✅ Full Resolution + Brightness Control |
| **WiFi** | Intel Wi-Fi 6 AX201 160MHz (soldered) | ✅ Native-like Experience |
| **Bluetooth** | Intel AX201 Bluetooth 5.1 | ✅ Full LE Support |
| **Audio** | Realtek ALC285 codec | ✅ All Outputs Working |
| **Ports** | 2x USB-C/TB3, 2x USB-A, HDMI | ✅ All Functional |

> For detailed hardware compatibility information, see **[Hardware Compatibility Guide](./docs/hardware.md)**

---

## 🧩 Build Information

| Parameter | Value |
|------------|--------|
| **macOS Version** | Ventura 13.7.8 (22G720) |
| **OpenCore Version** | 1.0.6 (ACDT 2025-10) |
| **EFI Revision** | 1.0.6-stable |
| **SMBIOS** | MacBookPro16,3 |
| **BIOS Version** | 1.40 (CFG Lock cannot be disabled - see [Hardware Guide](./docs/hardware.md#-cfg-lock-status)) |
| **Bootloader Mode** | UEFI (Secure Boot Off) |
| **FileVault** | Enabled |
| **Tested On** | Lenovo ThinkPad X1 Yoga Gen 5 (20UCS33G00) |

---

## ⚙️ EFI Directory Structure

```
EFI/
├── BOOT/
│   └── BOOTx64.efi
└── OC/
    ├── ACPI/
    ├── Drivers/
    ├── Kexts/
    ├── config.plist
    ├── recovery_config.plist
    └── OpenCore.efi
```

### Configuration Files

- **config.plist**: Production configuration for daily use with optimized settings, hibernation support, and minimal debug output
- **recovery_config.plist**: Installation/recovery configuration with verbose boot, debugging enabled, and relaxed security settings

> Reference: **[Full Config Breakdown](./docs/config_reference.md)**

---

## ✅ What Works

- CPU Power Management  
- Graphics Acceleration (Metal + OpenGL)  
- Audio System (Layout ID 71)  
- Sleep/Wake & Battery Management  
- Wi-Fi + Bluetooth (AX201)  
- Trackpad & TrackPoint Multi-Touch  
- Backlight & Function Keys via YogaSMC  
- FileVault & iServices  
- Thunderbolt 3 controller (DisplayPort works, advanced features untested)  

---

## ⚠️ Known Limitations

- **Touchscreen**: Basic touch only (no multi-touch gestures)
- **Fingerprint Reader**: Unsupported in macOS
- **Thunderbolt 3**: Controller visible, DisplayPort works, but advanced hotplug untested
  - External displays via TB3/USB-C work
  - eGPU and other TB3 devices require testing
  - Optional SSDT-TB.aml available but not included by default
- **Some function keys**: May need remapping via YogaSMC

> For detailed Thunderbolt 3 support information, see **[Hardware Compatibility Guide](./docs/hardware.md#-thunderbolt-3-support)**  

---

## 🧰 Maintenance & Updates

### Updating Kexts
- Use [Kext Updater](https://www.sl-soft.de/kext-updater/) or [OCAT](https://github.com/ic005k/OCAuxiliaryTools)
- Keep Lilu, WhateverGreen, VirtualSMC, AppleALC up to date
- Update AirportItlwm when updating macOS version

### Config.plist Editing
- Use [ProperTree](https://github.com/corpnewt/ProperTree) for safe editing
- Follow [Dortania OpenCore Guide](https://dortania.github.io/OpenCore-Install-Guide/) for updates
- Always backup working EFI before changes

### BIOS Updates
- **Current tested:** 1.40
- Check [Lenovo Support](https://pcsupport.lenovo.com/) for updates
- Backup EFI before BIOS update
- Verify BIOS settings after update

### Reference
- **[CHANGELOG.md](./CHANGELOG.md)** for version history
- **[Config Reference](./docs/config_reference.md)** for detailed settings  

---

## 🧠 Credits & Acknowledgements

### Core Development
- **[Dortania](https://dortania.github.io/OpenCore-Install-Guide/)** – OpenCore Install Guide
- **[Acidanthera](https://github.com/acidanthera)** – OpenCore, Lilu, WhateverGreen, AppleALC, VirtualSMC, and more
- **[OpenIntelWireless](https://github.com/OpenIntelWireless)** – AirportItlwm, IntelBluetoothFirmware

### ThinkPad Community
- **[AlexFullmoon](https://github.com/AlexFullmoon/thinkpad-x1-yoga-5-hack)** – Original X1 Yoga Gen 5 project
- **[jsassu20](https://github.com/jsassu20/OpenCore-HotPatching-Guide)** – ACPI hotpatching guide
- **[tylernguyen](https://github.com/tylernguyen/x1c6-hackintosh)** – X1 Carbon reference
- **[Jamesxxx1997](https://github.com/Jamesxxx1997/thinkpad-x1-yoga-2018-hackintosh)** – X1 Yoga 2018 reference
- **Baio77** from [OSXLatitude](https://osxlatitude.com/) – ThinkPad ACPI expertise

### Kext Authors
- **[1Revenger1](https://github.com/1Revenger1/ECEnabler)** – ECEnabler
- **[zhen-zen](https://github.com/zhen-zen/YogaSMC)** – YogaSMC
- **[RehabMan](https://github.com/RehabMan)** – VoodooPS2Controller foundation
- **[VoodooI2C Team](https://github.com/VoodooI2C/VoodooI2C)** – VoodooI2C
- **[Mieze](https://github.com/Mieze/IntelMausiEthernet)** – IntelMausi

### Special Thanks
- ThinkPad Hackintosh community for testing and feedback
- All contributors to the Hackintosh ecosystem  

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

Based on the original work by [AlexFullmoon](https://github.com/AlexFullmoon/thinkpad-x1-yoga-5-hack).

---

## 🔗 Repository

**GitHub:** [https://github.com/HelllGuest/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh](https://github.com/HelllGuest/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh)

**Issues & Support:** [GitHub Issues](https://github.com/HelllGuest/Lenovo-ThinkPad-X1-Yoga-Gen5-Hackintosh/issues)

---

⭐ **If this helped you, please consider starring the repository!**