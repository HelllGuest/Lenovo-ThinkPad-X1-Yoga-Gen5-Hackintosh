# 🖥️ Hardware Compatibility – X1 Yoga Gen 5

## ✅ Confirmed Working

| Component | Notes | Implementation |
|------------|--------|----------------|
| Wi-Fi (Intel AX201) | Wi-Fi 6 speeds | AirportItlwm.kext |
| Bluetooth 5.1 | Full LE support | IntelBluetoothFirmware + IntelBTPatcher + BlueToolFixup |
| Audio (ALC285) | All outputs working | AppleALC.kext (Layout ID 71 via DeviceProperties) |
| Trackpad (I2C) | Multi-touch gestures | VoodooI2C + VoodooI2CHID |
| TrackPoint | Full support | VoodooRMI + RMII2C |
| Keyboard | All keys working | VoodooPS2Controller |
| Battery | Accurate readings | SMCBatteryManager + EC patches in SSDT-ALL |
| Brightness | Smooth control | PNLF in SSDT-ALL + BrightnessKeys.kext |
| Ambient Light | Auto brightness | ALS0 in SSDT-ALL + SMCLightSensor |
| USB Ports | All functional | USBToolBox + USBMap.kext (RHUB disabled) |
| Ethernet | Via adapter | IntelMausi.kext |
| NVMe SSD | Optimized | NVMeFix.kext |
| CPU Power | Native PM | PLUG _DSM in SSDT-ALL |
| Sleep/Wake | Stable | HibernationFixup + RTCMemoryFixup |
| ThinkPad Features | Fan, sensors, HKEY | YogaSMC.kext + EC HKEY in SSDT-ALL |

---

## ⚠️ Partial or Unsupported

| Component | Notes |
|------------|--------|
| Touchscreen | Basic touch only (no gestures) |
| Fingerprint Reader | Unsupported in macOS |
| Thunderbolt 3 | Controller visible, DP works, advanced features untested |
| eGPU | Untested (requires SSDT-TB.aml) |
| TB3 Hotplug | Limited (requires SSDT-TB.aml) |


---

## 🔧 BIOS Configuration

### Critical Settings (Required)

| Setting | Location | Value | Reason |
|---------|----------|-------|--------|
| Sleep mode | Power | **Linux** | Required for proper sleep/wake |
| Secure Boot | Security | **Disabled** | macOS incompatible |
| Vt-d | Virtualization | **Disabled** | Or use DisableIOMapper quirk |
| Enhanced Windows Biometrics | Virtualization | **Disabled** | macOS incompatible |
| Intel SGX | IO Ports | **Disabled** | Security feature conflicts |
| Device Guard | IO Ports | **Disabled** | Windows security feature |
| UEFI/Legacy | Startup | **UEFI** | Legacy not supported |
| CSM Support | Startup | **Disabled** | UEFI-only mode |

### Recommended Settings

| Setting | Location | Value | Reason |
|---------|----------|-------|--------|
| Wake-on-LAN | Config → Network | Disabled | Prevents unwanted wake |
| UEFI network stack | Config → Network | Disabled | Not needed |
| Thunderbolt BIOS Assist | Thunderbolt | Disabled | Better compatibility |
| Thunderbolt Security | Thunderbolt | Disabled | Simplifies setup |
| Thunderbolt Preboot | Thunderbolt | Disabled | Not needed |
| Intel AMT | Thunderbolt | Disabled | Not used |
| Fingerprint predesktop | Security | Disabled | Not supported in macOS |
| Kernel DMA | Virtualization | Disabled | Better compatibility |
| WWAN | IO Ports | Disabled | If not using cellular |
| Fingerprint | IO Ports | Disabled | If macOS-only |

### ⚠️ CFG Lock Status

**Important:** CFG Lock **cannot be disabled** on X1 Yoga Gen 5 through standard BIOS menu.

- Located in hidden engineering menu
- Standard unlock methods (modified GRUB, RU.efi) **do not work**
- Direct BIOS write with programmer clip possible but **dangerous**:
  - Requires hardware programmer and clip
  - Risk of bricking motherboard
  - **Breaks TPM** functionality
  - Voids warranty

**Solution:** This EFI uses `AppleXcpmCfgLock = True` kernel quirk to work around locked CFG. No BIOS modification needed.

### BIOS Version

- **Current tested:** 1.40
- **Previously tested:** 1.31+
- **Recommended:** Keep BIOS updated to latest stable version
- **Download:** [Lenovo Support Site](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x1-yoga-gen-5-type-20ub-20uc/downloads/driver-list/)
- **Note:** BIOS updates may reset settings - verify all settings after update

---

## ⚡ Thunderbolt 3 Support

### Current Status

**Working:**
- Thunderbolt 3 controller visible in System Information
- External displays via USB-C/Thunderbolt ports (DisplayPort mode)
- USB-C data transfer
- Hotplug external monitors

**Untested/Limited:**
- eGPU (external graphics card)
- Thunderbolt 3 storage devices
- Thunderbolt 3 docks with advanced features
- Daisy-chaining multiple TB3 devices

### Hardware Details

- **Controller:** Intel JHL6540 Alpine Ridge Thunderbolt 3 (Low Power)
- **Ports:** 2x USB-C with Thunderbolt 3 support
- **Location:** PCI Root Port 13 (RP13)

### Optional SSDT-TB Patch

An optional `SSDT-TB.aml` file is **included but disabled by default**:

**What it does:**
- Creates full Thunderbolt 3 device tree for RP13
- Adds UPSB (Upstream Bridge) and DSB0-6 (Downstream Bridge) devices
- Implements NHI0 (Native Host Interface) controller
- Configures XHC2 (USB 3.1 controller) for TB3 ports with 2 USB-C ports
- Adds ThunderboltDROM and ThunderboltConfig properties
- Enables proper device removal status (_RMV) for hotplug
- Implements DTGP method for device properties

**Device Tree:**
```
RP13 (Root Port 13)
└── UPSB (Upstream Bridge)
    ├── DSB0 (Downstream Bridge 0)
    │   └── NHI0 (Thunderbolt Controller)
    ├── DSB1 (Downstream Bridge 1) - Hotplug capable
    ├── DSB2 (Downstream Bridge 2)
    │   └── XHC2 (USB 3.1 Controller)
    │       └── RHUB (Root Hub)
    │           ├── SSP1 (USB-C Port 1)
    │           └── SSP2 (USB-C Port 2)
    └── DSB4 (Downstream Bridge 4) - Hotplug capable
```

**To enable:**
1. Open `config.plist` with ProperTree or text editor
2. Navigate to `ACPI → Add`
3. Add new entry:
```xml
<dict>
    <key>Comment</key>
    <string>Thunderbolt 3 Alpine Ridge Support</string>
    <key>Enabled</key>
    <true/>
    <key>Path</key>
    <string>SSDT-TB.aml</string>
</dict>
```
4. Save and reboot

**Current Status:**
- ✅ File compiled and present in `EFI/OC/ACPI/SSDT-TB.aml`
- ❌ Not enabled in config.plist (disabled by default)
- ⚠️ Requires testing with actual TB3 devices (eGPU, TB3 storage, TB3 docks)
- ✅ DisplayPort output works without this patch

**Note:** This patch is experimental. Basic DisplayPort functionality works without it. Enable only if you need advanced Thunderbolt features or have issues with TB3 devices.

### Thunderbolt BIOS Settings

For best Thunderbolt compatibility:
- Thunderbolt BIOS Assist mode → Disabled
- Thunderbolt Security → Disabled (or set to "No Security")
- Thunderbolt Preboot → Disabled
- Intel VT-d → Disabled (or use DisableIOMapper quirk)
