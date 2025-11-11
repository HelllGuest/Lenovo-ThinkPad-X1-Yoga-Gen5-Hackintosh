# 🧭 Installation & Setup Guide – X1 Yoga Gen 5 Hackintosh

This guide explains how to install macOS Ventura 13.7.8 using the provided EFI configuration with **OpenCore 1.0.6**.

---

## 🔧 Prerequisites

- USB drive (16GB+)  
- macOS Ventura installer (`createinstallmedia`)  
- Access to macOS or a virtual machine for EFI preparation  
- Tools: [ProperTree](https://github.com/corpnewt/ProperTree) + [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

---

## 🚀 Installation Steps

### 1. Create macOS Installer

Open Terminal and run:

```bash
sudo /Applications/Install\ macOS\ Ventura.app/Contents/Resources/createinstallmedia --volume /Volumes/MyUSB
````

---

### 2. Mount EFI Partition

Identify EFI partition:

```bash
diskutil list
sudo diskutil mount /dev/diskXs1
```

---

### 3. Copy EFI

Replace the EFI folder on your USB installer with the provided `EFI/` directory. Ensure the structure is:

```
EFI/
├── BOOT/
└── OC/
```

---

### 4. Configure Serial Numbers

Run **GenSMBIOS** to generate unique serials:

```bash
GenSMBIOS.command
# Recommended SMBIOS: MacBookPro16,3
```

Update your `config.plist` with generated **Serial, MLB, and ROM** values.

---

### 5. BIOS Settings

**Required Settings (Bold):**

* **Config**
  * Network
    * Wake-on-LAN → Disabled (recommended)
    * UEFI network stack → Disabled (recommended)
* **Power**
  * Sleep mode → **Linux** (required)
* **Thunderbolt**
  * BIOS Assist mode → Disabled (recommended)
  * Security → Disabled (recommended)
  * Thunderbolt Preboot → Disabled (recommended)
  * Intel AMT → Disabled (recommended)
* **Security**
  * Fingerprint predesktop → Disabled (recommended)
  * Secure Boot → **Disabled** (required - clear all keys if needed)
* **Virtualization**
  * Kernel DMA → Disabled (recommended)
  * Vt-d → **Disabled** (required - or enable DisableIOMapper quirk)
  * Enhanced Windows Biometrics → **Disabled** (required)
* **IO Ports**
  * Disable unused devices (WWAN, fingerprint if macOS-only)
  * Intel SGX → **Disabled** (required)
  * Device Guard → **Disabled** (required)
* **Startup**
  * UEFI/Legacy → **UEFI** (required)
  * CSM Support → **Disabled** (required)

**Important Notes:**
- **CFG Lock**: Not accessible in standard BIOS menu (requires engineering menu)
- Standard methods (modified GRUB, RU) do not work on this model
- Direct BIOS write with programmer clip is possible but dangerous (breaks TPM)
- This EFI uses `AppleXcpmCfgLock = True` quirk to work around locked CFG

---

### 6. Boot & Install

1. Boot from USB using OpenCore picker
2. Install macOS Ventura
3. After installation, mount the system SSD EFI and copy the EFI folder

---

### 7. Post-Install Optimization

* Rebuild kext cache:

```bash
sudo kextcache -i /
```

* Reset NVRAM
* Verify sleep/wake, battery, Wi-Fi, and trackpad functionality
* Adjust `config.plist` if using non-standard peripherals

---

### 8. Recommended Tools

* **ProperTree** – For editing `config.plist`
* **OpenCore Configurator** – Optional GUI for plist tweaks
* **MaciASL** – Editing or compiling SSDTs
* **Hackintool** – Checking USB mapping, audio, and sensor data

---

### 🔗 Related Documentation

* [Hardware Details](hardware.md)
* [ACPI Overview](acpi.md)
* [Config Reference](config_reference.md)
* [Troubleshooting Guide](troubleshooting.md)
* [Changelog](../CHANGELOG.md)
