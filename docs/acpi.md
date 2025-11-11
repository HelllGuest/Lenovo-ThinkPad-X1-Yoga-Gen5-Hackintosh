# ⚙️ ACPI Configuration – X1 Yoga Gen 5

## Directory Structure

```text
EFI/OC/ACPI/
├── SSDT-ALL.aml (enabled)
└── SSDT-TB.aml (disabled, optional)
```

**Note:** `SSDT-TB.aml` is present but not loaded by default. See [Hardware Documentation](hardware.md#optional-ssdt-tb-patch) for details.

## Patch Summary

This EFI uses a single combined SSDT-ALL.aml file that includes all necessary ACPI patches:

| Component      | Description               | Purpose                     |
| -------------- | ------------------------- | --------------------------- |
| _OSI Darwin    | OS detection              | Enables macOS-specific patches |
| PLUG (_DSM)    | CPU plugin-type           | Native CPU power management (PR00) |
| USBX           | USB power properties      | USB sleep/wake support (5100mA) |
| PNLF           | Backlight device          | Brightness control for Intel UHD 620 |
| ALS0           | Ambient light sensor      | SMC light sensor support |
| PWRB           | Power button              | Power button device |
| MCHC           | Memory controller         | System memory device |
| PGMM           | Gaussian Mixture Model    | Intel processor device |
| PMCR           | PMC resources             | Power management controller |
| SRAM           | Shared RAM                | System RAM device |
| XSPI           | SPI controller            | Hidden SPI device |
| BUS0/DVL0      | SMBus devices             | SMBus and diagnostics vault |
| DMAC           | DMA controller            | DMA device for macOS |
| HPET           | High precision timer      | IRQ 0,8,11 fixes |
| EC Patches     | Embedded controller       | Battery notifications, HKEY support |
| RHUB           | USB root hub              | Disabled for USBMap.kext |

### Key Features:
- **Darwin Detection**: All patches activate only when macOS is detected via `_OSI("Darwin")`
- **Backlight Support**: Automatic detection for Intel UHD 620 (device ID 0x9B3E)
- **EC Methods**: RECB/WECB for reading/writing EC fields larger than 8-bit
- **Battery**: Notification support for BAT1 device via NBAT method
- **HKEY**: ThinkPad hotkey support with OSYS=0x07DF for YogaSMC

---

## Technical Details

### _INI Method (Root Scope)
Sets critical variables when macOS is detected:
```
STAS = 1    // Status flag
TPDM = 0    // Trackpad mode
LNUX = 1    // Linux compatibility
WNTF = 1    // Windows flag
WIN8 = 1    // Windows 8+ flag
```

### PLUG Implementation
CPU power management via `_DSM` method on `\_SB.PR00`:
- Returns `plugin-type = 1` for native macOS power management
- Only active when Darwin is detected

### USBX Power Configuration
USB power delivery settings:
- `kUSBSleepPowerSupply`: 5100mA (0x13EC)
- `kUSBSleepPortCurrentLimit`: 2100mA (0x0834)
- `kUSBWakePowerSupply`: 5100mA (0x13EC)
- `kUSBWakePortCurrentLimit`: 2100mA (0x0834)

### PNLF Backlight Device
Intelligent backlight control:
- Auto-detects Intel UHD 620 (GDID)
- Configures brightness levels based on GPU model
- Supports multiple framebuffer types
- UID varies based on max brightness level

### EC Embedded Controller Patches
Custom methods for battery and sensor access:
- `RE1B(offset)`: Read 1 byte from EC
- `RECB(offset, length)`: Read multiple bytes from EC
- `WE1B(offset, value)`: Write 1 byte to EC
- `WECB(offset, length, data)`: Write multiple bytes to EC
- `NBAT()`: Notify battery status change
- ESEN region: Extended sensor data (0x78-0x7F, 0xC0-0xC7)

### HPET IRQ Fixes
Resolves IRQ conflicts:
- IRQ 0: Timer (TIMR)
- IRQ 8: RTC
- IRQ 11: Available for other devices
- Memory region: 0xFED00000-0xFED003FF

### Device Hiding
- **XSPI**: SPI controller hidden via `pci-device-hidden` property
- **RHUB**: USB root hub disabled for USBMap.kext compatibility