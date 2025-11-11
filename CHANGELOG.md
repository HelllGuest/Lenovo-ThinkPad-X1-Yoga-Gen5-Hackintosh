# 🧭 Changelog – Lenovo ThinkPad X1 Yoga Gen 5 Hackintosh

All notable changes to this Hackintosh EFI are documented here in semantic format.

---

## [1.0.6] – 2025-11-11
**macOS Ventura 13.7.8 – OpenCore 1.0.6**

```yaml
Changes:
  - Updated OpenCore to 1.0.6 (ACDT 2025-10)
  - Improved CPU power management for i7-10610U
  - Rebuilt USB mapping using USBToolBox (v3 schema)
  - Optimized SSDT-YOGA for YogaSMC sensor handling
  - Reworked ACPI hotpatch for _PTS/_WAK consistency
  - Improved fan control profiles in YogaSMC
  - Verified FileVault boot with full graphics acceleration
Fixes:
  - Corrected ALC285 layout ID mismatch
  - Fixed wake issue on lid open
  - Resolved NVRAM persistence under OC Quirks
Removed:
  - Legacy VoodooInput.kext
Notes:
  - Tested on BIOS 1.40
  - CFG Lock cannot be disabled (AppleXcpmCfgLock quirk enabled)
  - Recommended SMBIOS: MacBookPro16,3
  - Sleep mode must be set to "Linux" in BIOS
  - Based on AlexFullmoon's original project
```

---

## [1.0.5] – 2025-09-07

**macOS Ventura 13.6 – OpenCore 1.0.5**

```yaml
Changes:
  - Initial stable EFI release
  - Full support for Intel AX201 WiFi/BT
  - Optimized SSDT-EC, SSDT-PLUG, SSDT-USBX mappings
  - Implemented YogaSMC and VirtualSMC sensor suite
  - Verified sleep/wake, FileVault, and iServices
```

---

## [Unreleased]

```yaml
Planned:
  - macOS Sequoia support validation
  - Refined Thunderbolt 3 hotplug (SSDT-TB3)
  - AppleALC 1.9.x integration test
```