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

Replace the EFI folder on your USB installer with the provided `EFI/` directory. Ensure the structure matches the [EFI Directory Structure](../README.md#-efi-directory-structure).

**Important:** For installation, rename `recovery_config.plist` to `config.plist`:

```bash
cd /Volumes/EFI/EFI/OC
mv config.plist config_production.plist.bak
mv recovery_config.plist config.plist
```

The recovery config includes:
- Verbose boot output for troubleshooting
- Debug logging enabled
- Relaxed security settings for installation
- Basic graphics configuration

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

**Critical Settings (Required):**
- Sleep mode → **Linux** (Power section)
- Secure Boot → **Disabled** (Security section - clear all keys if needed)
- Vt-d → **Disabled** (Virtualization section - or enable DisableIOMapper quirk)
- Enhanced Windows Biometrics → **Disabled** (Virtualization section)
- Intel SGX → **Disabled** (IO Ports section)
- Device Guard → **Disabled** (IO Ports section)
- UEFI/Legacy → **UEFI** (Startup section)
- CSM Support → **Disabled** (Startup section)

**Recommended Settings:**
- Wake-on-LAN → Disabled
- UEFI network stack → Disabled
- Thunderbolt BIOS Assist mode → Disabled
- Thunderbolt Security → Disabled
- Thunderbolt Preboot → Disabled
- Intel AMT → Disabled
- Fingerprint predesktop → Disabled
- Kernel DMA → Disabled
- Disable unused devices (WWAN, fingerprint if macOS-only)

**Important Notes:**
- **CFG Lock**: Cannot be disabled in standard BIOS menu. This EFI uses `AppleXcpmCfgLock = True` quirk as a workaround. See [Hardware Guide](hardware.md#-cfg-lock-status) for details.

> For complete BIOS configuration details, see **[Hardware Compatibility Guide](hardware.md#-bios-configuration)**

---

### 6. Boot & Install

1. Boot from USB using OpenCore picker
2. Install macOS Ventura
3. After installation, mount the system SSD EFI and copy the EFI folder
4. **Switch to production config:**

```bash
cd /Volumes/EFI/EFI/OC
mv config.plist recovery_config.plist
mv config_production.plist.bak config.plist
```

The production config provides:
- Optimized boot settings (no verbose output)
- Hibernation support enabled
- Enhanced security settings
- Full graphics acceleration with advanced framebuffer patches

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
