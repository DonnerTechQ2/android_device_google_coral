# Building AviumUI for flame/coral (Pixel 4/XL)
(tested only for flame)

## System Requirements
- **Storage:** 600+ GB of free space
- **RAM:** 32 GB (64 GB recommended)
- **CPU:** 16+ threads

## 1. Server Preparation

Install necessary packages (for Ubuntu/Debian):
```bash
apt update && apt upgrade -y
apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick protobuf-compiler python3-protobuf lib32readline-dev lib32z1-dev libdw-dev libelf-dev libgnutls28-dev lz4 libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc xxd zip zlib1g-dev python-is-python3
```

Install `repo` and configure Git:
```bash
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH="$HOME/bin:$PATH"

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git lfs install
```

*(Optional) Configure ccache to speed up recompilation:*
```bash
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
```

## 2. Initialize Avium Sources

```bash
mkdir -p ~/android/avium
cd ~/android/avium
repo init -u https://github.com/AviumUI/android_manifests -b avium-16.2 --git-lfs
```

## 3. Local Manifest Configuration

Create a directory for manifests:
```bash
mkdir -p .repo/local_manifests
nano .repo/local_manifests/flame.xml
```

Copy the links to the prepared repositories into `flame.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="DonnerTechQ2/android_device_google_coral" path="device/google/coral" remote="github" revision="avium-16.2" />
  <project name="DonnerTechQ2/android_kernel_google_msm-4.14-erofspatches" path="kernel/google/msm-4.14" remote="github" revision="lineage-23.2" />
  <project name="LineageOS/android_packages_apps_ElmyraService" path="packages/apps/ElmyraService" remote="github" revision="lineage-23.2" />
  <project name="TheMuppets/proprietary_vendor_google_flame" path="vendor/google/flame" remote="github" revision="lineage-23.2" />
</manifest>
```

## 4. Sync Sources

```bash
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```
*Note: You may need to run this command again if you encounter an error due to rate limiting.*

## 4.1. Download Avium GMS
```bash
avium get_gms
```

## 5. Build the ROM

```bash
cd ~/android/avium
source build/envsetup.sh
lunch lineage_flame-bp4a-userdebug
m bacon -j$(nproc --all)
```

The finished firmware file will be located in the `out/target/product/flame/` directory.

## Known Issues

- The battery statistics section is practically non-functional.

## Installation Instructions

For detailed installation instructions, please refer to the [LineageOS Install Guide for flame](https://wiki.lineageos.org/devices/flame/install/).

## Credits

- [AviumUI](https://aviumui.org/)
- [LineageOS Build Guide for flame](https://wiki.lineageos.org/devices/flame/build/) (partially referenced for this guide)
