# 🧰 Troubleshooting – X1 Yoga Gen 5

## Sleep/Wake Issues
- Ensure `HibernationFixup.kext` is loaded
- Check `RTCMemoryFixup.kext` is enabled
- Boot args include `rtcfx_exclude=80-AB`
- Remove external USB devices blocking sleep
- Verify HPET IRQ patches are applied in SSDT-ALL

## Audio Not Working
- Layout ID 71 is set via DeviceProperties in config.plist at `PciRoot(0x0)/Pci(0x1f,0x3)`
- Ensure AppleALC.kext is loaded
- Check device-id is set correctly for ALC285
- Rebuild kext cache:
```bash
sudo kextcache -i /
```

## Trackpad/TrackPoint Issues
- Ensure VoodooI2C, VoodooI2CHID, and VoodooRMI are loaded
- Check SSDT-ALL sets `TPDM = 0` and `OSYS = 0x07DF` for TPD0
- Verify I2C device is enabled in BIOS

## Brightness Control Not Working
- PNLF device in SSDT-ALL should be loaded
- Check BrightnessKeys.kext is enabled
- Verify WhateverGreen.kext is loaded
- Intel UHD 620 framebuffer patches in DeviceProperties

## Wi-Fi Issues
- Correct `AirportItlwm.kext` version for macOS Ventura
- Ensure IntelBluetoothFirmware and IntelBTPatcher are loaded
- Remove old network interfaces in System Settings → Network

## Battery Not Showing
- Check SMCBatteryManager.kext is loaded
- Verify EC patches (RECB/WECB methods) in SSDT-ALL
- Ensure ECEnabler.kext is enabled
- BAT1 device should be present under EC

## USB Issues
- RHUB is disabled in SSDT-ALL for USBMap.kext
- Verify USBToolBox.kext and USBMap.kext are loaded
- Check USB power is set via USBX in SSDT-ALL (5100mA)

## NVRAM Issues
- Reset NVRAM from OpenCore picker
- Check `RequestBootVarRouting = True` in UEFI Quirks
- Verify boot-args are saved: `rtcfx_exclude=80-AB revpatch=sbvmm`

## YogaSMC/ThinkPad Features
- Ensure YogaSMC.kext is loaded
- Check HKEY device in SSDT-ALL has `OSYS = 0x07DF`
- Verify EC patches are working (ESEN region)

## BIOS Settings Issues

### Required BIOS Settings
If experiencing boot issues, verify these critical settings:

**Must be Disabled:**
- Secure Boot (clear all keys if needed)
- Vt-d (or enable DisableIOMapper quirk)
- Enhanced Windows Biometrics
- Intel SGX
- Device Guard
- CSM Support

**Must be Enabled/Set:**
- UEFI mode (not Legacy)
- Sleep mode set to "Linux" (not Windows)

**Recommended to Disable:**
- Wake-on-LAN
- UEFI network stack
- Thunderbolt BIOS Assist mode
- Thunderbolt Security
- Thunderbolt Preboot
- Intel AMT
- Fingerprint predesktop
- Kernel DMA
- Unused IO ports (WWAN, fingerprint)

### CFG Lock Warning
- **Cannot be disabled** in standard BIOS menu on X1 Yoga Gen 5
- Located in engineering menu (not accessible)
- Standard unlock methods (modified GRUB, RU.efi) **do not work**
- Direct BIOS write with programmer clip is possible but **dangerous** (breaks TPM)
- This EFI uses `AppleXcpmCfgLock = True` quirk as workaround
- Do not attempt to unlock CFG unless you know what you're doing

## T
hunderbolt 3 Issues

### External Display Not Working
- Verify Thunderbolt controller appears in System Information → Thunderbolt
- Check cable supports DisplayPort Alt Mode
- Try different USB-C port (both ports support TB3)
- Ensure Thunderbolt Security is disabled in BIOS

### eGPU Not Detected
- eGPU support is **untested** with current EFI
- May require SSDT-TB.aml patch (not included by default)
- Check if eGPU is compatible with macOS (AMD GPUs recommended)
- Ensure Thunderbolt Security is disabled in BIOS
- Try connecting eGPU before boot

### Thunderbolt Device Not Recognized
- Current EFI has basic TB3 support only
- Advanced hotplug requires SSDT-TB.aml (optional, untested)
- Some TB3 devices may require additional configuration
- Check device compatibility with macOS

### Enabling SSDT-TB (Optional)

`SSDT-TB.aml` is already compiled and present in `EFI/OC/ACPI/` but **disabled by default**.

To enable advanced Thunderbolt support:

1. Mount EFI partition
2. Open `config.plist` with ProperTree
3. Navigate to `ACPI → Add`
4. Add new dictionary entry:
   - Comment: `Thunderbolt 3 Alpine Ridge Support`
   - Enabled: `True`
   - Path: `SSDT-TB.aml`
5. Save and reboot

**What this enables:**
- Full Thunderbolt 3 device tree (Intel JHL6540 Alpine Ridge)
- Proper hotplug support for TB3 devices
- USB 3.1 controller (XHC2) with 2 USB-C ports
- ThunderboltDROM configuration
- Better eGPU compatibility (untested)

**Warning:** This patch is experimental. DisplayPort output works without it. Enable only if you need advanced TB3 features or experience issues with TB3 devices.