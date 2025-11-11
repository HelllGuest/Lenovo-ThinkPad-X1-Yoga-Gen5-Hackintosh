# ⚙️ OpenCore Config Reference – Lenovo ThinkPad X1 Yoga Gen 5

Detailed overview of `config.plist` sections used in this EFI.

---

## ACPI

| Section | Purpose | Included |
|----------|----------|-----------|
| SSDT-ALL.aml | Combined ACPI patches | ✅ |
| - _OSI Darwin | macOS detection | ✅ |
| - PLUG (_DSM) | CPU power management (PR00) | ✅ |
| - USBX | USB power (5100mA) | ✅ |
| - PNLF | Backlight (Intel UHD 620) | ✅ |
| - ALS0 | Ambient light sensor | ✅ |
| - PWRB | Power button device | ✅ |
| - MCHC/PGMM/PMCR/SRAM/XSPI | System devices | ✅ |
| - BUS0/DVL0 | SMBus devices | ✅ |
| - DMAC | DMA controller | ✅ |
| - HPET | IRQ 0,8,11 fixes | ✅ |
| - EC Patches | Battery + HKEY support | ✅ |
| - RHUB Disable | For USBMap.kext | ✅ |

### ACPI Patches (config.plist)
| Patch | Description |
|-------|-------------|
| HPET _STA → XSTA | Rename for HPET override |
| HPET _CRS → XCRS | Rename for IRQ fixes |
| IPIC IRQ 2 Patch | IRQ conflict resolution |
| RTC IRQ 8 Patch | RTC IRQ fix |
| TIMR IRQ 0 Patch | Timer IRQ fix |

---

## Booter

| Setting | Description | Value |
|----------|--------------|-------|
| Quirks -> AvoidRuntimeDefrag | Runtime memory fix | True |
| Quirks -> RebuildAppleMemoryMap | Memory map rebuild | True |
| Quirks -> SetupVirtualMap | Memory mapping fix | True |
| Quirks -> SyncRuntimePermissions | Runtime permissions | True |

---

## DeviceProperties

| Path | Property | Description |
|------|-----------|-------------|
| PciRoot(0x0)/Pci(0x2,0x0) | AAPL,ig-platform-id | 0000528A |
| framebuffer-patch-enable | GPU framebuffer patch | True |
| device-id | GPU spoof | 8A52 |

---

## Kernel

| Type | Kexts | Description |
|------|-------|-------------|
| Core | Lilu, VirtualSMC | Essential framework |
| Graphics | WhateverGreen | Intel UHD 620 acceleration |
| Audio | AppleALC | Realtek ALC285 support |
| Input | VoodooI2C, VoodooI2CHID, VoodooPS2Controller, VoodooRMI | Trackpad, keyboard, TrackPoint |
| Networking | AirportItlwm, IntelBluetoothFirmware, IntelBTPatcher, BlueToolFixup, IntelMausi | Wi-Fi 6 AX201 + Bluetooth + Ethernet |
| Power & Sensors | SMCBatteryManager, SMCProcessor, SMCSuperIO, SMCLightSensor, YogaSMC, BrightnessKeys, ECEnabler | Battery, sensors, fan control |
| Sleep & Hibernation | HibernationFixup, RTCMemoryFixup | Sleep/wake stability |
| Storage | NVMeFix | NVMe SSD optimization |
| USB | USBToolBox, USBMap | Custom USB port mapping |
| System | RestrictEvents | System compatibility patches |

### Kernel Quirks

| Quirk | Value | Reason |
|-------|-------|--------|
| AppleXcpmCfgLock | True | CFG Lock cannot be disabled in BIOS |
| CustomSMBIOSGuid | True | Required for Windows dual-boot |
| DisableIoMapper | True | Vt-d disabled in BIOS (recommended) |
| DisableLinkeditJettison | True | Lilu compatibility |
| PanicNoKextDump | True | Reduce panic log size |
| PowerTimeoutKernelPanic | True | Fix power state timeout |

---

## Misc

| Section | Setting | Description |
|----------|----------|-------------|
| Boot | PickerMode | External |
| Boot | ShowPicker | True |
| Debug | Target | 67 (verbose + SysReport) |
| Security | ScanPolicy | 0 (all bootable entries) |

---

## NVRAM

| Variable | Description | Example |
|-----------|-------------|----------|
| boot-args | Kernel arguments | rtcfx_exclude=80-AB revpatch=sbvmm |
| - rtcfx_exclude | RTC memory exclusion | Prevents RTC conflicts (0x80-0xAB) |
| - revpatch=sbvmm | Restrict Events patch | VMM board ID spoofing |
| csr-active-config | SIP state | 00000000 |
| prev-lang:kbd | Language | en-US:0 |

---

## PlatformInfo

| Setting | Description | Example |
|----------|-------------|----------|
| SMBIOS | System definition | MacBookPro16,3 |
| SerialNumber | Unique serial | Custom |
| MLB | Logic board ID | Custom |
| ROM | Last 6 bytes of MAC | Custom |

---

## UEFI

| Section | Setting | Description |
|----------|----------|-------------|
| Drivers | OpenRuntime.efi, HfsPlus.efi | Boot drivers |
| Input | KeySupport | True |
| Output | ProvideConsoleGop | True |
| Quirks | RequestBootVarRouting | True |

---


## OpenCore Configuration Notes

### Building Your Own Config

**Important:** Use the provided config as reference only. Follow the [Dortania OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/) to build your own config for the current OpenCore version.

### Key Configuration Details

#### ACPI
- **Add:** All SSDTs (SSDT-ALL.aml required, SSDT-TB.aml optional)
- **Delete:** Consider dropping DMAR table if using that method
- **Quirks:** None required

#### Booter/Quirks
- `DevirtualiseMmio`: **False** (unnecessary for this system)
- `EnableSafeModeSlide`: **False** (seems necessary, causes long boot time if disabled)
- `ProvideCustomSlide`: **False** (related to EnableSafeModeSlide)
- `AvoidRuntimeDefrag`: **True**
- `RebuildAppleMemoryMap`: **True**
- `SetupVirtualMap`: **True**
- `SyncRuntimePermissions`: **True**

#### DeviceProperties
- **Audio:** `PciRoot(0x0)/Pci(0x1f,0x3)` - Realtek ALC285
- **Video:** `PciRoot(0x0)/Pci(0x2,0x0)` - Intel UHD 620 (standard location)

#### Kernel/Quirks
- `AppleXcpmCfgLock`: **True** (CFG Lock cannot be disabled in BIOS)
- `AppleCpuPmCfgLock`: **False** (not needed with AppleXcpmCfgLock)
- `CustomSMBIOSGuid`: **True** (for multiboot configuration)
  - Set to **False** if using macOS only
- `DisableIoMapper`: **True** (required unless Vt-d disabled in BIOS)
  - Recommended for multiboot configuration
- `DisableLinkeditJettison`: **True**
- `PanicNoKextDump`: **True**
- `PowerTimeoutKernelPanic`: **True**

#### Kext Load Order
See comments in config.plist for proper kext loading order. Critical order:
1. Lilu.kext (must load first)
2. VirtualSMC.kext
3. Lilu plugins (WhateverGreen, AppleALC, etc.)
4. VoodooI2C dependencies before VoodooI2C
5. Plugin kexts after parent kexts

#### Misc/Boot
- `LauncherOption`: **Disabled** for installer or macOS-only
  - Set to **Full** for multiboot configuration
- `PickerMode`: **External**
- `ShowPicker`: **True**

#### Misc/Security
- `ScanPolicy`: **0x00280303** (NVMe + USB drives, Apple FS only)
  - For OpenLinuxBoot: **0x00284303** (adds Linux bootloader partition)
- `SecureBootModel`: 
  - **Disabled** for installing/updating Sonoma (certain versions)
  - **j223** for normal use (specific to MacBookPro16,3 SMBIOS)
  - See [Dortania SecureBoot Guide](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#securebootmodel)

#### NVRAM/Boot-args
- `rtcfx_exclude=80-AB`: Required for hibernation (RTCMemoryFixup)
- `revpatch=sbvmm`: RestrictEvents option, required for Sonoma+ upgrades
- Debug configs include additional debugging boot-args

#### NVRAM/Additional
- UUID `E09B9297-7928-4440-9AAB-D1F8536FBF0A`: HibernationFixup configuration
  - `hbfx-ahbm`: 56 (0x38)

#### PlatformInfo
- `UpdateSMBIOSMode`: **Custom** for multiboot configuration
  - Set to **Create** if using macOS only
- `SystemProductName`: **MacBookPro16,3**
- Generate unique serials with [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

#### UEFI/ReservedMemory
- One memory region reserved (apparently required for hibernation)
- Check config.plist for specific address range

### Config Variants

This EFI may include different config variants:
- **config.plist**: Production config (minimal debug)
- **config_debug.plist**: Debug config (verbose logging, boot picker)
- **config_installer.plist**: Installer config (standard debugging boot-args)

Main differences:
- Debug options enabled/disabled
- Boot picker interface settings
- Logging verbosity

### Multiboot Configuration

If dual-booting with Windows/Linux:
- `CustomSMBIOSGuid`: **True**
- `UpdateSMBIOSMode`: **Custom**
- `LauncherOption`: **Full**
- `DisableIoMapper`: **True** (recommended)
- Consider `ScanPolicy` settings for other OS visibility

### macOS-Only Configuration

If using macOS exclusively:
- `CustomSMBIOSGuid`: **False**
- `UpdateSMBIOSMode`: **Create**
- `LauncherOption`: **Disabled**
- `SecureBootModel`: **j223**

---

## Configuration Tools

### Recommended
- **[ProperTree](https://github.com/corpnewt/ProperTree)** - Plist editor (cross-platform)
- **[GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)** - Generate SMBIOS data
- **[MountEFI](https://github.com/corpnewt/MountEFI)** - Mount EFI partitions
- **[OCConfigCompare](https://github.com/corpnewt/OCConfigCompare)** - Compare configs

### Optional
- **[OpenCore Configurator](https://mackie100projects.altervista.org/opencore-configurator/)** - GUI editor (macOS only)
- **[OCAT](https://github.com/ic005k/OCAuxiliaryTools)** - All-in-one tool (cross-platform)
- **[Kext Updater](https://www.sl-soft.de/kext-updater/)** - Update kexts (macOS only)

---

## Important Warnings

⚠️ **Never use someone else's SMBIOS data** - Generate your own with GenSMBIOS

⚠️ **Always backup working EFI** before making changes

⚠️ **Test changes on USB** before copying to main EFI partition

⚠️ **Follow Dortania guide** for OpenCore updates - don't just replace files
